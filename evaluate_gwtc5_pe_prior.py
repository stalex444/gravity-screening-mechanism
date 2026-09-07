#!/usr/bin/env python3
"""Add ICAROGW's marginal PE-prior density to a compact GWTC-5 event.

For ordinary Bilby events the density is evaluated from the prior descriptions
preserved by prepare_gwtc5_inputs.py. For the seven events explicitly marked in
the official catalog as having uniform detector-frame component-mass and dL^2
priors, the equivalent density dL^2 is used up to an event-wise constant. Such
constants cancel in a fixed-catalog evidence difference between propagation
models.
"""

from __future__ import annotations

import argparse
import importlib.metadata
import json
import os
from pathlib import Path
import tempfile

EXPECTED_VERSIONS = {
    "bilby": "2.6.0",
    "numpy": "2.3.5",
    "astropy": "7.2.0",
}
SPECIAL_PRIOR_KIND = "m1d_m2d_uniform_dL_square_PE_priors"
GW_PRIOR_CLASSES = (
    "UniformInComponentsChirpMass",
    "UniformInComponentsMassRatio",
    "UniformSourceFrame",
    "UniformComovingVolume",
)
REQUIRED_ARRAYS = ("mass_1", "mass_2", "luminosity_distance")


def installed_versions() -> dict[str, str]:
    versions = {}
    for package in EXPECTED_VERSIONS:
        versions[package] = importlib.metadata.version(package)
    return versions


def check_versions(allow_mismatch: bool) -> dict[str, str]:
    versions = installed_versions()
    mismatches = [
        f"{name}: expected {expected}, observed {versions[name]}"
        for name, expected in EXPECTED_VERSIONS.items()
        if versions[name] != expected
    ]
    if mismatches and not allow_mismatch:
        raise RuntimeError(
            "Scientific-stack version mismatch:\n  " + "\n  ".join(mismatches)
            + "\nUse the pinned requirements or pass --allow-version-mismatch for diagnostics only."
        )
    return versions


def qualify_gw_prior(description: str) -> str:
    stripped = description.lstrip()
    for class_name in GW_PRIOR_CLASSES:
        if stripped.startswith(class_name + "("):
            prefix_length = len(description) - len(stripped)
            return description[:prefix_length] + "bilby.gw.prior." + stripped
    return description


def load_compact(path: Path):
    import numpy as np

    with np.load(path, allow_pickle=False) as archive:
        if "metadata_json" not in archive.files:
            raise ValueError("Compact input has no metadata_json field.")
        arrays = {
            name: np.asarray(archive[name])
            for name in archive.files
            if name != "metadata_json"
        }
        metadata = json.loads(str(archive["metadata_json"]))
    missing = sorted(set(REQUIRED_ARRAYS) - set(arrays))
    if missing:
        raise ValueError("Compact input is missing: " + ", ".join(missing))
    return arrays, metadata


def ordinary_prior(arrays: dict, metadata: dict):
    import numpy as np
    from bilby.core.prior import Constraint, PriorDict

    descriptions = metadata.get("analytic_priors") or {}
    relevant_names = (
        "chirp_mass", "mass_ratio", "mass_1", "mass_2", "luminosity_distance"
    )
    relevant = {
        name: qualify_gw_prior(descriptions[name])
        for name in relevant_names
        if name in descriptions
    }
    if "luminosity_distance" not in relevant:
        raise ValueError("No analytic luminosity-distance prior was preserved.")

    priors = PriorDict(dictionary=relevant)
    m1 = arrays["mass_1"]
    m2 = arrays["mass_2"]
    dl = arrays["luminosity_distance"]

    if "chirp_mass" in priors and "mass_ratio" in priors:
        if "chirp_mass" not in arrays or "mass_ratio" not in arrays:
            raise ValueError("Mass-prior reconstruction requires chirp_mass and mass_ratio samples.")
        mc = arrays["chirp_mass"]
        q = arrays["mass_ratio"]
        # |d(Mc,q)/d(m1,m2)| = Mc/m1^2.
        mass_density = priors["chirp_mass"].prob(mc) * priors["mass_ratio"].prob(q)
        mass_density = mass_density * mc / np.square(m1)
        mass_method = "sampled (chirp_mass,mass_ratio), transformed with |d(Mc,q)/d(m1,m2)|=Mc/m1^2"
    elif (
        "mass_1" in priors and "mass_2" in priors
        and not isinstance(priors["mass_1"], Constraint)
        and not isinstance(priors["mass_2"], Constraint)
    ):
        mass_density = priors["mass_1"].prob(m1) * priors["mass_2"].prob(m2)
        mass_method = "sampled detector-frame component masses"
    else:
        raise ValueError("Unsupported mass-prior coordinates in analytic metadata.")

    for name, values in (("mass_1", m1), ("mass_2", m2)):
        prior = priors.get(name)
        if isinstance(prior, Constraint):
            mass_density = mass_density * prior.prob(values)

    distance_density = priors["luminosity_distance"].prob(dl)
    density = mass_density * distance_density
    method = mass_method + "; " + type(priors["luminosity_distance"]).__name__
    return np.asarray(density), method, "Bilby-normalized density in (m1,m2,dL)"


def evaluate(arrays: dict, metadata: dict):
    import numpy as np

    prior_kind = metadata.get("pe_prior_kind")
    if prior_kind == SPECIAL_PRIOR_KIND:
        density = np.square(arrays["luminosity_distance"])
        method = "official catalog marker: uniform detector-frame component masses and dL^2"
        normalization = "event-wise positive constant omitted; cancels from fixed-catalog evidence differences"
    elif prior_kind:
        raise ValueError(f"Unsupported official pe_prior_kind {prior_kind!r}.")
    else:
        density, method, normalization = ordinary_prior(arrays, metadata)

    if density.ndim != 1:
        raise ValueError("Prior density is not one-dimensional.")
    expected_length = len(arrays["luminosity_distance"])
    if len(density) != expected_length:
        raise ValueError("Prior density length differs from the posterior sample count.")
    if not np.isfinite(density).all() or not (density > 0).all():
        raise ValueError("Prior density contains a non-finite or non-positive value.")
    return density, method, normalization


def write_output(path: Path, arrays: dict, metadata: dict) -> None:
    import numpy as np

    path.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(suffix=".npz", dir=path.parent, delete=False) as handle:
        temporary = Path(handle.name)
    try:
        np.savez_compressed(
            temporary,
            **arrays,
            metadata_json=np.asarray(json.dumps(metadata, sort_keys=True)),
        )
        os.replace(temporary, path)
    finally:
        try:
            temporary.unlink()
        except FileNotFoundError:
            pass


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser(description=__doc__)
    result.add_argument("input", type=Path, help="Compact event NPZ from prepare_gwtc5_inputs.py")
    result.add_argument("--output", type=Path, help="Output NPZ; defaults to EVENT.with-prior.npz")
    result.add_argument("--allow-version-mismatch", action="store_true")
    return result


def main() -> int:
    args = parser().parse_args()
    versions = check_versions(args.allow_version_mismatch)
    arrays, metadata = load_compact(args.input)
    density, method, normalization = evaluate(arrays, metadata)
    arrays["prior"] = density
    metadata["columns"] = list(arrays)
    metadata["prior_density_status"] = "evaluated"
    metadata["prior_density_method"] = method
    metadata["prior_density_normalization"] = normalization
    metadata["prior_density_versions"] = versions
    output = args.output or args.input.with_name(args.input.stem + ".with-prior.npz")
    write_output(output, arrays, metadata)
    print(f"{metadata['event']}: wrote {len(density):,} positive prior values to {output}")
    print(f"  method: {method}")
    print(f"  range: [{density.min():.16g}, {density.max():.16g}]")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
