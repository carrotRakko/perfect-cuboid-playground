# The perfect cuboid problem: a map of the frontier (late 2026)

Purpose: not a survey of everything ever written on rational boxes, but a map of where the active front is now, what the people at the front say is open, what we could verify or refute in one working day with a small machine, and where computation plus an AI research assistant can enter usefully. Confidence labels: [primary] read in the paper itself; [reproduced] recomputed here (scripts in `scratch/`); [proved] a short argument written out in one of the reports; [inferred] our reading, not confirmed; [unverified] taken from abstracts or secondary sources only.

## 0. The problem and the numbers

A perfect cuboid has positive integers a, b, c (edges) with a^2 + b^2, a^2 + c^2, b^2 + c^2 and a^2 + b^2 + c^2 all squares. None is known; nonexistence is not proved.

- Exhaustive searches [unverified, quoted by the 2026 papers as current]: no perfect cuboid with odd edge below 2.5 x 10^13 or smallest edge below 5 x 10^11 (Matson 2015, extending Butler and Rathbun); none with space diagonal below 2^53 (Belogourov 2019).
- Congruence conditions on a primitive perfect cuboid (Kraitchik, Leech, Korec, van Luijk) [unverified here]: one edge odd, one divisible by 4, one by 16; edges divisible by 3, 9, 5, 7, 11, 19; 13 divides an edge or the space diagonal; 17, 29, 37 divide one of the seven lengths; every prime factor of the space diagonal is 1 mod 4.
- Almost-perfect cuboids (six of seven lengths integral: body, edge and face cuboids) exist in infinite families; Rathbun's table (2020) lists 167,043 of them with smallest edge below 2 x 10^11.

## 1. One surface, 28 fibrations

The solutions form a surface. In the homogeneous coordinates [a1 : a2 : a3 : b1 : b2 : b3 : c] of P^6 the four equations a_i^2 + b_i^2 = c^2 (i = 1, 2, 3) and a1^2 + a2^2 + a3^2 = c^2 cut out the cuboid surface S-bar (b_i is the diagonal of the face opposite edge a_i and c the space diagonal). Facts [primary]:

- van Luijk (2000, undergraduate thesis, Utrecht): S-bar is of general type. Under the Bombieri-Lang conjecture its rational points are not Zariski dense, so a perfect cuboid, if any, is an isolated point outside the finitely many curves that carry the degenerate solutions.
- Stoll and Testa (arXiv:1009.0388, v2 February 2025): S-bar is a complete intersection of four quadrics with 48 isolated A1 singularities; the geometric Picard group of its desingularization S has rank 64 (the maximum) with explicit generators and Galois action; Aut(S) has order 1536; all integral curves of degree at most 6 are classified; the algebraic part of the Brauer group gives no Brauer-Manin obstruction (their Theorem 10), the transcendental part is left open; S-bar is a quotient of X(8) x X(8) (Beauville), so the surface is modular.
- Stoll and Testa, Section 5: S-bar carries exactly 28 fibrations by curves of genus 5 (one from each of the 6 quadrics of rank 3 containing S-bar, two from each of the 11 quadrics of rank 4). A generic fiber is a canonical curve of degree 8 in P^4 cut out by three diagonal quadrics, with a group of sign changes acting; quotients have genus 1, 2 and 3.
- Horie and Yamauchi (arXiv:2512.22520, v3 March 2026): the L-function of H^2 of S-bar is a product of L-functions of weight-3 newforms of levels 8, 16, 32 and Tate twists of Dirichlet L-functions, and Pic(S over Q-bar) is made explicit as a Galois module.

Consequence: "does a perfect cuboid exist" is the same question as "does some fiber of one of the 28 fibrations, at some rational parameter, carry a rational point outside the degenerate locus". Fixing the parameter means fixing one ratio, for example the aspect ratio of one face (the rank-3 quadric a1^2 + a2^2 = b3^2) or of one internal rectangle edge : face diagonal (the rank-3 quadric a1^2 + b1^2 = c^2).

## 2. The face-fixed fiber and its five elliptic factors [reproduced, partly proved]

Fix a face with Pythagorean parameters (p, q): a = p^2 - q^2, b = 2pq, d = p^2 + q^2. A perfect cuboid on that face is a rational point with c not 0 on the genus-5 curve

    X_s :  y1^2 = c^2 + a^2 w^2,   y2^2 = c^2 + b^2 w^2,   y3^2 = c^2 + d^2 w^2   in P^4,

a diagonal genus-5 curve in exactly the sense of Stoll (Acta Arith. 190, 2019; arXiv:1711.00500). The Kani-Rosen decomposition of its Jacobian has five elliptic factors, and the whole 2022-2026 elliptic-curve literature on the problem lives on them (`scratch/unification/output.md`, Sections 1 and 5; `scratch/peschmann-review/output.md`, Section 7):

    J(X_s)  ~  EF1  x  EF1^(-1)  x  EF2  x  EF4  x  EF4^(-1)

with EF1 = x(x + a^2)(x + b^2) (the Euler-brick curve; Leech's 1977 descent for the face 4 : 3 is its rank-zero case at (2, 1)), EF2 = x(x + a^4)(x + b^4), EF4 = x(x + b^2)(x + d^2) (face cuboid with a^2 + c^2 irrational), EF3 = EF4^(-1) = x(x + a^2)(x + d^2) (face cuboid with b^2 + c^2 irrational) and P+ = EF1^(-1) = x(x - a^2)(x - b^2), where E^(-1) denotes the quadratic twist by -1. EF3 and EF4 share a j-invariant but are not Q-isomorphic and not isogenous; their ranks differ.

- de Grey, Gibbs and Helm (Geombinatorics 33, 2024; arXiv:2401.06784) [primary] use EF1-EF4 (their Theorem 1) and EI1-EI4 (Theorem 4, internal rectangles). Two corrections are established here: the displayed formulas for EF3 and EF4 (third root (p^2 - q^2 + 2pq)^2) are a misprint for the curves derived in their own proof (third root (p^2 + q^2)^2): all 44 face cuboids with third edge at most 3000 lie on the derived curves and none on the displayed ones, and the displayed curves share no j-invariant with any factor of J(X_s) [reproduced]. And the condition "both EF3 and EF4 have rank zero" in Theorem 1 can be weakened to "either", because a perfect cuboid gives a non-torsion point on each [proved, using Fermat's theorem that p^4 - q^4 is never a square for the torsion analysis of EF3]. EI3 and EI4 are the same curves as EF4 and EF3 after a translation, so Theorem 4's cubic branch is not independent of Theorem 1; the genuinely new curves there are EI1 and EI2, factors of the internal-rectangle fiber, which carries an extra involution and has only three isogeny classes among its five factors.
- Peschmann (arXiv:2604.09328, 2604.28072, 2605.00573; April-May 2026; single author, not refereed) [primary; independently verified in `scratch/peschmann-review/`]. Every elliptic curve in the three papers is one of the five factors up to isogeny (E_{m,n} = EF1; E_uV ~ EF2; E_3 ~ EF4; E''_A ~ EF1; E'_A ~ E_PQ ~ P+), and none of the papers cites de Grey, Gibbs and Helm. The main theorem of the second paper (1,072 fibers with max(m, n) <= 100 excluded unconditionally through rank zero of E_3 or E_uV plus a torsion condition) is correct and reproduces in PARI alone; its torsion condition is automatic for a structural reason; its identifications with the first paper are wrong but unused. The first paper's Theorem 6.2(a) has a broken proof (numerically refuted intermediate claim at s = 9/2), so its 2-descent exclusions are not established. The third paper's "exponent-one blocker phenomenon" reproduces on all 151,575 released records, but its base conjectures are restatements of the perfect cuboid conjecture.
- P+ always has positive rank [proved]: the degenerate point c = 0 gives (d^2, abd), which lies in 2E(Q) and is neither 4-torsion (Fermat) nor 3-torsion (duplication formula). This is the curve-level content of de Grey, Gibbs and Helm's Theorem 2 (an edge cuboid exists for every Pythagorean face ratio), which they state without proof.
- Older and adjacent: Colman (cited by van Luijk) wrote the problem as two elliptic curves over a conic; that is a different genus-5 curve over the same base, one of whose quotients is P+ and another the congruent-number curve y^2 = x^3 - n^2 x with n the square-free part of pq(p^2 - q^2), which is also the curve behind de Grey, Gibbs and Helm's first search algorithm and, presumably, Paulsen and West (Houston J. Math. 48, 2022) [unverified]. Ramsden and Sharipov (2012-2013) use a different construction. Sharipov's three cuboid conjectures (irreducibility of polynomials in up to three parameters; sufficient for nonexistence) are attacked by Asiryan (arXiv:2510.11768 claims the first; arXiv:2601.04241 proves "no rational root" for the second with Magma's Chabauty on a fixed genus-2 curve); the third, general one is untouched.

## 3. The single exclusion argument, and its limit

If one of the five factors has rank zero, its Mordell-Weil group is its torsion, which is constant over all faces tested (Z/4 x Z/2 for EF1, EF3, EF4; Z/8 x Z/2 for EF2; Z/2 x Z/2 for P+), and the only torsion x-coordinates that could be a square c^2 are ab, ad, bd; ad = p^4 - q^4 is never a square (Fermat), and ab, bd are never squares for p <= 200 [reproduced; the general statements for ab and bd reduce to two classical Fermat-type equations and were not re-derived]. So rank zero of one factor excludes the face from perfect cuboids, unconditionally. Rank zero is certified by 2-descent (PARI `ellrank`, milliseconds per curve) or, when the 2-Selmer group is larger, by L(E, 1) not equal to 0 (SageMath's `L_ratio`, or PARI's `ellL1` with the denominator bound; unconditional by modularity and Kolyvagin). Both routes run in the environment of this repo (`tools/setup-env.sh`).

The limit [proved, then measured]: because P+ always has rank at least 1, the linear Chabauty-Coleman condition rank J(X_s) <= 4 forces one of the other four factors to have rank zero, and rank zero of a single factor already makes X_s(Q) finite and computable. Linear Chabauty on X_s, and on each of its three hyperelliptic genus-3 quotients (Peschmann's C_A and H_{m,n} and a third one that appears in no paper), is therefore strictly weaker than the elementary rank-zero argument. The hard cases need quadratic Chabauty (not implemented for non-hyperelliptic genus 5 anywhere) or a covering collection with elliptic-curve Chabauty over quartic fields (Stoll's method for diagonal genus-5 curves, implemented only in Magma).

## 4. Numbers [reproduced]

All coprime opposite-parity (p, q) with p <= 200 (8,156 faces; no timeouts; 2-descent bounds only, hence unconditional):

| criterion | faces excluded |
|---|---|
| de Grey, Gibbs and Helm, Theorem 1 as printed (displayed curves) | 58.8 percent (p <= 250, `scratch/dgh-probe/`) |
| Theorem 1 with the derived curves, "both EF3 and EF4" | 58.9 percent |
| any one of the five factors has rank zero ("either") | 78.0 percent, flat between 75 and 80 percent in bands of 25 |
| sum of the five rank bounds at most 4 (linear Chabauty certified) | 33.5 percent, all inside the previous row |
| rank J(X_s) >= 5 certified by lower bounds (Chabauty impossible) | 39.1 percent |
| all five ranks exactly 1 ("genuinely hard") | 1.9 percent (155 faces; smallest (32, 7), the face of the face cuboid (975, 448, 264)) |
| 2-descent inconclusive | 27.4 percent |

Peschmann's grid (max(m, n) <= 100, 2,040 fibers): his 1,072 (52.5 percent) become 1,629 (79.9 percent) with the five factors; of his 968 uncovered fibers, 603 fall to a rank-zero factor, 172 of them to his own curve E_uV once the descent is run on the isogenous model EF2 (full rational 2-torsion, better for PARI), and his "hard fiber" (5, 2) falls to EF3 (rank 0 exactly; ad = 609 is not a square). His 122 fibers that disagree with 2-descent are exactly his L-value certificates.

Cost: one face, five curves, 2-descent: milliseconds at small p, about a second at p near 200. SageMath's exact L-ratio closes the ambiguous cases (checked on EF1 at (2, 1): conductor 21, L-ratio 1/8).

## 5. What the authors leave open

- de Grey, Gibbs and Helm, Section 10: nonexistence of 2-BPCs; that their parametric families of edge cuboids contain no perfect cuboid; a size lower bound as a function of the Pythagorean parameters; a uniform condition forcing rank zero; positive asymptotic density of the excluded ratios (no proof).
- Peschmann, second paper Section 5.2: quadratic Chabauty and Mordell-Weil sieving on the hard fibers; a Brauer-Manin obstruction; a modular or CM interpretation of the third factor; Goldfeld-type statistics. First paper: the genus-5 covering.
- Stoll and Testa: the transcendental Brauer group; curves of degree 8 and more; the rational points of the fibers are not discussed.
- Sharipov: the third cuboid conjecture.

## 6. Where computation and an AI assistant can enter, after one day of measurement

Ranked by our estimate of value against feasibility; the human decides.

1. Maximize the elementary exclusion and classify the rest. Run all five factors on the good models, add the L-value certificate where 2-descent is inconclusive, and split the residue into "rank J(X_s) >= 5 certified" (Chabauty provably useless) and "undecided". Everything needed is in PARI and SageMath; the output is a complete exclusion table for face ratios up to a chosen bound that beats both published figures (57 and 52.5 percent), together with the list of genuinely hard faces. The mathematical content is corrective and unifying (the misprint, "both" to "either", the model choice, the five-factor picture, the proof that P+ has positive rank, EI = EF); it is publishable as a short note or communicable to the authors.
2. Attack one genuinely hard face, for example (32, 7), with Stoll's covering-collection method: 30 two-torsion classes, elliptic curves over biquadratic fields, elliptic-curve Chabauty. PARI and SageMath cover the Selmer groups, local conditions and covering equations; Magma is required for elliptic-curve Chabauty and for saturation over the quartic field, and its free online calculator now sits behind an authentication wall. Without Magma this is an implementation project.
3. Positive density of excluded ratios: the measured rate is flat near 78 percent; a proof would go through root numbers and 2-Selmer statistics of five explicit families.
4. Complete the dictionary for all 28 fibrations (the internal-rectangle fiber already shows a different Jacobian structure, apparently unrecorded); cheap.
5. Transcendental Brauer group of S; Sharipov's third conjecture; unchanged assessments (specialist, respectively unclear feasibility).

Closed by measurement: linear Chabauty on the genus-5 fiber or on its genus-3 quotients. Not goals: exhaustive-search bounds; a proof of nonexistence; extending Peschmann's list by his own method.

## 7. Tooling

- PARI/GP 2.15 with elldata/seadata: 2-descent (`ellrank`), isogeny classes (`ellisomat`), torsion, point search; everything in `scratch/dgh-probe/` and most of the two reports.
- SageMath 9.5 (Debian package): exact L(E, 1)/Omega by modular symbols (unconditional rank-zero certificate), Coleman integration on hyperelliptic curves, Simon's 2-descent over number fields. No Chabauty driver of any kind; no elliptic-curve Chabauty.
- Magma: elliptic-curve Chabauty, saturation over number fields, the Mordell-Weil sieve. Not available here.

## 8. What we have not verified

Everything marked [unverified] above; the general non-squareness of ab and bd (checked to e <= 3000 only); the Paulsen-West and Colman dictionaries in full; the formula attributed to arXiv:2407.09825 (taken from a search summary); whether the de Grey, Gibbs and Helm computation used the displayed or the derived face-cuboid curves; Asiryan's proofs.
