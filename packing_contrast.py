#!/usr/bin/env python3
"""Finite tetrahedral packing contrast for phi, rho, and Q.

The points are kept exactly as triples of coefficient vectors in Z[theta],
with theta^degree = theta + 1.  Floating-point coordinates are used only for
the nearest-neighbour search; the reported closest distance is recomputed at
80 decimal digits from the exact coefficient difference.
"""

from __future__ import annotations

import argparse
import csv
from pathlib import Path

import mpmath as mp
import numpy as np
from scipy.spatial import cKDTree


DIGITS = (
    (0, 0, 0),
    (1, 1, 1),
    (1, -1, -1),
    (-1, 1, -1),
    (-1, -1, 1),
)


def multiply_by_theta(coefficients: tuple[int, ...]) -> tuple[int, ...]:
    """Reduce theta * coefficients using theta^d = theta + 1."""
    degree = len(coefficients)
    top = coefficients[-1]
    result = [0] * degree
    result[0] = top
    result[1] = coefficients[0] + top
    for index in range(2, degree):
        result[index] = coefficients[index - 1]
    return tuple(result)


def exact_powers(degree: int, max_depth: int) -> list[tuple[int, ...]]:
    power = (1,) + (0,) * (degree - 1)
    powers = [power]
    for _ in range(max_depth):
        power = multiply_by_theta(power)
        powers.append(power)
    return powers


def add_digit(
    point: tuple[int, ...], digit: tuple[int, int, int],
    power: tuple[int, ...], degree: int,
) -> tuple[int, ...]:
    result = list(point)
    for axis in range(3):
        offset = axis * degree
        multiplier = digit[axis]
        if multiplier:
            for basis_index, coefficient in enumerate(power):
                result[offset + basis_index] += multiplier * coefficient
    return tuple(result)


def evaluate_points(
    points: list[tuple[int, ...]], theta: float, degree: int,
) -> np.ndarray:
    basis = np.array([theta**index for index in range(degree)])
    coefficient_array = np.asarray(points, dtype=float).reshape(-1, 3, degree)
    return coefficient_array @ basis


def exact_distance(
    first: tuple[int, ...], second: tuple[int, ...],
    theta: mp.mpf, degree: int,
) -> mp.mpf:
    squared = mp.mpf("0")
    for axis in range(3):
        coordinate = mp.mpf("0")
        offset = axis * degree
        for basis_index in range(degree):
            difference = first[offset + basis_index] - second[offset + basis_index]
            coordinate += difference * theta**basis_index
        squared += coordinate**2
    return mp.sqrt(squared)


def analyze_root(label: str, degree: int, max_depth: int) -> list[dict[str, str]]:
    mp.mp.dps = 80
    theta_mp = mp.findroot(lambda x: x**degree - x - 1, (mp.mpf("1"), mp.mpf("2")))
    theta = float(theta_mp)
    powers = exact_powers(degree, max_depth)
    zero = (0,) * (3 * degree)
    points = {zero}
    rows: list[dict[str, str]] = []

    for depth in range(max_depth + 1):
        power = powers[depth]
        points = {
            add_digit(point, digit, power, degree)
            for point in points
            for digit in DIGITS
        }
        exact_points = sorted(points)
        coordinates = evaluate_points(exact_points, theta, degree)
        tree = cKDTree(coordinates)
        distances, indices = tree.query(coordinates, k=2)
        closest_index = int(np.argmin(distances[:, 1]))
        neighbour_index = int(indices[closest_index, 1])
        minimum_distance = exact_distance(
            exact_points[closest_index], exact_points[neighbour_index],
            theta_mp, degree,
        )
        maximum_radius = float(np.linalg.norm(coordinates, axis=1).max())
        rows.append(
            {
                "root": label,
                "degree": str(degree),
                "depth": str(depth),
                "raw_words": str(5 ** (depth + 1)),
                "distinct_points": str(len(exact_points)),
                "minimum_distance": mp.nstr(minimum_distance, 30),
                "maximum_radius": f"{maximum_radius:.17g}",
            }
        )
        print(
            f"{label:3s} depth={depth} distinct={len(exact_points):8d} "
            f"min={mp.nstr(minimum_distance, 12)} radius={maximum_radius:.6g}"
        )
    return rows


def write_plot(rows: list[dict[str, str]], output: Path) -> None:
    import matplotlib.pyplot as plt

    figure, axis = plt.subplots(figsize=(7.2, 4.5))
    for label, color in (
        ("phi", "#3274a1"),
        ("rho", "#1b7f5a"),
        ("Q", "#9b3a62"),
    ):
        selected = [row for row in rows if row["root"] == label]
        depths = [int(row["depth"]) for row in selected]
        distances = [float(row["minimum_distance"]) for row in selected]
        axis.semilogy(depths, distances, marker="o", linewidth=2, color=color, label=label)
    axis.set_xlabel("finite refinement depth m")
    axis.set_ylabel("minimum separation in Λₘ(θ)")
    axis.set_title("Tetrahedral self-similar packing: Pisot controls versus non-Pisot Q")
    axis.grid(True, which="both", alpha=0.25)
    axis.legend()
    figure.tight_layout()
    figure.savefig(output, dpi=180)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-depth", type=int, default=7)
    parser.add_argument("--csv", type=Path, default=Path("packing_contrast.csv"))
    parser.add_argument("--plot", type=Path, default=Path("packing_contrast.png"))
    args = parser.parse_args()

    rows = analyze_root("phi", 2, args.max_depth)
    rows.extend(analyze_root("rho", 3, args.max_depth))
    rows.extend(analyze_root("Q", 4, args.max_depth))
    with args.csv.open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)
    write_plot(rows, args.plot)


if __name__ == "__main__":
    main()
