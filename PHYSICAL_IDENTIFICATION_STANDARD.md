# What would establish the physical identification?

## The short answer

The missing result is no longer another numerical coincidence or another
identity involving `Q`.  It is one bridge theorem tying the already-proved
quartic channel to a physical observer horizon.

I would regard the identification as established at the level of an effective
physical theory if one construction proves the following statement:

> For the same independently normalized horizon perturbation, restriction to
> the exterior observer turns the quartic information mode into the exact
> erasure channel with survival factor
> \(S_Q=1-\lambda_4^2=(2Q-1)/Q^2\); this factor multiplies the horizon
> information/entropy response, while the globally counted energy flux is
> unchanged.

The existing Lean development then supplies the consequence rather than
assuming it:

\[
G_Q=\frac{G_0}{S_Q}.
\]

It also propagates that normalization from the transverse-traceless shear
sector to the full linear Pauli--Fierz source response.  Thus the physical work
left is to establish where the quartic factor acts, not to perform the final
gravity algebra again.

## A sufficient bridge construction

A convincing construction should provide one physical horizon or observer
algebra \(\mathcal M_H\), one reference state \(\Omega_H\), and a map from the
quartic information system into it.  The same construction should verify these
five properties.

### 1. Localize the quartic mode

There is a state-preserving embedding or isometry

\[
W:\mathcal H_Q\longrightarrow\mathcal H_H
\]

that maps the distinguished quartic degree-one mode to a definite horizon
perturbation.  Its normalization must be fixed by the state and horizon
geometry, so rescaling the field cannot change the predicted coupling.

A finite split collar may be used as the regulator.  The sharp-horizon claim
then requires a controlled limit in the observer algebra or its continuous
crossed product.

### 2. Identify its time without a new clock constant

The map intertwines the quartic evolution with physical modular or boost
evolution:

\[
W\,\Delta_Q^{it}=\Delta_H^{it}W.
\]

This is the test that the parameter called time on the arithmetic side is the
observer's physical time, rather than an adjustable reparametrization.  It
also fixes the rate at which the Q mode is read by the horizon.

### 3. Derive the exterior channel by restriction

Tracing out, restricting, or conditionally expecting onto the exterior algebra
must produce the already-proved channel, including its exact amplitudes:

\[
|\psi\rangle
\longmapsto
\sqrt{S_Q}\,|\psi\rangle_{\rm ext}|0\rangle_{\rm hid}
+\lambda_4\,|e\rangle_{\rm ext}|\psi\rangle_{\rm hid}.
\]

The two branches must be fixed by the physical inside/outside split.  The
arithmetic complex place can then be put into its proved normal form: the
visible direction is `1`, the orthogonal hidden direction is `+i` after an
orientation is chosen, and no continuous mixing angle remains.

### 4. Prove the placement of the factor

For the same physical perturbation \(h\), prove either of the following
equivalent statements.

**Information/entropy form**

\[
g_{\rm BKM}^{Q}(h,h)=S_Q\,g_{\rm BKM}^{0}(h,h),
\qquad
\delta Q_{\rm global}^{Q}(h)=\delta Q_{\rm global}^{0}(h).
\]

The first equation says that the exterior observer has only the surviving
fraction of the distinguishable information.  The second says that the lost
exterior information has moved to the hidden branch rather than destroying
the globally conserved heat or energy flux.

**Same-shear canonical-energy form**

\[
E_{\rm can}[h;G_Q]=S_Q E_{\rm can}[h;G_0]
\]

with exactly the same geometrically normalized shear \(h\) on both sides.
This wording matters: if the factor can be removed by redefining \(h\), it has
not identified Newton's coupling.

The repository already proves that either correctly placed equality forces
\(G_Q=G_0/S_Q\).  It also proves why multiplying both heat and entropy by
\(S_Q\) cannot work: the factors cancel in the Clausius relation.

### 5. Close conservation and covariance

The dilation must conserve the global observable when exterior and hidden
branches are counted together, and the resulting linear gravitational response
must satisfy the Ward identities.  These checks rule out interpreting the
screening factor as unphysical loss, a gauge artifact, or a field-normalization
choice.

## The single decisive equation

All five requirements can be compressed into one same-mode dictionary:

\[
\boxed{
\delta^2 S_{\rm rel}(\mathcal E_Q\rho\Vert\mathcal E_Q\sigma)
=S_Q\,\delta^2 S_{\rm rel}(\rho\Vert\sigma)
=E_{\rm can}[h;G_Q],
\qquad
\delta^2 S_{\rm rel}(\rho\Vert\sigma)=E_{\rm can}[h;G_0]
}
\]

where \(h\) is one fixed physical horizon perturbation and
\(\mathcal E_Q\) is derived from exterior restriction.  The channel side is
already exact.  The gravity side is already exact conditional on this
dictionary.  Proving that the two occurrences of \(h\) really denote the same
independently normalized physical mode would close the identification.

## Three different thresholds

It helps to distinguish three legitimate claims.

1. **A physical proposal** requires an explicit postulate saying that the
   quartic channel governs horizon distinguishability, followed by its
   parameter-free gravitational consequence and consistency checks.  This is
   already enough for a serious effective-theory paper if the postulate is
   labeled honestly.
2. **A derived physical identification** requires the horizon embedding,
   modular intertwining, and exterior restriction above.  At that point the
   placement of \(S_Q\) is a theorem of the construction rather than a physical
   postulate.
3. **A compelling identification of nature** adds at least one independent,
   falsifiable consequence that was not used to select the bridge.  A useful
   target would be a fixed ratio between two horizon response channels, or a
   time/phase response forced by the same \(\lambda_4\), because it tests the
   proposed mechanism rather than merely measuring Newton's constant again.

The second threshold is what I would call sufficient to establish the physical
identification mathematically.  The third is what is most likely to persuade
physicists that the identified structure is realized in nature.

## What does not close it by itself

The following results are real support, but none alone fixes the physical
dictionary:

- the numerical agreement of \(1/S_Q\) with a proposed gravity-screening
  factor;
- the Lorentzian signature of the quartic trace form;
- the `3+1` Fisher-cone decomposition;
- the uniqueness of the hidden direction up to orientation;
- the finite erasure dilation and conservation theorem;
- a general analogy between information loss, horizons, and curvature.

Together they make the bridge unusually constrained.  The remaining logical
step is specific: prove that a physical horizon implements this exact channel
on the same mode whose canonical energy defines the gravitational response.

## Immediate research target

The most economical next target is a split-horizon model with a controlled
sharp limit:

1. place the finite quartic dilation in a type-I split collar;
2. choose the state and embedding by modular covariance;
3. derive the exterior map from restriction or conditional expectation;
4. compute its BKM/relative-entropy Hessian;
5. identify that Hessian with canonical energy for one fixed shear mode;
6. take the collar to the horizon while preserving the factor \(S_Q\).

This target is smaller than deriving all of quantum gravity.  It asks for one
local observer sector, one channel, one normalized perturbation, and one
response coefficient.  Success would turn the present conditional gravity
chain into a physical derivation.

## Literature anchors and scope

Jacobson's local-horizon argument derives Einstein's equation from the
Clausius relation and entropy proportional to horizon area:
<https://arxiv.org/abs/gr-qc/9504004>.

In holographic ball regions, the Fisher information metric has been identified
with bulk canonical energy, providing a concrete precedent for the central
dictionary used here:
<https://arxiv.org/abs/1508.00897>.  This result is a precedent in its stated
holographic setting, not yet a theorem for the PDT horizon construction.

Crossed-product observer algebras provide a setting in which entropy can be
defined for gravitational subregions and compared with generalized entropy:
<https://arxiv.org/abs/2112.12828> and
<https://arxiv.org/abs/2405.00847>.

The split property supplies the standard operator-algebraic reason that a
finite type-I collar can serve as a local regulator before a sharp-boundary
limit is attempted: <https://arxiv.org/abs/1601.06936>.
