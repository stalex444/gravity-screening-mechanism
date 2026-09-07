# Exact GWTC-5 test of quartic transport

## The sharp hypothesis

The fixed quartic prediction is

\[
\frac{D_L^{\rm GW}(z)}{D_L^{\rm EM}(z)}=(1+z)^{\beta_Q},
\qquad
\beta_Q=
\frac{\log\!\left(Q/\sqrt{2Q-1}\right)}{\log Q}
=0.08333758478067765\ldots,
\]

where \(Q>1\) is the real root of \(Q^4-Q-1=0\). General relativity is the
sharp comparison value \(\epsilon_0=0\).

The GWTC-5 result files record ICAROGW version 2.0.3. Its public `v2.0.3`
tag, commit `c473f3b2f50e11a88a46cc1625933af1f1249d39`, contains the class
`eps0_astropycosmology` with

```text
dL_GW(z) = (1+z)^eps0 dL_EM(z).
```

Its derivative is implemented as well, so ICAROGW applies the same curve to
event transformations and the selection correction. The exact PDT test is
the native ICAROGW model at the fixed value `eps0 = beta_Q`. It requires no
new cosmology class and fits no propagation coefficient.

Sources:

- [ICAROGW v2.0.3 cosmology implementation](https://github.com/simone-mastrogiovanni/icarogw/blob/v2.0.3/icarogw/cosmology.py#L308-L331)
- [ICAROGW v2.0.3 wrapper](https://github.com/simone-mastrogiovanni/icarogw/blob/v2.0.3/icarogw/wrappers.py#L87-L96)

## What the released posterior already says

The public GWTC-5 deposit supplies posterior samples for the collaboration's
different model, \(\alpha_M(z)=c_M/E(z)^2\). At the locally matched value
\(c_M=2\beta_Q\), the nuisance-marginalized posterior-density ratio relative
to \(c_M=0\) is 0.932 under the narrow Hubble prior and 0.975 under the wide
prior. Those proxy comparisons are statistical ties.

They are not the exact PDT likelihood. The `cM` curve weakens at high redshift,
whereas the PDT `eps0` curve has constant logarithmic slope. The hierarchical
likelihood and its selection correction must therefore be evaluated again.

## The exact event-input lock

`gwtc5_input_lock.json` pins the official 235-event, no-GW170817, IFAR-greater-
than-four-years catalog and every parameter-estimation file it names. The
catalog MD5 is

```text
f15c06cd86d1d0018c69daec05e91e0e
```

Every one of the 235 catalog filename-and-MD5 pairs was matched to exactly one
file in the five official releases below. There are no missing events and no
checksum disagreements.

| Run | Events | Locked source bytes | PE release |
|---|---:|---:|---|
| O1 | 3 | 910,049,240 | [Zenodo 6513631](https://zenodo.org/records/6513631) |
| O2 | 7 | 2,546,745,170 | [Zenodo 6513631](https://zenodo.org/records/6513631) |
| O3a | 33 | 11,245,918,352 | [Zenodo 6513631](https://zenodo.org/records/6513631) |
| O3b | 22 | 11,887,314,812 | [Zenodo 8177023](https://zenodo.org/records/8177023) |
| O4a | 76 | 12,422,047,736 | [Zenodo 17602505](https://zenodo.org/records/17602505) |
| O4b | 94 | 50,283,145,802 | [part 1: Zenodo 20276106](https://zenodo.org/records/20276106); [part 2: Zenodo 20291740](https://zenodo.org/records/20291740) |
| **Total** | **235** | **89,295,221,112** | **83.163 GiB** |

The O4b identifiers matter. The catalog points to the `59d160a18_25` release
above, not the later `29ebe06b7_25` files. The lock follows the catalog's exact
checksums. The largest single source is GW240615_113620 at 6,585,576,736 bytes,
so the archive can be processed on a machine that cannot store all 89.3 GB at
once.

## Low-storage preparation

`prepare_gwtc5_inputs.py` validates the lock, downloads one file at a time,
checks its published MD5, extracts the selected waveform posterior, and writes
a compressed event file. It retains detector-frame component masses,
luminosity distance, useful mass coordinates, the published `log_prior` when
available, the analytic prior descriptions, and the PE configuration's prior
dictionary. The `--delete-source` option removes a verified HDF5 source only
after the compact output has been written.

Inspect the complete workload without downloading:

```bash
python3 prepare_gwtc5_inputs.py --dry-run
```

Test one event:

```bash
python3 prepare_gwtc5_inputs.py \
  --only GW240420_175625 \
  --download \
  --delete-source
```

Process the complete catalog sequentially:

```bash
python3 prepare_gwtc5_inputs.py --download --delete-source
```

A real-file integration test used the checksum-locked
GW240420_175625 source. It verified MD5
`71b7b05b95633b48e555056367f59f6e`, extracted 11,908 samples, and reduced
the 96,144,364-byte HDF5 file to a 535,918-byte NPZ. This demonstrates the
storage strategy; it does not estimate the eventual sampler runtime.

The generated data directories and partial downloads are ignored by Git.

## PE-prior reconstruction

`evaluate_gwtc5_pe_prior.py` turns each compact event into an ICAROGW-ready
posterior by evaluating the marginal PE density in
`(mass_1, mass_2, luminosity_distance)`. Its scientific stack is pinned in
`gwtc5_prior_requirements.txt` to the versions recorded by the released run.

For the usual Bilby events, the PE sampled chirp mass
\(\mathcal M\) and mass ratio \(q\). The density in component masses is

\[
\pi(m_1,m_2)=\pi(\mathcal M)\pi(q)
\left|\frac{\partial(\mathcal M,q)}{\partial(m_1,m_2)}\right|,
\qquad
\left|\frac{\partial(\mathcal M,q)}{\partial(m_1,m_2)}\right|
=\frac{\mathcal M}{m_1^2}.
\]

Bilby's `UniformInComponentsChirpMass` and
`UniformInComponentsMassRatio` factors cancel this Jacobian to a constant
component-mass density. The distance factor is then evaluated from each
file's own analytic prior description. For the seven events explicitly marked
`m1d_m2d_uniform_dL_square_PE_priors` in the official catalog, the evaluator
uses the equivalent density \(D_L^2\), up to an event-wise positive constant
that cancels from a fixed-catalog evidence difference.

Create the pinned environment and evaluate one compact event:

```bash
python3.12 -m venv gwtc5-prior-env
./gwtc5-prior-env/bin/pip install -r gwtc5_prior_requirements.txt
./gwtc5-prior-env/bin/python evaluate_gwtc5_pe_prior.py \
  gwtc5-data/events/GW240420_175625.npz
```

Real-file tests passed for six cases, one from every observing subset in the
catalog: O1, O2, and O3b events with `PowerLaw(alpha=2)` distance priors; O4a
and O4b events with `UniformSourceFrame` distance priors; and the marked O3a
high-spin BNS exception. All 337,982 reconstructed values were finite and
positive. In every chirp-mass/mass-ratio case, the relative spread of the
transformed component-mass density was at most \(2.01\times10^{-15}\),
confirming the analytic Jacobian cancellation numerically across the release
formats. The checksum, waveform group, sample count, method, density range,
and software versions for these checks are recorded in
`gwtc5_pe_prior_audit.json`.

## Selection-function reconstruction

`prepare_gwtc5_injections.py` verifies and compacts the official cumulative
O1--O4b sensitivity file. The fiducial rule is fixed before evaluating either
PDT or GR:

```text
O1/O2: semianalytic network SNR > 10
O3/O4: minimum search FAR < 0.25/year
found: O1/O2 OR O3/O4
```

The GWTC-5 paper fixes the event and real-injection threshold at FAR below
0.25/year. The cumulative release documents 10 as the standard semianalytic
O1/O2 SNR threshold; the same value is used in the established LVK
semianalytic prescription. The archived GWTC-5 result does not serialize its
SNR setting, so the required end-to-end check remains reproduction of the
released `cM` evidence before evaluating PDT.

The checksum-verified source contains 2,504,653 retained candidate injections. The machine-readable audit is committed as `gwtc5_injection_audit.json`.
At the locked thresholds, 369,995 semianalytic and 1,108,698 real-search
injections pass, for 1,478,693 total; the two channels have zero overlap. The
source MD5 is `1498cc813a770e6b5da86c8fbf2b3126`.

For the baseline FullPop analysis, the injected spin law and the population's
implicit spin law both use uniform magnitudes and isotropic orientations. The
script cancels those identical factors, transforms the remaining draw density
from `(m1_source,m2_source,z)` to `(m1_detector,m2_detector,D_L)`, and absorbs
the published run-mixture weight into ICAROGW's effective prior denominator:

\[
\log \pi_{\rm eff}=\log \pi_{\rm draw,mass,z}
 -\log\!\left[(1+z)^2\frac{\mathrm dD_L}{\mathrm dz}\right]
 -\log w_{\rm mixture}.
\]

This is algebraically the same importance-sampling sum as the cumulative
release's documented formula. The released inclination log density also agrees
with the isotropic law `log(sin(i)/2)` to $8.9\times 10^{-16}$ across all
selected samples. A full pinned-stack run produced an 87,852,700-byte compact
file; every one of its 1,478,693 priors was finite and positive, and independent
runs under the system and pinned NumPy/HDF5 stacks produced identical arrays.

```bash
./gwtc5-prior-env/bin/python prepare_gwtc5_injections.py \
  /path/to/mixture-semi_o1_o2-real_o3_o4a_o4b-polar_spins_20260410130052UTC-clipped.hdf \
  --output gwtc5-data/gwtc5_cumulative_icarogw.npz
```

## Native ICAROGW integration diagnostic

`gwtc5_likelihood_smoke.py` exercises the released ICAROGW likelihood itself,
rather than a surrogate calculation. It loads compact event posteriors and the
prepared cumulative injections, constructs ICAROGW's FullPop spectral model
with `eps0_astropycosmology`, and evaluates the same samples at the two fixed
points `eps0 = 0` (GR) and `eps0 = beta_Q` (PDT). The script refuses an
unexpected ICAROGW source commit or core dependency version by default.

The completed diagnostic used the checksum-locked O1 event GW151012_095443,
the O2 event GW170823_131358, and all 1,478,693 selected cumulative
injections. Population and background-cosmology nuisance parameters were
fixed to their component-wise medians from the official narrow-prior `cM`
posterior. With 4,096 samples per event, `neffPE = 20`, `neffINJ = 4 Nobs`,
and `zmax = 20`, it obtained:

| Fixed point | log likelihood | Effective injections | Minimum effective PE samples | Likelihood variance |
|---|---:|---:|---:|---:|
| GR, `eps0 = 0` | 11.711584454 | 47,259.60 | 2,651.95 | 0.0003345 |
| PDT, `eps0 = beta_Q` | 11.783727070 | 43,447.92 | 2,630.52 | 0.0003464 |

The diagnostic difference is

\[
\log L_{\rm PDT}-\log L_{\rm GR}=+0.0721426162.
\]

That small value is a statistical tie. It is **not** a Bayes factor or evidence
for PDT: it uses only two of 235 events and fixes all nuisance parameters
rather than marginalizing them. Its significance is operational. The native
quartic propagation model, event transformations, and model-dependent
selection correction now run together on official data while satisfying the
released likelihood's effective-sample and variance checks. The exact inputs,
versions, settings, and outputs are recorded in
`gwtc5_likelihood_smoke_audit.json`.

Reproduce the diagnostic after preparing its two event files and cumulative
injection file:

```bash
python3.12 -m venv gwtc5-icarogw-env
./gwtc5-icarogw-env/bin/pip install -r gwtc5_icarogw_requirements.txt
./gwtc5-icarogw-env/bin/python gwtc5_likelihood_smoke.py \
  --event-dir gwtc5-data/events \
  --injections gwtc5-data/gwtc5_cumulative_icarogw.npz \
  --reference-result /path/to/icarogw_fullpop_spectral_cm_narrow.json \
  --events GW151012_095443 GW170823_131358 \
  --output gwtc5_likelihood_smoke_audit.json
```

## The remaining reproducibility seams

The lock, event extractor, PE-prior evaluator, injection preparer, and native
likelihood diagnostic solve event identity, waveform-group selection, file
integrity, local storage, both importance-sampling priors, a fixed selection
rule, and basic ICAROGW integration. Two items still have to be closed before
an evidence number is defensible:

1. **Catalog-wide prior validation.** The evaluator has passed one real file
   from each of O1, O2, O3a, O3b, O4a, and O4b, including every prior family
   presently identified in the lock. It must still run successfully across all
   235 checksum-locked events to detect event-specific metadata anomalies. The
   full joint `log_prior` column is retained for diagnostics but is not
   substituted for the required marginal density.
2. **Pipeline validation and compute.** Before evaluating PDT, the reconstructed
   inputs must reproduce the released narrow- and wide-prior `cM` analyses
   within their sampling errors. This check also adjudicates the documented
   SNR-10 reconstruction because the archived result did not serialize that
   setting. The released metadata report 1,440,240 likelihood evaluations and
   461,454 seconds for the narrow run, and 1,895,817 evaluations and 755,792
   seconds for the wide run, each with 16 workers. This is a compute job rather
   than a short laptop check.

These are explicit validation and configuration tasks, not adjustable parts of
the PDT curve.

## Evidence protocol

1. Pin Python 3.12, Bilby 2.6.0, and ICAROGW 2.0.3 at commit
   `c473f3b2f50e11a88a46cc1625933af1f1249d39`.
2. Complete catalog-wide prior validation and prepare the locked cumulative
   injections above.
3. Reproduce the released narrow- and wide-prior `cM` evidence values before
   testing another propagation law.
4. Replace `cM_mod_wrap` with `eps0_mod_wrap`.
5. Run the fixed PDT model with `eps0 = beta_Q` and the fixed GR model with
   `eps0 = 0`, using identical population, merger-rate, Hubble, selection, and
   sampling treatment.
6. Report
   \(\Delta\log Z=\log Z_{\rm PDT}-\log Z_{\rm GR}\), its sampler uncertainty,
   effective posterior and injection sample counts, and posterior-predictive
   distance-ratio bands.
7. Repeat with the Hubble coordinate fixed to \(67.4/(Q/\rho)\), then with the
   same Hubble prior marginalized in both models. The first tests the joint PDT
   point; the second isolates propagation.

The selection correction is recomputed in every run. Reweighting observed
events alone would omit the model's change in detectability with redshift.

## What a result would establish

A finite Bayes factor would be direct evidence about the fixed observational
curve. A value favoring PDT would support this propagation consequence; a
value favoring GR would count against it. Either outcome would directly test a
research consequence because the curve is a deterministic function of the quartic
construction and cannot be retuned within this test.

It would not by itself prove that the quartic scale step is the mechanism of
gravity. That physical identification requires the rest of the theory's bridge.
Here the purpose is narrower and decisive: expose one exact, parameter-free
consequence to the same hierarchical likelihood used by the collaboration.

## The joint Hubble point

The separate PDT Hubble benchmark proposes

\[
\chi=Q/\rho=0.921512445671651\ldots,
\qquad
H_{0,\rm early}/H_{0,\rm present}=\chi.
\]

Using the benchmark early value 67.4 gives the fixed present value
73.1406291001. Together with quartic propagation, this places the proposed
point

\[
(H_0,\epsilon_0)=(73.1406291001\ldots,0.0833375847807\ldots).
\]

The arithmetic fixes those coordinates. Their physical interpretation remains
conditional on the Hubble and propagation identifications.
