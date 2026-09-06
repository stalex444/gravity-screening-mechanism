# The baseline-to-condensate screening chain

## Result

The deposited gravity paper writes the unscreened scale relation

```text
M_Pl,0/m_e = (rho Q)^112/pi^2.
```

Treating that relation as a conditional premise, the conformally coupled
induced-gravity action and the quartic trace response form one closed chain:

```text
M_Pl,0 = m_e (rho Q)^112/pi^2,
v      = M_Pl,0/sqrt(4pi/3),
M_Pl,Q = M_Pl,0 sqrt(1-lambda4^2).
```

The second line follows from the filed action coefficient `xi=1/6`, for which

```text
M_Pl,0^2 = 8pi xi v^2 = (4pi/3)v^2.
```

No measured value of `G` or `M_Pl` enters the right-hand side.  The Planck
mass is used only afterward to score the result.

## Numerical evaluation

Using

```text
rho     = positive root of x^3-x-1,
Q       = positive root of x^4-x-1,
lambda4 = 1-1/Q,
S_Q     = 1-lambda4^2,
```

gives

```text
S_Q             = 0.96730142008853967098...
sqrt(S_Q)       = 0.98351482962309199285...
M_Pl,0          = 1.2413723823827875e19 GeV
v               = 6.065376642391420e18 GeV
M_Pl,Q          = 1.2209081471580190e19 GeV.
```

The 2022 CODATA recommended inputs are

```text
m_e c^2         = 0.51099895069(16) MeV,
M_Pl c^2        = 1.220890(14)e19 GeV.
```

Against the CODATA Planck value, the two stages score as follows:

| Prediction | Signed deviation | Experimental score |
|---|---:|---:|
| unscreened `M_Pl,0` | `+1.67765994%` | `+1463.03 sigma` |
| screened `M_Pl,Q` | `+0.00148639%` | `+1.30 sigma` |

The electron-mass uncertainty is propagated into these scores and is
negligible beside the Planck-mass uncertainty.  The corresponding prediction
for `G`, which is inverse-square in `M_Pl`, is `-0.00297271%` from the CODATA
central value.

The quartic factor therefore removes more than three orders of magnitude from
the relative residual and moves the result from about 1463 experimental
standard uncertainties to 1.30.  It also predicts the corrected condensate
scale `v=6.06538e18 GeV`, replacing the inconsistent `1.208e19 GeV` used in
the induced-gravity drafts.

## Reverse audit

The calculation can be run backward without assuming the quartic coefficient.
The two measured mass scales would require

```text
S_required = (M_Pl,CODATA/M_Pl,0)^2
           = 0.9672726650322209...,

lambda_required = sqrt(1-S_required)
                = 0.1809069787702483....
```

The arithmetic quartic values are

```text
S_Q     = 0.9673014200885397...,
lambda4 = 0.1808274866038356....
```

Thus `S_Q-S_required=+0.0000287550563...`, only `+1.30 sigma` at the
current experimental precision.  Equivalently, the required overlap differs
from `lambda4` by `0.0000794921664...`, or about `0.044%` of the overlap.

This reverse calculation is useful because it tests the small correction
itself.  The coefficient needed to repair the independently stated baseline
is nearly the coefficient supplied by the quartic trace geometry; the result
is not created by hiding the correction inside the large exponent.

## What this establishes

This is a coherent, zero-adjustment numerical consequence of three stated
premises:

1. the deposited `(rho Q)^112/pi^2` baseline;
2. the conformal induced-gravity normalization `xi=1/6`;
3. the quartic trace coefficient `Tr(a_Q^2)=1-lambda4^2` in the Einstein term.

The second step has now been corrected algebraically.  The third coefficient
is exact quartic arithmetic and kernel-verified in this repository.  Once all
three statements are made together, the previously free condensate scale is
fixed without calibrating it to gravity, and the screened Planck mass becomes
a numerical output.

## What it does not establish

This note does not independently derive the exponent `112`; it evaluates the
formula deposited in the gravity paper.  A current-canon status lookup did not
locate that whole baseline formula as an established statement in
`STANDING.md`, so it is kept explicit as a premise here.

The calculation also does not yet derive from microscopic dynamics why the
quartic trace invariant multiplies `R[g]`.  The remaining physical statement
is now narrow:

> The cubic condensate fixes the unscreened Einstein scale, while the
> normalized quartic time response fixes the fraction of that curvature
> stiffness that remains observable.

If a source-level PDT action produces

```text
(xi/2) phi^2 Tr(a_Q^2) R[g],
```

the entire displayed chain follows.  If it produces a different invariant or
allows the condensate to be set only by measured `G`, this interpretation
fails.

## Reproduction

Run

```bash
python3 condensate_chain.py
```

The calculation uses 80-digit decimal arithmetic and the Python standard
library.  The comparison values come from the official
[2022 CODATA adjustment](https://physics.nist.gov/cuu/pdf/JPCRD2022CODATA.pdf).
