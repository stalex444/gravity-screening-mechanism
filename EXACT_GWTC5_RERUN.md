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

## The remaining reproducibility seams

The lock and extractor solve event identity, waveform-group selection, file
integrity, and local storage. Three items still have to be closed before an
evidence number is defensible:

1. **PE prior density.** ICAROGW needs the marginal density
   \(\pi_{\rm PE}(m_1^{\rm det},m_2^{\rm det},D_L^{\rm GW})\) at every retained
   sample. The HDF5 files preserve event-specific Bilby prior descriptions,
   including component-mass Jacobians and source-frame-volume distance priors.
   The extractor deliberately records these descriptions and labels the
   numerical density `not_evaluated`; the full joint `log_prior` column cannot
   silently substitute for the required marginal density.
2. **Selection configuration.** [The cumulative O1--O4b injection release](https://zenodo.org/records/19500052)
   supplies real-search and mixed semianalytic/real files in equivalent polar-
   and Cartesian-spin coordinates. The published cosmology result does not
   serialize the configured likelihood, so the precise injection variant and
   the run-by-run FAR/SNR cuts must be recovered and then checksum-pinned.
3. **Pipeline validation and compute.** Before evaluating PDT, the reconstructed
   inputs must reproduce the released narrow- and wide-prior `cM` analyses
   within their sampling errors. Their metadata report 1,440,240 likelihood
   evaluations and 461,454 seconds for the narrow run, and 1,895,817 evaluations
   and 755,792 seconds for the wide run, each with 16 workers. This is a compute
   job rather than a short laptop check.

These are explicit missing inputs, not adjustable parts of the PDT curve.

## Evidence protocol

1. Pin Python 3.12, Bilby 2.6.0, and ICAROGW 2.0.3 at commit
   `c473f3b2f50e11a88a46cc1625933af1f1249d39`.
2. Close the PE-prior and injection-configuration seams above.
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
