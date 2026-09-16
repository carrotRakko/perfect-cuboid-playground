# The perfect cuboid problem: a map of the frontier (late 2026)

Purpose: not a survey of everything ever written on rational boxes, but a map of where the active front is now, what the people at the front say is open, and where computation plus an AI research assistant can enter. Confidence labels: [primary] read in the paper itself; [reproduced] recomputed here (scripts in `scratch/`); [inferred] our reading, not yet confirmed; [unverified] taken from abstracts or secondary sources only.

## 0. The problem and the numbers

A perfect cuboid has positive integers a, b, c (edges) with a^2 + b^2, a^2 + c^2, b^2 + c^2 and a^2 + b^2 + c^2 all squares. None is known; nonexistence is not proved.

- Exhaustive searches [unverified, quoted by the 2026 papers as current]: no perfect cuboid with odd edge below 2.5 x 10^13 or smallest edge below 5 x 10^11 (Matson 2015, extending Butler and Rathbun); none with space diagonal below 2^53 (Belogourov 2019).
- Congruence conditions on a primitive perfect cuboid (Kraitchik, Leech, Korec, van Luijk) [unverified here]: one edge odd, one divisible by 4, one by 16; edges divisible by 3, 9, 5, 7, 11, 19; 13 divides an edge or the space diagonal; 17, 29, 37 divide one of the seven lengths; every prime factor of the space diagonal is 1 mod 4.
- Almost-perfect cuboids (six of seven lengths integral: body, edge and face cuboids) exist in infinite families; Rathbun's table (2020) lists 167,043 of them with smallest edge below 2 x 10^11.

## 1. One surface, 28 fibrations

The solutions form a surface. In the homogeneous coordinates [a1 : a2 : a3 : b1 : b2 : b3 : c] of P^6 the four equations a_i^2 + b_i^2 = c^2 (i = 1, 2, 3) and a1^2 + a2^2 + a3^2 = c^2 cut out the cuboid surface S-bar (here b_i is the diagonal of the face opposite edge a_i and c the space diagonal). Facts [primary]:

- van Luijk (2000, undergraduate thesis, Utrecht): S-bar is of general type. Under the Bombieri-Lang conjecture its rational points are not Zariski dense, so a perfect cuboid, if any, is an isolated point outside the finitely many curves that carry the degenerate solutions.
- Stoll and Testa (arXiv:1009.0388, v2 February 2025): S-bar is a complete intersection of four quadrics with 48 isolated A1 singularities; the geometric Picard group of its desingularization S has rank 64 (the maximum, equal to h^{1,1}) with explicit generators and Galois action; Aut(S) has order 1536; there are no curves of odd degree and no integral curves of degree 6; all integral curves of degree at most 6 are classified (32 conics, genus-1 curves, exceptional curves). The algebraic part of the Brauer group gives no Brauer-Manin obstruction (Theorem 10); the transcendental part is left open. S-bar is a quotient of X(8) x X(8) (Beauville), so the surface is modular.
- Stoll and Testa, Section 5: S-bar carries exactly 28 fibrations by curves of genus 5 (one from each of the 6 quadrics of rank 3 containing S-bar, two from each of the 11 quadrics of rank 4). A generic fiber is a canonical curve of degree 8 in P^4 given by three diagonal quadrics, on which a group (Z/2Z)^4 or (Z/2Z)^3 of sign changes acts; the quotients by subgroups are curves of genus 1, 2 and 3. The 96 irreducible singular fibers are hyperelliptic curves of genus 3.
- Horie and Yamauchi (arXiv:2512.22520, v3 March 2026): the L-function of H^2 of S-bar is a product of L-functions of weight-3 newforms of levels 8, 16, 32 and Tate twists of Dirichlet L-functions, and Pic(S over Q-bar) is made explicit as a Galois module (34 divisors over Q, 26 over Q(i), 1 over Q(sqrt(-2)), 3 over Q(sqrt(2))).

Consequence: "does a perfect cuboid exist" is the same question as "does some fiber of one of the 28 fibrations, at some rational parameter t, carry a rational point outside the degenerate locus". Fixing t means fixing one ratio, for example the aspect ratio of one face (rank-3 quadric a1^2 + a2^2 = b3^2) or of one internal rectangle edge : face diagonal (rank-3 quadric a1^2 + b1^2 = c^2).

## 2. The elliptic-curve reductions of 2022-2026 are quotients of these fibers

Every recent "elliptic curve attached to the perfect cuboid" that we have read fixes one such ratio and then divides the genus-5 fiber by one or more sign changes. For the face-fixed case this is now [reproduced] by the reviewer seat in `scratch/peschmann-review/` (Section 7 there): with a face of parameters (p, q), the genus-5 curve X_s = {Rat, Master, Hsum all squares} has Jacobian isogenous to EF1 x EF2 x EF3 x EF4 x F2, where EF1-EF4 are de Grey-Gibbs-Helm's curves (EF3, EF4 as derived in their proof) and F2 is a fifth curve (Peschmann's E'_A, never semistable) that de Grey-Gibbs-Helm do not use; every elliptic curve in Peschmann's three papers is, up to isogeny, one of these five, and none of the three papers cites de Grey-Gibbs-Helm. Extension to the other fibrations is the job of `scratch/unification/`.

- de Grey, Gibbs and Helm (Geombinatorics 33, 2024; arXiv:2401.06784) [primary]. Fix a face with Pythagorean parameters (p, q): a = p^2 - q^2, b = 2pq, d = p^2 + q^2. Then EF1: y^2 = x(x + a^2)(x + b^2) is the body-cuboid (Euler brick) quotient (x = c^2), EF2: y^2 = x(x + a^4)(x + b^4) the "F-BPC" quotient (all four remaining lengths sharing a square-free part), and the face-cuboid quotients are, by the proof in their Section 7.1.3, y^2 = x(x + a^2)(x + d^2) and y^2 = x(x + b^2)(x + d^2). Theorem 1: rank zero of EF1 or of EF2, or of both face-cuboid curves, excludes the aspect ratio a : b from every perfect cuboid. Theorem 4 does the same for internal rectangles with EI1-EI4. Their computation: for p <= 1000 (202,861 pairs) 57 percent of face ratios and 17 percent of internal-rectangle ratios are excluded.
- Peschmann (arXiv:2604.09328, 2604.28072, 2605.00573; April-May 2026; single author, not refereed) [primary for the statements; independently verified in `scratch/peschmann-review/`: the main theorem of the second paper and its 1,072 fibers reproduce in PARI alone; the first paper's Theorem 6.2(a) has a broken proof and its 2-descent exclusions are not established; the third paper's blocker "phenomenon" reproduces on all 151,575 released records but its base conjectures are restatements of the perfect cuboid conjecture; several cross-identifications between the papers are wrong but unused]. Parametrizes Euler bricks by two Euclid pairs (a, b), (m, n), reduces the perfect condition (two quartic expressions simultaneously square) to the genus-3 hyperelliptic curve C_A : w^2 = lambda^8 + A lambda^4 + 1 (a quotient by two simultaneous sign changes; note that "the product is a square" is weaker than "both are squares", so C_A is a quotient of the genus-5 fiber, and the author names the "genus-5 covering obstruction" as future work). The Jacobian of the genus-3 fiber H_{m,n} splits as three elliptic curves; when one of them has rank zero and the right torsion, the fiber carries only eight rational points, all degenerate. Result: 1,072 of the 2,040 fibers with max(m, n) <= 100 are excluded unconditionally; the rest are fibers where the rank is not yet decided (large conductor) or "hard fibers" where all three factors have rank at least 1 (example (m, n) = (5, 2): ranks 2 + 1 + 1). The third paper observes on 151,575 body cuboids that the space-diagonal norm always has a prime factor of exponent exactly one ("exponent-one blocker"), and generates 1.28 million body cuboids from Mordell-Weil generators, none perfect.
- Paulsen and West (Houston J. Math. 48, 2022) [unverified, abstract only]: a perfect cuboid forces a congruent number whose elliptic curve has rank at least 2; they prove nonexistence for rank-1 congruent numbers and test the others up to 7500.
- Older: Leech (1977) excluded the face ratio 4 : 3 by descent (this is EF1 at (2, 1), conductor 21, rank 0); Colman (cited by van Luijk) wrote the problem as two elliptic curves over a conic, which is the fibration picture; Ramsden and Sharipov (2012-2013) derived two-parameter families of elliptic curves from a symmetry reduction and applied 2- and 3-descent.
- Sharipov's route (2012): perfect cuboids correspond to rational roots of a degree-12 polynomial P_{a,b,u}(t) in three integer parameters; irreducibility of P and of two degenerate specializations (the three "cuboid conjectures") would imply nonexistence (sufficient, not equivalent). Asiryan claims a proof of the first conjecture (arXiv:2510.11768, degree 8, via a fixed rank-zero curve of conductor 48) and, with Magma's Chabauty on a fixed genus-2 curve, that the second polynomial has no rational root (arXiv:2601.04241). The third conjecture (the general case) is untouched.

## 3. The single exclusion argument

Let E be an elliptic quotient of a fiber, defined over Q. If rank E(Q) = 0 then E(Q) is its torsion subgroup, which is computable and finite; if every torsion point corresponds to a degenerate cuboid (an edge of length zero), then that fiber contains no perfect cuboid, unconditionally. Rank zero is certified either by a 2-descent whose Selmer bound is zero (PARI `ellrank`, milliseconds for the curves here) or, when the 2-Selmer group is larger than the torsion allows, by L(E, 1) not equal to 0 computed exactly as a rational multiple of the period via modular symbols (SageMath), which gives rank zero by modularity and Kolyvagin. Both routes are available in the environment of this repo.

This is the mirror image of the high-rank search on the companion project: same 2-descent machinery, opposite goal.

## 4. Numbers reproduced here [reproduced]

| what | range | result |
|---|---|---|
| de Grey-Gibbs-Helm Theorem 1 with the displayed EF1-EF4 | coprime opposite-parity (p, q), p <= 200 (7,970 pairs) | 58.8 percent excluded; per band of 50: 62, 58, 60, 58 percent |
| same, with the face-cuboid curve as derived in their proof | p <= 100 (2,040 pairs) | 69.4 percent excluded (versus 59.3 percent with the displayed curves) |
| cost | one pair, four curves, 2-descent | about 5 ms at p <= 30, about 0.2 s at p near 150 |
| sum of the four 2-descent rank bounds | p <= 200 | at most 4 for 75 percent of pairs; among non-excluded pairs, 20 percent of all pairs have sum at most 4 |
| Sage L-ratio certificate | EF1 at (2, 1) | conductor 21, L(E, 1)/Omega = 1/8, analytic rank 0 |

The discrepancy between the displayed EF3/EF4 and the derivation is described in the README; the known face cuboid (104, 153, 672) decides it in favour of the derivation.

## 5. What the authors leave open

- de Grey, Gibbs and Helm, Section 10: nonexistence of 2-BPCs (two of the seven lengths non-integral with a common square-free part; their elliptic-curve method does not apply, the curves are hyperelliptic); a proof that their parametric families of edge cuboids contain no perfect cuboid; a lower bound on the size of a perfect cuboid as a function of the Pythagorean parameters; whether a condition C(p, q) forces rank zero uniformly; whether the excluded aspect ratios have positive asymptotic density (their data suggest yes; no proof).
- Peschmann, Section 5.2 of the second paper: quadratic Chabauty for the hard fibers (rank of the Jacobian equal to the genus 3); Mordell-Weil sieving using the split Jacobian; a Brauer-Manin obstruction on the surface; a modular or CM interpretation of the third factor giving uniform rank bounds; Goldfeld-type statistics. First paper: the genus-5 covering.
- Stoll and Testa: the transcendental Brauer group; curves of degree 8 and more; the rational points of the fibers are not discussed.
- Sharipov: the third cuboid conjecture.

## 6. Where computation and an AI assistant can enter

Ranked by our estimate of value against feasibility; the human decides.

1. Chabauty on the genus-5 fibers rather than on the genus-3 quotient. Peschmann works on genus-3 quotients (C_A in the first paper, H_{m,n} in the second), where linear Chabauty needs rank(Jac) < 3 and the hard fibers fail it. The true object is the genus-5 curve X_s with J(X_s) ~ EF1 x EF2 x EF3 x EF4 x F2 [reproduced by the reviewer seat], so the linear condition is rk EF1 + rk EF2 + rk EF3 + rk EF4 + rk F2 <= 4; Peschmann's method is the special case where one summand is 0. Whether the extra factors leave many hard fibers inside the bound is being measured in `scratch/unification/`. Stoll (Acta Arith. 190, 2019; arXiv:1711.00500) determined the rational points of exactly this kind of curve (three diagonal quadrics in P^4) for rational Diophantine quintuples, with elliptic-curve Chabauty and the Mordell-Weil sieve; we found no application of that method to the cuboid fibers [unverified: absence of evidence in our searches]. The smallest genuine result would be to settle one of Peschmann's hard fibers this way.
2. A unification table: identify every curve in Section 2 as a named quotient of a named fibration (j-invariants, conductors, isogenies), and record for each fibration which quotient's rank zero excludes the fiber. This is bookkeeping that an AI does well, and it is the blueprint for item 1. Byproduct: the proportion of fibers where the summed rank bounds allow Chabauty at all.
3. Positive density of excluded ratios (de Grey, Gibbs and Helm 10.6; Peschmann (v)). The numerical side is cheap (bands stable at 58-62 percent, or higher with the corrected curve). The proof side is about the distribution of root numbers and 2-Selmer ranks in these explicit families; this is where mathematical thinking rather than computation is needed.
4. Transcendental Brauer group of S (Stoll and Testa open; Horie and Yamauchi supply the Galois representation on H^2). Specialist work; it obstructs weak approximation, not existence (the degenerate points are rational, so the Brauer-Manin set is nonempty).
5. Sharipov's third conjecture: three parameters, no fixed curve to reduce to; feasibility unclear.

Not goals here: pushing the exhaustive-search bounds; a proof of nonexistence; extending Peschmann's 1,072 by the same method (that is engineering, not a new idea).

## 7. Tooling

- PARI/GP 2.15 with elldata/seadata: 2-descent (`ellrank`), point search (`hyperellratpoints`), everything in `scratch/dgh-probe/`.
- SageMath 9.5 (Debian package): exact L(E, 1)/Omega by modular symbols (unconditional rank-zero certificate), Coleman integration on hyperelliptic curves (`coleman_integrals_on_basis`), elliptic curves over number fields. No built-in Chabauty for genus above 1 and no elliptic-curve Chabauty; those would have to be implemented on top of the primitives.
- Magma: the standard tool for Chabauty and the Mordell-Weil sieve. The free online calculator sits behind HTTP basic authentication as of this writing, so it is not available here.

## 8. What we have not verified

Everything marked [unverified] above; the identification of the literature's curves with fiber quotients beyond the face-fixed fibration (internal rectangles, Paulsen-West, Colman); Asiryan's proofs; whether the de Grey-Gibbs-Helm computation used the displayed or the derived face-cuboid curves. Peschmann's classification theorem and torsion-intersection argument have been verified (see `scratch/peschmann-review/output.md`, Sections 1 and 4).
