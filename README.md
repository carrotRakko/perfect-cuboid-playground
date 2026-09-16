# perfect-cuboid-playground

A survey-and-probe repository on the perfect cuboid problem (integer edges, integer face diagonals, integer space diagonal; open since the 18th century). The goal is not a proof and not a record-size search. The goal is a map: where the frontier is as of late 2026, which gaps the authors themselves leave open, and where computation plus an AI research assistant can enter usefully. Companion in method to `ec-rank-playground` (the same human/AI working style applied to high-rank elliptic curves).

## What is in this repo

- `tools/setup-env.sh` : reproducible environment (Debian 12: PARI/GP 2.15 with elldata/seadata, eclib, ratpoints, SageMath 9.5) and download of the papers referred to below into `data/papers/` (git-ignored; the papers are not redistributed).
- `scratch/dgh-probe/` : reproduction of the aspect-ratio exclusion of de Grey, Gibbs and Helm (Geombinatorics 2024, arXiv:2401.06784, Theorem 1) with PARI's `ellrank` (2-descent only, hence unconditional), plus the check that led to the finding below.
- `scratch/peschmann-review/` : independent verification of the three 2026 preprints of R. Peschmann (arXiv:2604.09328, 2604.28072, 2605.00573), written by an AI reviewer seat from the papers and the author's published code, with every claim labelled verified / paper claims / could not verify / wrong.
- `scratch/unification/` : (planned) identification of all the elliptic curves used in the 2022-2026 literature as quotients of fibers of the 28 genus-5 fibrations of the cuboid surface (Stoll and Testa, arXiv:1009.0388 v2).
- `notes/landscape.md` : (to be written) the map itself: surface, fibrations, elliptic quotients, exclusion logic, numbers, open gaps, and where to enter.

## Findings so far (confidence labels in brackets)

4. [measured] The fifth factor F2: y^2 = x(x - a^2)(x - b^2) always carries the rational point (d^2, abd), which has infinite order (torsion order 4, 2-descent lower bound 1 on every pair tested). So the Jacobian of the genus-5 curve X_s has rank at least 1 for structural reasons, and the linear Chabauty condition rank(J) <= 4 amounts to rank EF1 + rank EF2 + rank EF3 + rank EF4 <= 3; in particular it never applies to a fiber on which all four of de Grey-Gibbs-Helm's curves have positive rank. See `scratch/unification/` for the counts.

1. [measured] de Grey, Gibbs and Helm's face-aspect-ratio exclusion reproduces: with the curves EF1-EF4 exactly as displayed in their Section 7.1, the fraction of coprime opposite-parity pairs (p, q), p <= 200, excluded by a rank-zero 2-descent bound is 58.8 percent, stable between 58 and 62 percent in bands of 50 (their figure: 57 percent for p <= 1000). One pair (four curves) costs 5 ms at p <= 30 and about 0.2 s at p near 150.
2. [measured, interpretation at high confidence] The displayed definitions of EF3 and EF4 (third root (p^2 - q^2 + 2pq)^2) do not agree with the derivation in the same paper's proof (Section 7.1.3, which yields x(x + a^2)(x + d^2) with d = p^2 + q^2). The known face cuboid (104, 153, 672), whose rational face (153, 104, 185) has Pythagorean parameters (13, 4), gives a point with x = 672^2 on the derived curve (rank 2) and no point on the displayed EF4 (672^2 + 257^2 is not a square). The two derived curves x(x + a^2)(x + d^2) and x(x + b^2)(x + d^2) have the same j-invariant but are quadratic twists of each other by -1, not isomorphic over Q (`scratch/dgh-probe/05-ef3-ef4-twist-f2.gp`; an earlier version of this note wrongly called them isomorphic). Since a perfect cuboid gives a non-torsion point on each of them, rank zero of either one already excludes the aspect ratio from perfect cuboids; the theorem's "both" is what is needed to exclude face cuboids themselves. With the derived curve the exclusion rate for p <= 100 is 69.4 percent instead of 59.3 percent. The analogous curves EI1-EI4 of Theorem 4 are consistent with their derivation (EI3 and EI4 likewise share a j-invariant). Which curves the authors' own computation used is unknown to us.
3. [measured] SageMath's modular-symbol computation of L(E, 1)/Omega closes the unconditional rank-zero certificate locally where 2-descent is inconclusive (checked on EF1 at (2, 1): conductor 21, L-ratio 1/8), reproducing the route used by Peschmann for the fibers where PARI's `ellrank` is ambiguous.

## Provenance

Human: experiment design, scope, review of judgements. AI: Claude (Claude Code) as the working agent and as reviewer seats. Scripts record their own inputs; numbers quoted above are reproducible from the files named in `scratch/`.
