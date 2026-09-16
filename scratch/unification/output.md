# The perfect-cuboid genus-5 fibre X_s and its five elliptic factors: unification, rank calibration, and the de Grey-Gibbs-Helm EF3/EF4 discrepancy

Confidence labels used throughout: **verified** (derived here and confirmed by a computation in this directory, with the script and output file named), **claimed** (asserted in a paper or by the requester, not independently checked here), **could not verify** (attempted and failed, or no means available), **wrong** (checked and found false).

Notation fixed once. A *face* of a cuboid is a rectangle whose two sides and diagonal are integers, so the face has Euclid parameters `(p, q)` with `p > q > 0`, `gcd(p,q) = 1`, `p - q` odd, and

    a = p^2 - q^2,   b = 2pq,   d = p^2 + q^2,   a^2 + b^2 = d^2.

`c` denotes the third edge (the edge perpendicular to the fixed face). A perfect cuboid with that face exists iff there is a rational `c != 0` with `c^2 + a^2`, `c^2 + b^2` and `c^2 + d^2` all squares.

## Summary of verdicts

1. **The five factors — verified, and simpler than expected.** `X_s` is the intersection of the three diagonal quadrics `y1^2 = c^2 + a^2 w^2`, `y2^2 = c^2 + b^2 w^2`, `y3^2 = c^2 + d^2 w^2` in `P^4`, a smooth canonical genus-5 curve, and `J(X_s) ~ EF1 x EF2 x EF3 x EF4 x P+` where `EF3 = x(x+a^2)(x+d^2)`, `EF4 = x(x+b^2)(x+d^2)` (the proof-text reading) and `P+ = x(x-a^2)(x-b^2)` is `EF1` twisted by `-1`. The prior seat's identifications all reproduce. Two corrections: `EF3` and `EF4` are **quadratic twists by `-1`, isomorphic only over the algebraic closure, not isogenous over `Q`** (different conductors, different ranks); and the prior seat's "one further curve `F2`" is exactly `EF1^(-1)`.
2. **Calibration — verified; the headline is negative.** All 2,040 faces with `p <= 100` and all 8,156 with `p <= 200` computed, no timeouts. Class A (some factor certified rank 0) 79.85% and 78.02%; class C 20.15% and 21.98%; **class B is empty for a logical reason** — with five factors, "no factor of rank 0" forces the rank sum to be at least 5. Consequently `rk J(X_s) <= 4` implies some factor has rank 0, and rank 0 of a single factor already makes `X_s(Q)` finite and computable. **Linear Chabauty on `X_s` is strictly weaker than the elementary rank-0 argument**: it is certified on 37.16% of faces at `p <= 100` (33.52% at `p <= 200`), all of them already excluded by rank 0.
3. **Peschmann's 968 uncovered fibres — verified.** 62.29% of them (603) are excluded by rank 0 of one of the five factors, and only 18.49% (179) satisfy the genus-5 Chabauty inequality; the 179 are a subset of the 603. The hard fibre `(5,2)` is **excluded**: `rk EF3 = 0` exactly, and `ad = 609` is not a square. 172 further fibres are excluded by Peschmann's *own* curve `E_uV` once one runs the descent on the isogenous dGGH model `EF2` instead. His 122 "disagreements" with 2-descent are exactly his 122 `modular_symbol` rows (L-value certificates), not disagreements.
4. **dGGH EF3/EF4 — settled: the displayed formulas are wrong.** All 44 face cuboids with third edge `<= 3000` lie on the proof-text curve and none on the displayed one; the displayed curves are not isogenous to, and do not even share a `j`-invariant with, any factor of `J(X_s)` over all 121 faces with `p <= 24`; `arXiv:2401.06784` has only `v1` and no erratum was found. The typo costs 44 faces with `p <= 100` for which the printed Theorem 1 claims an exclusion that no curve attached to the problem supports. Separately, **"both `EF3` and `EF4`" should be "either"** for perfect cuboids (59.66% -> 79.85% at `p <= 100`).
5. **Unified table — built.** New identifications verified here: Leech's descent curve (as written by van Luijk) is `Q`-isomorphic to `EF1`; dGGH's `EI3` and `EI4` are **the same curves as `EF4` and `EF3`** after `x -> x - d^2`; `EI1`, `EI2` are the odd genus-2 parts of the internal-rectangle genus-5 fibre, whose Jacobian has only three isogeny classes because that fibre has an extra involution; dGGH's congruent-number curve is the third elliptic quotient of Colman's genus-5 curve; and the family of arXiv:2407.09825 is `Q`-isomorphic to `EF4`.
6. **Chabauty feasibility — assessed, not executed.** Sage 9.5 has Coleman integration only for hyperelliptic curves and no Chabauty driver of any kind; the three genus-3 quotients of `X_s` are hyperelliptic with Jacobians `(private) x P+ x EF2`, and classical Chabauty on them is certified on 34.81% of faces at `p <= 200` — again a subset of the rank-0 set. Stoll's diagonal-genus-5 method applies verbatim to `X_s` but needs Elliptic Curve Chabauty over quartic fields, which exists only in Magma. On 23.80% of faces at `p <= 200`, 2-descent proves `rk J(X_s) >= 5`, so Chabauty is unconditionally unavailable there; on 1.90% it proves all five ranks are exactly 1.

## 1. The genus-5 fibre X_s and its five elliptic factors — **verified**

### 1(a). The curve

Fix the face `(p,q)`, i.e. `a = p^2-q^2`, `b = 2pq`, `d = p^2+q^2`. Let `c` be the third edge. A perfect cuboid on that face is a rational point of

    X_s :  y1^2 = c^2 + a^2 w^2,   y2^2 = c^2 + b^2 w^2,   y3^2 = c^2 + d^2 w^2

in `P^4` with homogeneous coordinates `(w : c : y1 : y2 : y3)`: the intersection of three diagonal quadrics, i.e. a canonical non-hyperelliptic curve of genus 5 (the canonical model of a non-trigonal, non-hyperelliptic genus-5 curve is exactly an intersection of three quadrics in `P^4`). `X_s` is a `(Z/2)^3`-cover of the `c`-line branched over the six points `c = +-ia, +-ib, +-id` (each a simple branch point of exactly one of the three double covers) and unramified over `c = infinity` because the three leading coefficients are `1`. Riemann-Hurwitz: `2g-2 = 8(-2) + 6*4*1 = 8`, so `g = 5`. **verified** (derivation here; the genus also matches the prior seat's `(Z/2)^2`-model in the lambda-coordinate).

This is the same curve as the prior seat's `X_s` in the rho-coordinate, under `rho = 2a/c`: with `rho = 2a/c` one has `c^2+a^2 = a^2(rho^2+4)/rho^2`, `c^2+b^2 = (b^2 rho^2 + 4a^2)/rho^2`, `c^2+d^2 = (d^2 rho^2 + 4a^2)/rho^2`, so the prior seat's three conics Rat, Master, Hsum are the three conditions above. **verified** (identity check inside `01-five-factors-id.gp`; the two coordinate systems give isomorphic curves at every test fibre, see 1(c)).

### 1(b). The Kani-Rosen decomposition

`G = (Z/2)^3` has seven subgroups of index 2, equivalently seven non-trivial characters; `J(X_s) ~ prod_{chi != 1} J(X_s / ker chi)`. The seven quotients are the three conics (genus 0, the individual conditions), three genus-1 curves (the three pairwise products) and one genus-2 curve (the triple product). Genera `0+0+0+1+1+1+2 = 5`, so `dim J(X_s) = 5` and there are exactly five elliptic factors. **verified.**

Writing `X = c^2`, the genus-2 quotient `z^2 = (c^2+a^2)(c^2+b^2)(c^2+d^2)` splits under `c -> -c` into the cubic `(X+a^2)(X+b^2)(X+d^2)` and the quartic `X(X+a^2)(X+b^2)(X+d^2)`. The five factors are therefore

    Q1 = Jac[ y^2 = (c^2+a^2)(c^2+b^2) ]          "the two face diagonals through c are rational"
    Q2 = Jac[ y^2 = (c^2+a^2)(c^2+d^2) ]          "one face diagonal and the space diagonal are rational"
    Q3 = Jac[ y^2 = (c^2+b^2)(c^2+d^2) ]          "the other face diagonal and the space diagonal are rational"
    P+ = Jac[ y^2 = (X+a^2)(X+b^2)(X+d^2) ]       even part of the genus-2 quotient
    P- = Jac[ y^2 = X(X+a^2)(X+b^2)(X+d^2) ]      odd part of the genus-2 quotient

### 1(c). The dictionary — all of it **verified** at `(p,q) = (2,1), (3,2), (5,2), (8,5), (13,4)`

Script `01-five-factors-id.gp`, output `01-five-factors-id.out` (j-invariant, conductor, torsion, `ellrank`, and full isomorphism/isogeny matrix via `ellisomat`; `ISOMORPHIC/Q` means equal j and `c6 c4' / (c4 c6')` a square, `isogenous` means the partner appears in `ellisomat`). At all five test fibres:

    Q1  isogenous to  EF1 = x(x+a^2)(x+b^2)          and ISOMORPHIC to Peschmann's E''_A and to the prior seat's E_qS
    Q2  isogenous to  EF3 = x(x+a^2)(x+d^2)          and ISOMORPHIC to the prior seat's E_YS
    Q3  isogenous to  EF4 = x(x+b^2)(x+d^2)          and ISOMORPHIC to Peschmann's E_3 and to the prior seat's E_Yq
    P-  ISOMORPHIC to EF2 = x(x+a^4)(x+b^4)          and ISOMORPHIC to the prior seat's F1; isogenous to E_A and E_uV
    P+  ISOMORPHIC to x(x-a^2)(x-b^2) = EF1 twisted by -1, and ISOMORPHIC to the prior seat's F2; isogenous to E'_A and E_PQ

So the prior seat's identifications (`E_{m,n} = EF1`, `E_uV ~ EF2`, `E_3 ~ EF4`, `E''_A ~ EF1`, `E'_A ~ E_PQ ~ F2`, `E_YS ~ EF3`) are **all reproduced**, with two sharpenings the prior seat did not state.

**Sharpening 1 (new, verified).** The prior seat's "fifth curve F2, which dGGH do not use" is not a new curve at all: `P+ = F2` is *isomorphic over Q* to `x(x-a^2)(x-b^2)`, the quadratic twist of `EF1` by `-1`. Proof (one line, so this is a theorem, not a numerical observation): in `y^2 = (X+a^2)(X+b^2)(X+d^2)` put `X = x - d^2`; since `d^2-a^2 = b^2` and `d^2-b^2 = a^2` this becomes `y^2 = x(x-b^2)(x-a^2)`. **verified** symbolically and confirmed as `ISOMORPHIC/Q` at all five test fibres.

**Sharpening 2 (verified; the requester independently reached the same conclusion while this was being computed).** `EF3` and `EF4` (proof-text reading) are **isomorphic over the algebraic closure but not over Q**: they are quadratic twists of each other by `-1`. They are *not* `Q`-isomorphic and *not* isogenous. They have the same `j` (put `x = X - d^2` in `EF3` to get `X(X-b^2)(X-d^2)`, which is `EF4` twisted by `-1`), but different conductors: at `(2,1)`, `N(EF3) = 240` and `N(EF4) = 15`; at `(5,2)`, `48720` and `3045`; at `(13,4)`, `1962480` and `245310`. Equal `j` plus unequal conductor means they are quadratic twists that are not `Q`-isomorphic; isogenous curves have equal conductors, so they are not isogenous either. Their ranks genuinely differ (at `(5,2)`: `rk EF3 = 0`, `rk EF4 = 1`). **The requester's note "in the text reading EF3 is isomorphic to EF4 (equal j)" is wrong**; equal `j` is necessary but far from sufficient.

The clean statement of the whole picture is therefore:

    J(X_s)  ~  EF1  x  EF1^(-1)  x  EF2  x  EF4  x  EF4^(-1)

where `E^(-1)` is the quadratic twist by `-1`, `EF3 = EF4^(-1)`, and `P+ = EF1^(-1)`. The five factors come in two twist-pairs plus `EF2`. **verified** at the five test fibres and proved symbolically for the two twist relations.

### 1(d). Two structural consequences — **verified**

- `P+ = EF1^(-1)` always has **positive rank**. The model `y^2 = (X+a^2)(X+b^2)(X+d^2)` has the rational point `(0, abd)`, which corresponds to `(d^2, abd)` on `y^2 = x(x-a^2)(x-b^2)`; that point is not one of the three 2-torsion points `(0,0), (a^2,0), (b^2,0)`, and `ellorder` confirms it has infinite order on every fibre tested (`07-torsion-checks.out`). This is exactly dGGH's Theorem 2 ("an edge cuboid exists for every Pythagorean aspect ratio"). Empirically, on all 2,040 fibres with `p <= 100` the 2-descent *lower* bound for this factor is `>= 1` and it is never 0.
- Consequently `rk J(X_s) >= 1` for every face, and **the genus-5 linear Chabauty inequality `sum of the five ranks <= 4` can only hold if at least one of the other four factors has rank 0**. Since rank 0 of any single factor already makes `X_s(Q)` finite and computable (the quotient map `X_s -> Q_i` has degree 4, `X_s -> P+-` degree 8), linear Chabauty on `X_s` is *strictly weaker* than the elementary rank-0 quotient argument: its hypothesis is a proper subset. See item 2 for the numbers.

### 1(e). Why rank 0 of one factor excludes the face — **verified**, with one gap flagged

On all 8,156 faces with `p <= 200` (`07-torsion-checks.gp` / `.out`) the torsion of the five factors is constant: `EF1, EF3, EF4` have `Z/4 x Z/2`, `EF2` has `Z/8 x Z/2`, `P+` has `Z/2 x Z/2`. For `EF1, EF3, EF4` a perfect cuboid gives the point `x = c^2 > 0`, so if the rank is 0 then `c^2` must be one of the torsion `x`-coordinates; the only positive ones are `ab` on `EF1`, `ad` on `EF3` and `bd` on `EF4`. None of `ab`, `ad`, `bd` is a perfect square for any face with `p <= 200` (**verified**, same output). For `ad = p^4 - q^4` this is Fermat's theorem that `x^4 - y^4` is never a nonzero square, so `EF3` is settled in general (**verified**). For `ab = 2pq(p^2-q^2)` the condition reduces (using that `p, q, p-q, p+q` are pairwise coprime) to `e^4 - f^4 = 2 g^2`, and for `bd = 2pq(p^2+q^2)` to `e^4 + 4 f^4 = g^2`; a brute-force check finds no non-trivial solution with `e <= 3000` in either case, and both are standard Fermat-descent exercises, but I did not reconstruct the descent. **verified in range; the general statement for EF1 and EF4 is claimed, not proved here.**

### 1(f). `rk P+ >= 1` for every face: proof, and which point of `X_s` it is — **verified**

**Which point.** `P+` is the *even* part of the genus-2 quotient in the `c`-coordinate: `y^2 = (X+a^2)(X+b^2)(X+d^2)` with `X = c^2`. The always-present point is `X = 0`, i.e. `c = 0`, i.e. the degenerate "cuboid" whose third edge is zero — the face rectangle `(a, b, d)` itself. On `X_s` this is the fibre over `c = 0`, consisting of the eight rational points `(w : c : y1 : y2 : y3) = (1 : 0 : +-a : +-b : +-d)`. Under `rho = 2a/c` the same point sits at `rho = infinity`; in the prior seat's rho-model the factor `P+` is the *quartic* `(z rho)^2 = R(R+4)(d^2 R + 4a^2)(b^2 R + 4a^2)`, `R = rho^2`, whose leading coefficient `b^2 d^2` is a square, so the point is one of its two rational points at infinity. (Note the label swap between the two coordinate systems: the prior seat's `F2` is the *quartic* in `R` and equals the *cubic* `(X+a^2)(X+b^2)(X+d^2)` in `X`, while the prior seat's `F1` is the *cubic* in `R` and equals the *quartic* `X(X+a^2)(X+b^2)(X+d^2)` in `X`. **verified** as `ISOMORPHIC/Q` in `01-five-factors-id.out`.) In the Weierstrass model `P+ : y^2 = x(x-a^2)(x-b^2)` obtained by `x = X + d^2`, the point is `G = (d^2, abd)`.

**Proof that `G` is not torsion** (script `08-Pplus-proof.gp`, output `08-Pplus-proof.out`; the only external ingredient is Fermat's theorem that `u^4 - v^4` is never a nonzero square):

1. `x(G) = d^2`, `x(G) - a^2 = b^2`, `x(G) - b^2 = a^2` are all squares, so `G` lies in the kernel of the complete 2-descent map `E(Q)/2E(Q) -> (Q*/Q*^2)^2`; that kernel is `2E(Q)`, so `G = 2R` with `R` in `E(Q)`. (Explicitly `x(R) = (d+a)(d+b)` works.)
2. `E(Q)_tors` contains the full 2-torsion `{O, (0,0), (a^2,0), (b^2,0)}`. A rational point of order 4 above `(0,0)` would need `-a^2` and `-b^2` to be squares (impossible, they are negative); above `(a^2,0)` it needs `a^2 - b^2` a square, above `(b^2,0)` it needs `b^2 - a^2` a square. Either together with `a^2+b^2 = d^2` gives `a^4 - b^4` or `b^4 - a^4` equal to a square, contradicting Fermat. So `E(Q)` has no point of order 4. (Checked numerically: `|a^2-b^2|` is a square on none of the 8,156 faces with `p <= 200`.)
3. Suppose `G` were torsion. Then `R` is torsion too (the free part of `R` must vanish). `G = 2R` is not 2-torsion because `y(G) = abd != 0`, so `ord(R)` is not in `{1,2,4}`. By Mazur the torsion groups containing `(Z/2)^2` are `Z/2 x Z/2N`, `N <= 4`; `N = 2` and `N = 4` are excluded by step 2, so `N = 3` and `ord(R)` is 3 or 6, whence `ord(G) = 3`.
4. `ord(G) = 3` means `x(2G) = x(G)`. For `y^2 = x^3 - d^2 x^2 + a^2b^2 x` the duplication formula gives `x(2G) = (d^4 - a^2b^2)^2 / (4 a^2 b^2 d^2)`, and `x(2G) - x(G)` has numerator `d^8 - 6 a^2 b^2 d^4 + a^4 b^4` (computed symbolically in `08-Pplus-proof.out`). Its vanishing forces `d^2 = ab(1 +- sqrt 2)` up to sign, impossible for nonzero rationals. Contradiction.

So `G` has infinite order and `rk P+ >= 1` for **every** face. **verified.** Numerically: `elltors(P+) = Z/2 x Z/2` and `ellorder(P+, G) = 0` on all 8,156 faces with `p <= 200`, no exceptions (`08-Pplus-proof.out`). This is the curve-level content of dGGH's Theorem 2 (edge cuboids exist for every Pythagorean aspect ratio); dGGH assert the positivity without proof ("the curve turns out to possess a rational point at `x = 0` that is not a torsion point, regardless of the values of `a`, `b` and `d`"), and the above is a proof of that assertion.

**Consequence.** `rk J(X_s) >= 1` always, so the genus-5 linear Chabauty inequality `rk EF1 + rk EF2 + rk EF3 + rk EF4 + rk P+ <= 4` is equivalent to `rk EF1 + rk EF2 + rk EF3 + rk EF4 <= 3` together with `rk P+ = 1`; in particular at least one of `EF1..EF4` must have rank 0.

## 2. Calibration of the rank bounds over all faces with p <= 100 — **verified**

Script `02-five-factors-p100.gp`, merged output `02-five-factors-p100.out` (one line per face: `p q R1 R2 R3 R4 R5 class zeros seconds`, where `R1..R5` are PARI `ellrank` upper bounds at effort 0 for `EF1, EF2, EF3, EF4, P+` respectively). All 2,040 coprime opposite-parity pairs with `2 <= p <= 100`; four processes split by `p mod 4`; per-curve limit 60 s. Aggregation script `04-stats.py`, output `04-stats-p100.out`.

**No fibre timed out**: all 10,200 rank computations finished, most in milliseconds, the slowest face in well under a second. So class D is empty and every number below is an unconditional 2-descent bound.

### 2(a). Direction of the bound

`ellrank` returns `[lower, upper]`; `upper` is the 2-descent (2-Selmer) bound, which is `>= rk`, with the excess accounted for by `Sha[2]` and by 2-torsion bookkeeping. Therefore: `upper = 0` proves `rk = 0` (unconditional), and `sum of uppers <= 4` proves `rk J(X_s) <= 4` (unconditional). The converse fails: a face with `sum of uppers >= 5` may still have true rank `<= 4`. So class C ("sum `>= 5`") is *not* a certificate that Chabauty is unavailable; it is only the statement that 2-descent did not certify it. Conversely class A ("some upper bound is 0") *is* a certificate.

### 2(b). Class B is empty for a logical reason, not a computational one

The requester's class B is "no factor has upper bound 0, but the sum of the five upper bounds is `<= 4`". With five factors, if none has upper bound 0 then each is `>= 1` and the sum is `>= 5`. **Class B is empty by arithmetic.** More importantly the same argument applies to the true ranks: `rk J(X_s) <= 4` forces `rk = 0` for at least one of the five factors. And if one factor has rank 0 then `X_s(Q)` is already finite and effectively computable without any `p`-adic integration, because `X_s -> Q_i` has degree 4 (and `X_s -> P+-` degree 8) and a rank-0 elliptic curve has an explicitly listable Mordell-Weil group. **Linear Chabauty-Coleman on `X_s` therefore cannot cover a single face that the elementary "one factor has rank 0" argument does not already cover, and it covers strictly fewer.** **verified** (structural; the counts below quantify "strictly fewer").

### 2(c). The counts (p <= 100, 2,040 faces)

    class A (some factor has certified rank 0)                  1629   79.85%
    class B (no zero, sum <= 4)                                    0    0.00%   [empty by 2(b)]
    class C (sum of the five upper bounds >= 5)                  411   20.15%
    class D (timeout)                                              0    0.00%

    of which: sum of the five upper bounds <= 4, i.e. the
    genus-5 linear Chabauty inequality certified                  758   37.16%
    certified rank 0 somewhere but Chabauty bound not certified   871   42.70%

Per factor, the number of faces with a certified rank 0:

    EF1 = x(x+a^2)(x+b^2)     698   34.22%
    EF2 = x(x+a^4)(x+b^4)     686   33.63%
    EF3 = x(x+a^2)(x+d^2)     709   34.75%
    EF4 = x(x+b^2)(x+d^2)     716   35.10%
    P+  = x(x-a^2)(x-b^2)       0    0.00%      [rank >= 1 always, see 1(d)]

Full distribution of the upper bound per factor (`0/1/2/3/4/5` counts over the 2,040 faces):

    EF1   698 / 987 / 317 / 37 / 1 / 0
    EF2   686 / 1018 / 315 / 21 / 0 / 0
    EF3   709 / 999 / 321 / 11 / 0 / 0
    EF4   716 / 999 / 315 / 10 / 0 / 0
    P+      0 / 730 / 999 / 289 / 21 / 1

Distribution of the sum of the five upper bounds: `1: 19, 2: 89, 3: 255, 4: 395, 5: 478, 6: 403, 7: 205, 8: 116, 9: 58, 10: 14, 11: 7, 12: 1`.

### 2(d). Exclusion rates under the different criteria (p <= 100, same data)

    dGGH Theorem 1 exactly as stated (EF1 or EF2 rank 0, or BOTH EF3 and EF4)      1217   59.66%
    the requester's criterion (EF1 or EF2 or EF3 rank 0)                           1415   69.36%
    what the genus-5 picture gives (any one of EF1, EF2, EF3, EF4 rank 0)          1629   79.85%
    adding P+ (it is never rank 0, so no change)                                   1629   79.85%

**Cross-check against the requester's probe: verified.** Columns `p q R1 R2 R3` of `02-five-factors-p100.out` agree line for line (2,040 lines, `diff` empty) with columns 1-5 of `../dgh-probe/04-ef-ranks-corrected-p100.out`, and the requester's figure 69.4% is reproduced exactly as 1415/2040 = 69.36%.

**dGGH's Theorem 1 is weaker than their own proof.** For a *perfect* cuboid both `a^2+c^2` and `b^2+c^2` are squares, so a PC gives a rational point with `x = c^2` on `EF3` *and* on `EF4`; rank 0 of either one alone already excludes the face (given 1(e)). The "both EF3 and EF4" in Theorem 1 is what is needed to exclude all *face cuboids* (where only one of the two is a square), not PCs. Replacing "both" by "either" raises the exclusion rate at `p <= 100` from 59.66% to 79.85%. **verified.**

### 2(e). Bands of p (25 wide)

    band       n     A0 %    CH %    EF1=0 %   EF2=0 %   EF3=0 %   EF4=0 %   P+=0 %   mean sum of bounds
    1-25     131    92.37   57.25     45.04     37.40     41.22     43.51     0.00      4.344
    26-50    387    80.88   38.24     35.66     32.82     36.95     34.37     0.00      5.008
    51-75    635    78.58   36.38     32.91     31.02     35.43     35.43     0.00      5.208
    76-100   887    78.47   34.27     32.92     35.29     32.36     33.93     0.00      5.242

`A0` = some factor has a certified rank 0; `CH` = the sum of the five upper bounds is `<= 4`. Both rates fall with `p` and the fall is flattening; the mean total bound rises slowly. Nothing here suggests either rate tends to 0 or to a limit below about 3/4 and 1/3 respectively in this range, but the range is far too short to extrapolate. **verified as counts; no asymptotic claim.**

### 2(f). Extension to p <= 200, and how sharp the bounds are — **verified**

Script `03-five-factors-p200.gp`, merged output `03-five-factors-p200.out` (one line per face: `p q L1 U1 L2 U2 L3 U3 L4 U4 L5 U5 seconds`, both `ellrank` bounds for each factor), reduced to the same column format as item 2 in `03-five-factors-p200.ub.out`. All 8,156 coprime opposite-parity pairs with `p <= 200`, again **no timeouts**. Aggregations: `04-stats-p200.out`, `04b-sharpness-p200.out`.

    class A 6363 (78.02%)    class B 0    class C 1793 (21.98%)    class D 0
    sum of the five upper bounds <= 4 : 2734 (33.52%)
    EF1 rank 0 33.57%   EF2 33.08%   EF3 32.82%   EF4 32.77%   P+ 0.00%
    dGGH Theorem 1 literally ("both EF3 and EF4")  4802 (58.88%)
    "either EF3 or EF4"                            6363 (78.02%)

Band-by-band (`p` in steps of 25), the rate of "some factor certified rank 0" is 92.37, 80.88, 78.58, 78.47, 75.15, 79.88, 78.86, 75.72 percent, and the rate of "sum of bounds `<= 4`" is 57.25, 38.24, 36.38, 34.27, 31.43, 32.30, 32.83, 32.40 percent. Both are essentially flat after the first two bands over this range.

**Sharpness.** `ellrank` returns matching lower and upper bounds (so the rank is determined) on `EF1` 97.06%, `EF3` 89.87%, `EF4` 89.68%, `EF2` 83.44%, `P+` 70.99% of faces, and on all five simultaneously on 48.77%. The gap is always even (0, 2 or 4), as expected for a 2-descent. Consequences for the Chabauty inequality:

    sum of the five UPPER bounds <= 4  (certifies rk J <= 4)                        2734  33.52%
    sum of LOWER bounds, with the proved rk P+ >= 1, already >= 5                   3191  39.12%
    undecided band                                                                  2231  27.35%

So at `p <= 200` the Chabauty inequality is **certified** on 33.5% of faces, **refuted** on 39.1%, and left open by 2-descent on 27.4%. On 155 faces (1.90%) all five ranks are proved to be exactly 1, so `rk J(X_s) = 5` exactly; the smallest are `(32,7), (34,11), (35,2), (42,13), (43,10), (44,17), (47,10), (52,9), (57,14), (59,22)`.

## 3. Peschmann's 968 uncovered fibres — **verified**

Scripts `05-peschmann-coverage.py` (output `05-peschmann-coverage.out`), `05b`/`05c` helper runs (`05b-peschmann-detail.out`, `05c-peschmann-breakdown.out`) and `06-euv-check.gp` (output `06-euv-check.out`). The fibre index `(m,n)` of the trilogy is the face index `(p,q)` here: the prior seat's §7(b) identification `E_3` isomorphic to the `Master x Hsum` quotient and `E_uV` isogenous to `EF2` is **reproduced** at `(2,1), (3,2), (5,2), (8,5), (13,4)` in `01-five-factors-id.out` and at ten further fibres in `06-euv-check.out`, where `E_3` and `EF4` have identical conductors, as do `E_uV` and `EF2`.

The released list `repo/paper3_data_proven_fibers.csv` has 1,072 rows, all inside the `p <= 100` grid, 827 certified through `E_3` and 245 through `E_uV`; 568 rows are resolved by `ellrank` and 504 by the L-value route. So 968 of the 2,040 faces are not covered.

### 3(a). Classification of the 968

    class A (some one of the five factors has certified rank 0)     603   62.29%
    class B (no zero, sum of bounds <= 4)                             0    0.00%   [empty by 2(b)]
    class C (sum of the five upper bounds >= 5)                     365   37.71%
    class D (timeout)                                                 0    0.00%

    of the 968, the genus-5 linear Chabauty inequality is certified  179   18.49%   (all 179 are inside the 603)

Which factor does the excluding, over the 968 (a fibre can have several):

    EF1 rank 0   295 fibres     EF2 rank 0   172     EF3 rank 0   307     EF4 rank 0   0     P+ rank 0   0

    zero-sets:   none 365,  {EF3} 176,  {EF1} 176,  {EF2} 92,  {EF1,EF3} 79,  {EF2,EF3} 40,  {EF1,EF2} 28,  {EF1,EF2,EF3} 12

`EF4` never appears: `EF4` is Peschmann's own `E_3`, and every face on which 2-descent gives `rk EF4 = 0` is already in his 1,072. **The answer to the requester's headline question is 18.49%** (179 of the 968), but the number that matters more is 62.29%: those 603 fibres are excluded outright by rank 0 of a single factor, without any Chabauty machinery, and the 179 are a proper subset of them. Restricting to the two factors Peschmann's pipeline never looks at (`EF1` and `EF3`), 431 of the 968 are excluded.

After removing all 603, **365 faces with `p <= 100` survive** (17.89% of the grid). Their bound sums are `5: 35, 6: 126, 7: 78, 8: 80, 9: 30, 10: 11, 11: 5`; the 35 with sum 5 all have bound vector `(1,1,1,1,1)`, e.g. `(32,7), (34,11), (35,2), (42,13), (43,10), (44,17), (47,10), (52,9), (57,14), (59,22), (61,14), (62,13)`. Over the whole grid, 411 faces have no factor with a certified rank 0; 46 of those 411 are nevertheless in Peschmann's list, because his L-value certificate beats 2-descent there.

### 3(b). The hard fibre (5,2) — **excluded**

    (p,q) = (5,2),  (a,b,d) = (21,20,29)
    rank upper bounds  [EF1, EF2, EF3, EF4, P+] = [1, 1, 0, 1, 2],  sum 5

`EF3 = x(x+441)(x+841)` has `ellrank = [0,0]`, i.e. rank exactly 0, torsion `Z/4 x Z/2` with `x`-coordinates `{0, -441, -841, 609, -609}`; `ad = 609 = 3*7*29` is not a square, so no perfect cuboid has a face of aspect ratio `21:20`. This is the fibre the prior seat singled out as hard for Peschmann (three factors at `2+1+1` in his labelling); it falls to the one factor — the `Rat x Hsum` quotient, dGGH's `EF3` — that appears in neither Peschmann's papers nor (under the displayed formulas) in dGGH's own usable criterion. The genus-5 linear Chabauty inequality is *not* certified there (sum of bounds 5), so this exclusion comes from the rank-0 argument, not from Chabauty. **verified** (`01-five-factors-id.out`, `02-five-factors-p100.out` line `5 2 1 1 0 1 2 A 3`).

### 3(c). Peschmann's L-value fibres, and 172 fibres he could have had for free — **verified**

The 122 rows of his CSV whose certified quotient does *not* have a 2-descent upper bound of 0 in my data are **exactly** the rows with `rank_resolution = modular_symbol`: these are the fibres where 2-descent is inconclusive and the rank-0 certificate comes from the non-vanishing of `L(E,1)`. They are not disagreements. (Of his 504 `modular_symbol` rows, 382 happen to be resolvable by 2-descent on the dGGH model as well; 122 are not.) Counts: `E_3`/`ellrank` 359 agree, `E_3`/`modular_symbol` 357 agree and 111 do not, `E_uV`/`ellrank` 209 agree, `E_uV`/`modular_symbol` 25 agree and 11 do not.

Conversely there are **172 faces with `p <= 100` on which `EF2` has 2-descent rank bound 0 but which are absent from his list**, and `EF2` is isogenous to his own `E_uV`. `06-euv-check.out` shows what happens: on e.g. `(29,6), (31,26), (33,4), (33,32), (35,24), (37,30), (39,34)` the two curves have identical conductors (so identical rank) but `ellrank(E_uV) = [0,2]` while `ellrank(EF2) = [0,0]`. `E_uV` has cyclic torsion `Z/8` in PARI's model, `EF2` has `Z/8 x Z/2`; the full rational 2-torsion of `EF2` lets PARI run a complete 2-descent and it resolves the rank, whereas on `E_uV` it does not. The same effect appears for `E_3` versus `EF4` (at `(35,24)`: `[0,4]` versus `[0,2]`; at `(37,30)`: `[1,3]` versus `[1,1]`). **So 172 of Peschmann's 968 uncovered fibres are excluded by his own method, purely by running the descent on the dGGH representative of the isogeny class instead of his own.** Combined: `{EF2 bound 0} union {EF4 bound 0}` has 1,157 elements versus his 1,072, and their union with his list is 1,244 of 2,040 (61.0%). **verified.**

## 4. The dGGH EF3/EF4 discrepancy — settled: **the displayed formulas are wrong, the proof text is right**

### 4(a). What the paper actually prints — **verified on the PDF**

Page 11 of `2401.06784.pdf` (Definitions preceding Theorem 1):

    EF3: x(x + (p^2 - q^2)^2)(x + (p^2 - q^2 + 2pq)^2) = y^2
    EF4: x(x + 4p^2 q^2)(x + (p^2 - q^2 + 2pq)^2) = y^2

Page 13, section 7.1.3, derives them: "we require that the remaining three factors `c^2`, `b^2 + c^2` and `a^2 + b^2 + c^2`, and hence also their product, must be square: `c^2(b^2+c^2)(a^2+b^2+c^2) = y^2`. Setting `x = c^2`, we then have the elliptic curve `x(x + a^2)(x + d^2) = y^2`. The curve in this case therefore has the same structure as for the Euler brick: an 8-element torsion group with rational points at `x` in `{0, -a^2, -d^2, ad, -ad}`."

Three independent signals that the intended third root is `d^2 = (p^2+q^2)^2`, not `(a+b)^2 = (p^2-q^2+2pq)^2`: the displayed derivation, the torsion list `{0, -a^2, -d^2, ad, -ad}` (which is the torsion of `x(x+a^2)(x+d^2)`; on the displayed curve the analogous entries would be `+- a(a+b)`), and the fact that `(p^2-q^2)^2 + (2pq)^2 = (p^2+q^2)^2`, so `(p^2 - q^2 + 2pq)^2` is exactly what a lost `)^2 + (` in the source produces. (There is also a small `a`/`b` slip inside the derivation itself: `c^2(b^2+c^2)(a^2+b^2+c^2)` gives `x(x+b^2)(x+d^2)`, not `x(x+a^2)(x+d^2)`; the two displayed curves are the `a`-slot and the `b`-slot of that shape, so nothing is lost.) **verified.**

### 4(b). Face cuboids decide it — 44 examples, **verified**

`09-facecuboids.py` / `.out` enumerates, by factoring `c^2` to list all legs `b` with `b^2+c^2` square, every primitive face cuboid `(a,b,c)` with third edge `c <= 3000`: `a^2+b^2 = d^2`, `b^2+c^2` square, `a^2+b^2+c^2` square, `a^2+c^2` *not* square. There are 44. For every one of them:

    x = c^2 lies on the proof-text curve x(x+b^2)(x+d^2)       44 of 44
    x = c^2 lies on the displayed curve x(x+b^2)(x+(a+b)^2)     0 of 44

(The test is invariant under scaling the cuboid, so non-primitive faces are covered too.) Examples with a primitive face: `(153, 104, 672)` at `(p,q) = (13,4)`; `(975, 448, 264)` at `(32,7)`; `(952, 495, 264)` at `(28,17)`; `(644, 333, 2040)` at `(23,14)`; plus 40 more with scaled faces, e.g. `(672,104,153)`, `(756,117,520)`, `(2040,333,644)`, `(4180,399,468)`, `(3360,756,533)`. **The displayed curves carry none of them. verified.**

### 4(c). The displayed curves are unrelated to the problem — **verified**

`10-displayed-curve.gp` / `.out`: over all 121 faces with `p <= 24`, the two displayed curves were compared with all five factors of `J(X_s)` (which exhaust the elliptic factors of `J(X_s)` and of all three genus-3 quotients, since each genus-3 quotient has Jacobian `Q_i x P+ x P-`). Result: 1,210 pairs tested, **0 isogenies, 0 isomorphisms, and not even a single coincidence of `j`-invariants**. The conductors are different orders of magnitude (at `(5,2)`: factors `4305, 249690, 48720, 3045, 68880` versus displayed `2135280` and `262605`). The displayed curves are also not isogenous to each other. Conclusion: `x(x+a^2)(x+(a+b)^2)` is **a curve unrelated to the perfect-cuboid problem** (it is the face-cuboid curve of a "rectangle" with sides `a, b` and diagonal `a+b`, which is not a rectangle).

### 4(d). What the typo costs — **verified**

Comparing the requester's probe `../dgh-probe/04-ef-ranks-corrected-p100.out` with `02-five-factors-p100.out` (script `11-displayed-vs-text.py`, output `11-displayed-vs-text.out`), over the 2,040 faces with `p <= 100`:

    criterion                                                        excluded
    dGGH Theorem 1 with the displayed curves                          1209   59.26%
    dGGH Theorem 1 with the proof-text curves, literally ("both")      1217   59.66%
    proof-text curves, "either EF3 or EF4" (see 4(e))                  1629   79.85%

65 faces are excluded under the displayed reading but not under the requester's text criterion. Of those 65, **21 are still excluded** (all 21 by `EF4`), and **44 are not excluded by rank 0 of any of the five genuine factors**: `(29,24), (37,28), (42,29), (47,10), (48,37), (51,26), (52,17), (52,41), (53,36), (58,7), (58,37), (59,44), (62,1), (62,53), (65,28), (65,38), (67,40), (71,8), (71,12), (71,60), ...` (full list in `11-displayed-vs-text.out`). For those 44 aspect ratios the printed Theorem 1 asserts an exclusion that **no curve attached to the problem supports**. The conclusions may still be true — 2-descent simply fails to certify them here — but the printed proof does not establish them. Conversely 271 faces are excluded by the text reading and not by the displayed one. **verified.**

### 4(e). "Both EF3 and EF4" should be "either" for perfect cuboids — **verified**

A perfect cuboid on the face `(p,q)` has `a^2+c^2`, `b^2+c^2` and `d^2+c^2` all squares, hence gives a rational point with `x = c^2` on `EF3 = x(x+a^2)(x+d^2)` *and* on `EF4 = x(x+b^2)(x+d^2)`. Both curves have torsion `Z/4 x Z/2` with `x`-coordinates `{0, -a^2, -d^2, ad, -ad}` and `{0, -b^2, -d^2, bd, -bd}` respectively (**verified** on all 8,156 faces with `p <= 200`, `07-torsion-checks.out`); the only positive ones are `ad` and `bd`, and neither is ever a perfect square in that range (`ad = p^4-q^4` never is, by Fermat). Therefore **rank 0 of either one alone already excludes a perfect cuboid on that face**. The "both" in Theorem 1 is what is needed for the stronger conclusion the proof is actually establishing, namely that no *face cuboid* has that aspect ratio (a face cuboid satisfies only one of the two conditions, so one has to kill both branches). Replacing "both" by "either" raises the exclusion rate at `p <= 100` from 59.66% to 79.85% and at `p <= 200` from 58.88% to 78.02%. **verified.**

### 4(f). Published errata — **could not find any**

`arxiv.org/abs/2401.06784` has a single version `v1` and no errata note; the journal reference is Geombinatorics Quarterly XXXIII(3), p. 107 (2024); web searches for an erratum, corrigendum, a `v2`, a Gibbs blog/viXra follow-up or a MathOverflow correction found nothing that addresses EF3/EF4. **could not verify that a correction exists anywhere; the balance of evidence is that the typo stands uncorrected in both the arXiv and the journal version.** (Search results also surfaced a related independent paper, arXiv:2407.09825 "The relationship between face cuboids and elliptic curves", reported as using the family `y^2 = x(x - (2s)^2)(x + (s^2-1)^2)`. **The formula is taken from a search summary, not from the paper itself, which I did not obtain**; what is **verified** here is that *that formula*, at `s = q/p` or `s = p/q`, is `Q`-isomorphic to `EF4`. See the table in item 5.)

## 5. Unified table

Everything below is referred to the fixed face `(p,q)`, `a = p^2-q^2`, `b = 2pq`, `d = p^2+q^2`, and to the five factors

    EF1 = x(x+a^2)(x+b^2)     EF2 = x(x+a^4)(x+b^4)     EF3 = x(x+a^2)(x+d^2)     EF4 = x(x+b^2)(x+d^2)     P+ = x(x-a^2)(x-b^2)

of `J(X_s)`. `=` means the same minimal model over `Q`, `iso` means `Q`-isomorphic, `~` means `Q`-isogenous. Evidence files are named in the last column; every `=`, `iso` and `~` entry was checked at `(p,q) = (2,1), (3,2), (5,2), (8,5), (13,4)` at least, and several over all faces with `p <= 20` or `p <= 24`.

| Curve in the literature | Relation to `J(X_s)` | What rank 0 excludes | Source and evidence |
|---|---|---|---|
| Leech 1977 descent, as written by van Luijk: `((a^2-b^2)/(2ab)) u(v^2-1) = v(u^2-1)` | **iso EF1** (verified at 4 faces) | no Euler brick with face ratio `a:b`, hence no PC | van Luijk thesis Idea 3, p. 63; Leech, Amer. Math. Monthly 84 (1977). `12-other-literature.out` |
| dGGH `EF1 = x^3+(p^2+q^2)^2x^2+4p^2q^2(p^2-q^2)^2x` | **2-isogenous** to the `Rat x Master` quotient `Q1`; `= x(x+a^2)(x+b^2)` | no Euler brick on that face, hence no PC | dGGH section 7.1.1. `01-five-factors-id.out` |
| dGGH `EF2 = x^3+((p^2-q^2)^4+16p^4q^4)x^2+16p^4q^4(p^2-q^2)^4x` | **iso** the odd part `P-` of the genus-2 quotient, `= x(x+a^4)(x+b^4)` | no F-BPC on that face, hence no PC | dGGH section 7.1.2. `01-five-factors-id.out` |
| dGGH `EF3` **as displayed**, `x(x+(p^2-q^2)^2)(x+(p^2-q^2+2pq)^2)` | **unrelated**: no isogeny and not even an equal `j` with any of the five factors, over all 121 faces `p <= 24` | nothing about cuboids | dGGH p. 11 (typo). `10-displayed-curve.out`, `09-facecuboids.out` |
| dGGH `EF3` **as derived**, `x(x+a^2)(x+d^2)` | **2-isogenous** to the `Rat x Hsum` quotient `Q2` | no face cuboid with `b^2+c^2` irrational, hence no PC | dGGH section 7.1.3 text. `01-five-factors-id.out` |
| dGGH `EF4` **as displayed**, `x(x+4p^2q^2)(x+(p^2-q^2+2pq)^2)` | **unrelated**, same evidence as `EF3` displayed | nothing about cuboids | dGGH p. 11 (typo). `10-displayed-curve.out` |
| dGGH `EF4` **as derived**, `x(x+b^2)(x+d^2)` | **2-isogenous** to the `Master x Hsum` quotient `Q3` | no face cuboid with `a^2+c^2` irrational, hence no PC | dGGH section 7.1.3 text. `01-five-factors-id.out` |
| dGGH `EI1 = x(x-(p^2-q^2)^4)(x+8p^2q^2(p^4+q^4))` | **iso** the odd part `PI-` of the genus-2 quotient of the *internal-rectangle* genus-5 fibre with edge `p^2-q^2`; not a factor of `J(X_s)` | no I-BPC with that internal rectangle | dGGH section 7.3.1. `12-other-literature.out` |
| dGGH `EI2 = x(x-16p^4q^4)(x+(p^2+q^2)^4-16p^4q^4)` | **iso** `PI-` for the internal fibre with edge `2pq` | same, other slot | dGGH section 7.3.1. `12-other-literature.out` |
| dGGH `EI3 = x^3-2(p^4+q^4)x^2+(p^4-q^4)^2x` | **the same curve as EF4**: `x(x-a^2)(x-d^2)` is `EF4` after `x -> x-d^2`; identical minimal models on all faces `p <= 20` | same as `EF4` | dGGH section 7.3.2. `15-EI-equals-EF.out` |
| dGGH `EI4 = x^3-((p^2+q^2)^2+4p^2q^2)x^2+4p^2q^2(p^2+q^2)^2x` | **the same curve as EF3**: `x(x-b^2)(x-d^2)` is `EF3` after `x -> x-d^2` | same as `EF3` | dGGH section 7.3.2. `15-EI-equals-EF.out` |
| dGGH congruent-number curve `y^2 = x^3 - n^2 x`, `n = SFP(pq(p^2-q^2))` | **not a factor** of `J(X_s)`; it is the third elliptic quotient of Colman's genus-5 curve for the same face (isogenous, 6 faces checked) | no 3-BPC with that squarefree part; a different fibration of the cuboid surface | dGGH section 5.2. `12-other-literature.out`, `14-crosschecks.out` |
| Paulsen-West, CN-elliptic curves | presumably the same congruent-number curve as the row above; **not identified here** (only the citation in dGGH was available) | not determined | dGGH reference [4], Houston J. Math. **could not verify** |
| Colman's system, van Luijk eq. (43): `w^4+2Aw^3+2w^2-2Aw+1 = s^2`, `w^4+(8/A)w^3+2w^2-(8/A)w+1 = t^2`, `AD = D^2+1` | a **different genus-5 curve** over the same base: with `D = b/a` (the face aspect ratio) its second elliptic quotient is **iso P+**, its third is **~** the congruent-number curve, its first matches nothing in `J(X_s)`; five faces checked | not determined | van Luijk thesis p. 62, eq. (43), citing Colman, Fibonacci Quart. 26 (1988). `13-colman-dictionary.out`, `14-crosschecks.out` |
| `E_A` (Peschmann paper 1) | **~ EF2** | rank 0 never happens to be the branch used | `01-five-factors-id.out` |
| `E'_A` (Peschmann paper 1) | **~ P+**, hence never rank 0 | nothing (rank is always positive) | `01-five-factors-id.out`, `08-Pplus-proof.out` |
| `E''_A` (Peschmann paper 1) | **iso `Q1`**, hence `~ EF1` | as `EF1` | `01-five-factors-id.out` |
| `E_PQ` (Peschmann paper 2) | **~ P+**, hence never rank 0 | nothing | `01-five-factors-id.out` |
| `E_uV` (Peschmann paper 2) | **~ EF2** but a worse 2-descent model: `ellrank` resolves `EF2` and not `E_uV` on 172 of the 2,040 faces | as `EF2` | `01-five-factors-id.out`, `06-euv-check.out` |
| `E_3` (Peschmann paper 2) | **iso `Q3`**, hence `~ EF4`; again `EF4` is the better descent model | as `EF4` | `01-five-factors-id.out`, `06-euv-check.out` |
| `E_{m,n}` (Peschmann paper 3) | **= EF1** | as `EF1` | `01-five-factors-id.out` |
| `C_A` (Peschmann paper 1), genus 3, `w^2 = L^8 + A L^4 + 1` | `X_s / <sigma_1 sigma_2>`, hyperelliptic, `Jac ~ EF1 x P+ x EF2` | Chabauty needs total rank `<= 2` | prior seat section 2; decomposition recomputed here |
| `H_{m,n}` (Peschmann paper 2), genus 3 | `X_s / <sigma_2 sigma_3>`, hyperelliptic, `Jac ~ EF4 x P+ x EF2` | Chabauty needs total rank `<= 2` | prior seat section 7(a) |
| the third genus-3 quotient (in no paper) | `X_s / <sigma_1 sigma_3>`, hyperelliptic, `Jac ~ EF3 x P+ x EF2` | Chabauty needs total rank `<= 2` | this report |
| `P+ = x(x-a^2)(x-b^2)` (dGGH Theorem 2, edge cuboids) | the fifth factor; `= EF1` twisted by `-1`; rank `>= 1` for every face | nothing; it is the obstruction to Chabauty | dGGH section 7.2. `08-Pplus-proof.out` |
| `E_{1,s}: y^2 = x(x-(2s)^2)(x+(s^2-1)^2)`, reported as the family of arXiv:2407.09825 | **iso EF4** for `s = q/p` and for `s = p/q`, 4 faces checked; the attribution of the formula to that paper is **claimed** (taken from a search summary, the paper itself was not read) | as `EF4` | `12-other-literature.out` |
| Ramsden-Sharipov curves (arXiv:1208.1227 etc.) | different construction, not a fibration by Pythagorean faces | not applicable | prior seat section 7(c), `../peschmann-review/12-rs-curves.out` |
| Stoll-Testa: 28 genus-5 fibrations of the cuboid surface | 6 come from the rank-3 quadrics (one each), 22 from the 11 rank-4 quadrics (two each); the **face** fibration `a1^2+a2^2 = b3^2` and the **internal-rectangle** fibration `a1^2+b1^2 = c^2` are two of the six rank-3 ones, so `X_s` is a fibre of one of them | not applicable | arXiv:1009.0388 section 5, read here |

### 5(a). The internal-rectangle fibration in the same language — **verified**

Fix an internal rectangle with sides `c` (an edge) and `D` (a face diagonal), `c^2 + D^2 = g^2` with `g` the space diagonal, and let the free parameter be an edge `a`. Then `b^2 = D^2 - a^2`, `a^2 + c^2` and `g^2 - a^2 = b^2 + c^2` are the three conditions, so

    Y_s :  y1^2 = D^2 w^2 - a^2,   y2^2 = a^2 + c^2 w^2,   y3^2 = g^2 w^2 - a^2

is again a genus-5 intersection of three diagonal quadrics in `P^4`, with five elliptic factors `QI1 = (D^2-a^2)(a^2+c^2)`, `QI2 = (D^2-a^2)(g^2-a^2)`, `QI3 = (a^2+c^2)(g^2-a^2)`, and the even/odd parts `PI+`, `PI-` of the genus-2 quotient. Two structural differences from the face fibre, both **verified** (`12-other-literature.out`, `15-EI-equals-EF.out`):

- `Y_s` has an **extra involution** `a <-> b` (swap the two edges of the fixed face diagonal `D`), which exchanges the conditions `a^2+c^2` and `g^2-a^2`. Consequently `QI1` and `QI2` are isogenous to each other, and so are `QI3` and `PI+`: at `(p,q) = (2,1), (3,2), (5,2), (8,5)` the conductor lists are `[240, 240, 8160, 8160, 4080]` and so on, with `QI1` and `QI2` having equal conductors but different `j`. So `J(Y_s)` has only **three** isogeny classes among its five factors and `rk J(Y_s) = 2 rk QI1 + 2 rk QI3 + rk PI-`.
- `QI1 ~ QI2 ~ EF3` for the internal rectangle with edge `p^2-q^2`, and `~ EF4` for the one with edge `2pq`, where `EF3, EF4` are the *face* factors for the **same** `(p,q)`. Together with `EI3 = EF4` and `EI4 = EF3` this says that dGGH's Theorem 4 (internal rectangles) and Theorem 1 (faces) draw on the same two elliptic curves. The genuinely new curves of Theorem 4 are `EI1` and `EI2` (the `PI-` factors) and `QI3 ~ PI+`.

## 6. Feasibility of a Chabauty attack (no computation performed)

### 6(a). What the software can and cannot do — **verified**

`X_s` is a smooth **diagonal genus-5 curve** in exactly Stoll's sense (arXiv:1711.00500, section 2): three diagonal quadrics in `P^4`, and the `3 x 5` coefficient matrix

    [ -a^2  -1   1   0   0 ]
    [ -b^2  -1   0   1   0 ]
    [ -d^2  -1   0   0   1 ]

has all ten `3 x 3` minors nonzero (they are `-a^2, -b^2, -(a^2-b^2), -d^2, ...` and `+-1`; checked on all 737 faces with `p <= 60`, `17-smoothness-hardfibres.out`). Hence `X_s` is canonically embedded, non-hyperelliptic and non-trigonal, its automorphism group contains `A = (Z/2)^4` (the five coordinate sign changes modulo the global one), and `J(X_s) ~ E_0 x ... x E_4` where `E_j = X_s / <sigma_j>` — the intersection of the two remaining quadrics in `P^3`. These are precisely the five factors of item 1: eliminating `y1, y2, y3` gives `Q3, Q2, Q1` (isogenous to `EF4, EF3, EF1`), eliminating `c` and `w` gives `P-` and `P+` (`EF2` and `EF1^(-1)`).

**Sage 9.5** (checked by running it): `coleman_integrals_on_basis`, `coleman_integral`, `coleman_integral_P_to_S` and the Monsky-Washnitzer machinery exist on `HyperellipticCurve_padic_field`; there is **no** object named `*habaut*` anywhere in `sage.all`, no linear or quadratic Chabauty driver, and nothing that accepts a non-hyperelliptic genus-5 curve. Elliptic-curve machinery (`rank`, `L_ratio`, `two_descent`) is complete. So: **nothing in Sage 9.5 applies to `X_s` directly; the only usable `p`-adic integration is on the three genus-3 *hyperelliptic* quotients.** **verified.**

The three genus-3 quotients are `X_s / <sigma_i sigma_j>`; each is a double cover of the corresponding conic (`X_s / <sigma_i, sigma_j>`), hence **hyperelliptic**, with

    X_s/<sigma_1 sigma_2>  (Peschmann's C_A, over the Hsum conic)     Jac ~ EF1 x P+ x EF2
    X_s/<sigma_1 sigma_3>  (in no paper, over the Master conic)       Jac ~ EF3 x P+ x EF2
    X_s/<sigma_2 sigma_3>  (Peschmann's H_{m,n}, over the Rat conic)  Jac ~ EF4 x P+ x EF2

(the decomposition is the `(Z/2)^4`-character calculation of item 1(b), redone with the subgroup; it reproduces the prior seat's "private curve times `F1` times `F2`"). Classical Chabauty-Coleman on such a quotient needs `rk Jac <= 2`, and since `rk P+ >= 1` always, that means `rk P+ = 1` together with `rk(private) + rk EF2 <= 1`. Counts from the same rank data (`16-quotient-chabauty.out`):

    condition                                                      p <= 100        p <= 200
    genus-5 X_s: sum of the five bounds <= 4                     758  37.16%     2734  33.52%
    genus-3 C_A:      rk EF1 + rk P+ + rk EF2 <= 2               472  23.14%     1763  21.62%
    genus-3 Master:   rk EF3 + rk P+ + rk EF2 <= 2               466  22.84%     1660  20.35%
    genus-3 H_{m,n}:  rk EF4 + rk P+ + rk EF2 <= 2               474  23.24%     1699  20.83%
    at least one genus-3 quotient works                          774  37.94%     2839  34.81%
    genus-2 quotient (Jac = P+ x EF2), rk <= 1                   244  11.96%      926  11.35%
    elementary: some factor certified rank 0                    1629  79.85%     6363  78.02%

So: the genus-3 route covers 34.8% of faces at `p <= 200`, marginally more than the genus-5 inequality (33.5%), and both are far below the 78.0% covered by the elementary rank-0 argument, which needs no `p`-adic integration at all. **This answers the requester's question 6(a): the genus-3 quotient route is principled and implementable in Sage, but it never reaches a face that the rank-0 argument does not already reach** — because `rk(private) + rk P+ + rk EF2 <= 2` with `rk P+ >= 1` forces `rk EF2 = 0` or `rk(private) = 0`. **verified** (structural plus counts).

Note also what a genus-3 quotient does *not* give: its rational points are pairs `(c, y_i y_j)`, so a rational point of the quotient records only that a *product* of two conditions is a square. Recovering `X_s(Q)` from it requires, in addition, that both square-roots be individually rational; the prior seat made the same point about `C_A`. Determining `X_s(Q)` therefore needs the quotient's rational points **plus** a lift test, which is finite and easy once the quotient's points are known.

### 6(b). Stoll's method for diagonal genus-5 curves — what it would require — **read from the paper, not executed**

Stoll's algorithm (arXiv:1711.00500, section 2, steps 1-5) applied to `X_s` would run as follows.

1. `X_s(Q)` is non-empty (the 16 degenerate points with `c = 0` or `w = 0`), so a base point `P0` exists over `Q` and the ten conics `Q_ij` all have rational points. Compute `Sel_2(E_j/Q)` for the five factors `j = 0..4`, and from them the group `H = prod_j Q*/Q*^2 ...` in which the descent map `delta` lands, together with `H_0` and `H_1`.
2. For a finite set of places `v`, compute `delta_v(X_s(Q_v))` and intersect to get `H_0'`; verify the known rational points surject onto `H_0'`.
3. For each class `xi` in `H_0'/H_1` and each of the 30 two-torsion classes `T` in `G = ker(phi) ⊂ J[2]` (15 of the shape `[D_ij - D_kl]`, 15 of the shape `[D_ij - D_ik]`), one gets a covering curve `D_{T,xi}` and an elliptic curve `F_{T,xi}` over a **biquadratic (degree 4) field `K`**, with a map `F_{T,xi} -> P^1` over `K`. Elliptic Curve Chabauty (Bruin) then determines the `K`-points whose `P^1`-image is rational, **provided `rk F_{T,xi}(K) <= 3 = [K:Q] - 1`**, and provided one can exhibit generators of a finite-index subgroup of `F_{T,xi}(K)`.
4. Lift the points found back to `X_s(Q)`.

Concretely, for the cuboid `X_s` the quadratic fields entering the biquadratic `K` are generated by square roots of the coefficients of the diagonal quadrics, i.e. by `sqrt(-1)`, `sqrt(+-a)`, `sqrt(+-b)`, `sqrt(+-d)` and their products (Stoll obtains `K` by adjoining two square roots taken from the entries defining the two conics whose difference is `T`; there are up to 90 choices, and one picks the field of smallest discriminant or the best Selmer bound). **This is the part I did not carry out and cannot estimate reliably**: the exact list of the 30 fields for a given face was not computed here.

Software split, from the paper and from what is installed:

- **PARI/GP or Sage can do**: the 2-Selmer groups of the five `E_j` over `Q` (done, at scale, in this report); the local images `delta_v`; the arithmetic of the covering curves as equations; `mwrank`/`ellrank` style descent over `Q`. Rank bounds over a **number field** are also available in Sage 9.5 via `E.rank_bounds()` / `E.simon_two_descent()` (Simon's two-descent), which returns a bound and some points — checked here on a test curve over `Q(sqrt 2)`, returning `(1,1)` and five points. PARI's `ellrank` is `Q`-only (it errors on an `nfinit` base).
- **Magma is required for**: `Chabauty(MWmap, Ecov)` (Bruin's Elliptic Curve Chabauty) — there is no equivalent in Sage or PARI; `MordellWeilShaInformation`/`Saturation` over a quartic field, i.e. actually *finding generators* of `F_{T,xi}(K)`, which Stoll himself flags as the hard step ("if this does not give enough points, then it may be difficult to find the missing generators"); and the Mordell-Weil sieve in its `Magma` implementation. Stoll states explicitly that all computations in the paper were done in Magma.

Stoll's genericity remark is worth recording because the cuboid curve **violates** it: he notes that for a diagonal genus-5 curve with a rational point `P0`, differences of the images of the `A`-orbit of `P0` "usually" have infinite order, "so the rank of each `E_i(Q)` will be positive, and the rank of `J(Q)` will be at least 5; in particular, standard Chabauty techniques are not applicable". For `X_s` the obvious rational points are **not** generic: `P0 = (1 : 0 : a : b : d)` is fixed by `sigma_c` and `(0 : 1 : 1 : 1 : 1)` is fixed by `sigma_w`, so their `A`-orbits have size 8 rather than 16 and the induced points on `E_0, ..., E_3` are torsion. That is exactly why `rk EF1..EF4 = 0` is common (33% each) while `rk P+ >= 1` always: `P+` is the one factor on which the degenerate point `c = 0` gives a point of infinite order (item 1(f)). **verified.**

### 6(c). What it would take to kill a hard fibre

First, a correction to the premise: **`(5,2)` is not hard any more.** Its bounds are `[1,1], [1,1], [0,0], [1,1], [2,2]`, i.e. `rk EF3 = 0` exactly, so the face ratio `21:20` is excluded outright (item 3(b)) — no Chabauty needed, and no Chabauty available either (`rk J(X_s) = 5`).

A genuinely hard fibre is one where 2-descent proves all five ranks to be exactly 1, so `rk J(X_s) = 5` **exactly** and no Chabauty-type method with `rk < g` can ever apply. There are 155 such faces with `p <= 200` (1.90%), the smallest being `(32,7), (34,11), (35,2), (42,13), (43,10), (44,17), (47,10), (52,9), (57,14), (59,22)` (`17-smoothness-hardfibres.out`, `16-quotient-chabauty.out`). `(32,7)` is the face of the face cuboid `(975, 448, 264)`, so `EF4` genuinely has a point there. More broadly, at `p <= 200` 2-descent determines all five ranks exactly on 48.8% of faces, and on 23.8% of all faces it proves `rk J(X_s) >= 5`, which **rules out linear Chabauty on `X_s` unconditionally**.

For such a face, the work splits as follows.

- **Doable in PARI/GP or Sage** (all of it cheap): the five Weierstrass models and their 2-Selmer bounds; `L(E,1)` certificates via `ellL1` or Sage `L_ratio` when 2-descent is ambiguous (this is what recovers the 122 fibres where Peschmann needed modular symbols); generators of `E_j(Q)` over `Q`; explicit models of the covering curves `D_{T,xi}`; the local conditions `delta_v` at small `v`; the Mordell-Weil sieve *for the elliptic factors over `Q`* (this can be scripted in PARI, though no ready-made routine exists).
- **Needs Magma** (no Sage or PARI equivalent): Elliptic Curve Chabauty over the quartic fields `K` — Sage has no object whose name contains `chabauty` at all; and **saturation** of the subgroup found by Simon's descent over `K` (Sage returns generators of a subgroup of finite, unknown index, whereas Elliptic Curve Chabauty needs a group of known index); Stoll's "Selmer group Chabauty" fallback when the generators are not found. Stoll's own `diophtuples.magma` is the reference implementation for the identical curve shape and would need only the change of the three quadrics.
- **Not available anywhere off the shelf**: quadratic Chabauty for a non-hyperelliptic genus-5 curve. The Balakrishnan-Dogra machinery that Stoll cites is implemented only for (bi)elliptic and hyperelliptic curves of small genus.

The pragmatic ordering suggested by the numbers: (i) rerun the rank-0 test on the *dGGH models* rather than on any other representative of the isogeny class (172 free fibres, item 3(c)); (ii) add the L-value certificate on the residue (46 of the 411 undecided faces at `p <= 100` are already known to be rank 0 that way, from Peschmann's list); (iii) only then consider Elliptic Curve Chabauty, and only on faces where 2-descent has *not* already proved `rk J(X_s) >= 5`.

## Observations the requester might miss

- **The genus-5 Chabauty programme cannot beat the rank-0 argument, for a trivial reason.** `g - 1 = 4` and there are five elliptic factors, so `rk J <= 4` forces one factor to have rank 0; and rank 0 of one factor already finishes the fibre. The same holds for every genus-3 quotient (`g - 1 = 2`, three factors, and one of the three always has rank `>= 1`). Any gain from Chabauty on this surface has to come from a *quadratic* Chabauty or a covering-collection method, not from the linear one. This is the single most consequential finding of this report.
- **`P+ = EF1^(-1)` always has rank `>= 1`, with a short proof.** The point `(d^2, abd)` lies in `2E(Q)` because `d^2`, `d^2-a^2 = b^2` and `d^2-b^2 = a^2` are all squares; 4-torsion is excluded by Fermat's `u^4 - v^4 != square`; and `ord = 3` is excluded by an explicit duplication computation. It is the image of the degenerate point `c = 0`. Since every genus-3 quotient and the genus-2 quotient contain this factor, it is a structural floor on all of them.
- **172 free fibres for Peschmann.** His `E_uV` and dGGH's `EF2` are isogenous but PARI's `ellrank` resolves `EF2` and not `E_uV` on 172 faces, because `EF2` has full rational 2-torsion and `E_uV` only `Z/8` cyclic. Whenever a paper certifies rank 0 by 2-descent, the *choice of representative in the isogeny class matters*; the dGGH models (all of the form `x(x+A)(x+B)`) are the good ones. The same effect costs him accuracy on `E_3` versus `EF4`.
- **dGGH's Theorem 4 is not independent of Theorem 1.** `EI3` and `EI4` are literally `EF4` and `EF3` translated by `d^2`, with identical minimal models on every face with `p <= 20`. The only genuinely new curves in the internal-rectangle analysis are `EI1`, `EI2`.
- **The internal-rectangle genus-5 fibre is a different kind of object from the face fibre**: it carries an extra involution (swap the two edges of the fixed face diagonal), so two of its five factors are isogenous to two others and `rk J = 2r_1 + 2r_3 + r_5`. Its Chabauty inequality is correspondingly harder to satisfy. This asymmetry between the six rank-3 Stoll-Testa fibrations does not seem to be noted anywhere.
- **Colman's system and dGGH's congruent-number algorithm are the same object seen twice.** Colman's genus-5 curve for the aspect ratio `D = b/a` has the congruent-number curve `y^2 = x^3 - n^2 x`, `n = SFP(pq(p^2-q^2))`, as one of its three elliptic quotients, and `P+` as another. So dGGH's section 5 algorithm and van Luijk's eq. (43) live on the same curve, and one of its factors is a factor of `X_s`.
- **`ad = p^4 - q^4` being a non-square is Fermat's theorem**, which is what makes "rank `EF3` = 0 excludes the face" airtight without any further torsion analysis. The corresponding statements for `EF1` and `EF4` reduce to `e^4 - f^4 = 2g^2` and `e^4 + 4f^4 = g^2`, checked to `e <= 3000` here but not proved.
- **Peschmann's "hard fibre" `(5,2)` is dead**, and by the factor his method never looks at. Any similar list of "hard fibres" produced by a pipeline that uses only two of the five factors should be re-tested against all five before being treated as evidence of difficulty.
- **A concrete, cheap next experiment**: over `p <= 200`, 1,793 faces have no factor with a certified rank-0 bound. 46 of the 411 such faces with `p <= 100` are nevertheless rank 0 by Peschmann's L-value route. Running `ellL1`-based (or Sage `L_ratio`) certificates on all five factors of the 1,793 would quantify how much of the residue is 2-descent weakness rather than genuine positive rank; the residue after that is the real target set.
- **The requester's classification scheme should be retired.** Classes A/B/C/D conflate two different things. The informative split is: (i) some factor certified rank 0 (fibre dead); (ii) `rk J(X_s) >= 5` certified by the *lower* bounds (Chabauty provably dead); (iii) neither (2-descent inconclusive). At `p <= 200` those are 78.0%, 39.1% and the overlap/remainder as tabulated in 2(f).

## Files in this directory

| File | Purpose |
|---|---|
| `01-five-factors-id.gp` / `.out` | The seven subcovers of `X_s` in the `c`-coordinate, the prior seat's rho-coordinate factors, dGGH `EF1..EF4` in both readings, `EF1^(-1)`, and the nine trilogy curves, with `j`, conductor, torsion, `ellrank` and the full isomorphism/isogeny matrix at `(p,q) = (2,1), (3,2), (5,2), (8,5), (13,4)` |
| `02-five-factors-p100.gp`, `02-five-factors-p100.part{0,1,2,3}.out`, `02-five-factors-p100.out` | `ellrank` upper bounds for the five factors on all 2,040 faces with `p <= 100`; merged file has `p q R1 R2 R3 R4 R5 class zeros seconds` |
| `03-five-factors-p200.gp`, `03-five-factors-p200.part{0,1,2,3}.out`, `03-five-factors-p200.out`, `03-five-factors-p200.ub.out` | the same for `p <= 200`, recording both `ellrank` bounds; the `.ub.out` file is reduced to the column format of item 2 |
| `04-stats.py`, `04-stats-p100.out`, `04-stats-p200.out` | class counts, per-factor rank-0 rates, exclusion rates under the various criteria, bands of `p`, bound distributions |
| `04b-sharpness-p200.py` / `.out` | how often `ellrank` is sharp, and the Chabauty inequality under both bound directions |
| `05-peschmann-coverage.py` / `.out`, `05b-peschmann-detail.py` / `.out`, `05c-peschmann-breakdown.py` / `.out` | Peschmann's 1,072 proven fibres versus the five-factor data; classification of the 968 uncovered ones; the 122 L-value rows; the 172 fibres available from `EF2` |
| `06-euv-check.gp` / `.out` | `E_uV` versus `EF2` and `E_3` versus `EF4` on ten fibres: same conductor, different `ellrank` resolution |
| `07-torsion-checks.gp` / `.out` | torsion of the five factors and the squareness of `ab`, `ad`, `bd` on all 8,156 faces with `p <= 200` |
| `08-Pplus-proof.gp` / `.out` | the four steps of the proof that `rk P+ >= 1`, plus `elltors` and `ellorder` over all faces with `p <= 200` |
| `09-facecuboids.py` / `.out` | all 44 face cuboids with third edge `<= 3000`, and which reading of `EF3`/`EF4` carries them |
| `10-displayed-curve.gp` / `.out` | the displayed dGGH curves versus the five factors over all 121 faces with `p <= 24` |
| `11-displayed-vs-text.py` / `.out` | faces excluded only under the displayed reading, and whether the genuine factors still exclude them |
| `12-other-literature.gp` / `.out` | Leech/van Luijk Idea 3, the congruent-number curve, the arXiv:2407.09825 family, `EI1..EI4` versus the internal-rectangle fibration, and Colman's system |
| `13-colman-dictionary.gp` / `.out` | Colman's parameter `D` identified with the face aspect ratio `2pq : (p^2-q^2)` |
| `14-crosschecks.gp` / `.out` | Colman's third quotient versus the congruent-number curve; internal-rectangle factors versus face factors |
| `15-EI-equals-EF.gp` / `.out` | `EI3 = EF4` and `EI4 = EF3` as minimal models on all faces with `p <= 20`; the repeated factors of the internal fibre |
| `16-quotient-chabauty.py` / `.out` | Chabauty applicability on `X_s`, on the three genus-3 quotients and on the genus-2 quotient; faces with all five ranks exactly 1 |
| `17-smoothness-hardfibres.gp` / `.out` | the ten `3 x 3` minors (diagonal genus-5 smoothness) and the exact rank data for the hardest fibres |

`00-brief-draft.md` predates this report and is not part of it.
