# Exact GWTC-5 test of quartic transport

## The model is already implemented

The fixed quartic prediction is

\[
\frac{D_L^{\rm GW}(z)}{D_L^{\rm EM}(z)}=(1+z)^{\beta_Q},
\qquad
\beta_Q=
\frac{\log\!\left(Q/\sqrt{2Q-1}\right)}{\log Q}
=0.08333758478067765\ldots,
\]

where \(Q>1\) is the real root of \(Q^4-Q-1=0\).

The GWTC-5 result files record ICAROGW version 2.0.3. The public tag for that
version (`v2.0.3`, commit
`c473f3b2f50e11a88a46cc1625933af1f1249d39`) already contains
`eps0_astropycosmology`, defined by

```text
dL_GW(z) = (1+z)^eps0 dL_EM(z).
```

Its derivative is also implemented, so ICAROGW uses the same curve in the
event transformation and in the selection correction. The exact PDT test is
therefore the native ICAROGW model at the fixed value
`eps0 = beta_Q`. No fitted propagation parameter and no new cosmology class
are required.

Source:

- [ICAROGW v2.0.3 cosmology implementation](https://github.com/simone-mastrogiovanni/icarogw/blob/v2.0.3/icarogw/cosmology.py#L308-L331)
- [ICAROGW v2.0.3 wrapper](https://github.com/simone-mastrogiovanni/icarogw/blob/v2.0.3/icarogw/wrappers.py#L87-L96)

## What the released posterior can already answer

The public GWTC-5 cosmology deposit supplies equal-weight posterior samples
for the collaboration's `alpha_M(z)=c_M/E(z)^2` model. At the locally matched
value `c_M = 2 beta_Q`, the nuisance-marginalized posterior-density ratio
relative to `c_M = 0` is 0.932 under the narrow Hubble prior and 0.975 under
the wide prior. The present data are effectively indifferent between these
sharp values.

This is not the exact PDT likelihood because the `c_M` curve decays at high
redshift while the `eps0` curve has a constant logarithmic slope.

## The Hubble-gravity joint point

The separate PDT Hubble benchmark proposes

\[
\chi=Q/\rho=0.921512445671651\ldots,
\qquad
H_{0,\rm early}/H_{0,\rm present}=\chi.
\]

Using the benchmark early value \(67.4\) gives the fixed present value
\(73.1406291001\ldots\). Together with quartic propagation, PDT therefore
places one point in the joint plane:

\[
(H_0,\epsilon_0)
=(73.1406291001\ldots,0.0833375847807\ldots).
\]

This is the clean empirical target. The arithmetic fixes the coordinates.
Their physical interpretation remains conditional on the Hubble and
propagation identifications.

## Required rerun

1. Pin Python 3.12 and ICAROGW 2.0.3 at commit
   `c473f3b2f50e11a88a46cc1625933af1f1249d39`.
2. Reconstruct the GWTC-5 FullPop-4.0 spectral-siren input objects for the 235
   events and the cumulative search-sensitivity injections used by the paper.
3. Reproduce the released narrow- and wide-prior `c_M` posteriors and their
   reported evidence before testing PDT. This is the pipeline validation.
4. Replace `cM_mod_wrap` with the already supplied `eps0_mod_wrap`.
5. Fix `eps0` to \(\beta_Q\) with a delta prior and run the same population,
   merger-rate, Hubble, and selection treatment.
6. Run the corresponding GR model with `eps0 = 0` and identical nuisance
   priors.
7. Report
   \(\Delta\log Z=\log Z_{\rm PDT}-\log Z_{\rm GR}\), its sampler uncertainty,
   effective posterior and injection sample counts, and posterior predictive
   distance-ratio bands.
8. Repeat with the Hubble coordinate fixed to \(67.4/\chi\), then with the same
   Hubble prior marginalized in both models. The first is the joint PDT point;
   the second isolates the propagation claim.

The selection correction must be recomputed in every run. Reweighting only
the observed events would omit the change in detectability with redshift and
would not reproduce the published hierarchical likelihood.

## Public inputs and present limitation

- [GWTC-5 cosmology posterior release](https://zenodo.org/records/20378418)
- [GWTC-5 parameter-estimation release, part 1](https://zenodo.org/records/20348005)
- [GWTC-5 parameter-estimation release, part 2](https://zenodo.org/records/20348006)
- [GWTC-5 cumulative search-sensitivity injections](https://zenodo.org/records/19500052)

The cosmology deposit publishes result files and plotting support, not the
configured ICAROGW run objects. Reconstructing the 235-event input set from
the separate releases is therefore the remaining reproducibility job. It is
substantial in data volume and computation, but the PDT model itself is
already present in the verified analysis code.
