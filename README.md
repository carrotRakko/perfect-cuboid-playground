# perfect-cuboid-playground

A survey-and-probe repository on the perfect cuboid problem (integer edges, integer face diagonals, integer space diagonal; open since the 18th century). The goal is not a proof and not a record-size search. The goal is a map: where the frontier is as of late 2026, which gaps the authors themselves leave open, what could be verified or refuted in one working day, and where computation plus an AI research assistant can enter usefully. Companion in method to `ec-rank-playground` (the same human/AI working style applied to high-rank elliptic curves).

## What is in this repo

- `notes/landscape.md` : the map. Surface, 28 fibrations, the face-fixed genus-5 fiber and its five elliptic factors, the single exclusion argument and its limit, numbers, open gaps, ranked entry points, tooling.
- `tools/setup-env.sh` : reproducible environment (Debian 12: PARI/GP 2.15 with elldata/seadata, eclib, ratpoints, SageMath 9.5) and download of the papers into `data/papers/` (git-ignored; not redistributed).
- `scratch/dgh-probe/` : reproduction of the aspect-ratio exclusion of de Grey, Gibbs and Helm (Geombinatorics 2024, arXiv:2401.06784, Theorem 1) with PARI's `ellrank`, and the checks that led to findings 2 and 4 below.
- `scratch/peschmann-review/` : independent verification of the three 2026 preprints of R. Peschmann (arXiv:2604.09328, 2604.28072, 2605.00573), written by an AI reviewer seat from the papers and the author's released code and data; every claim labelled verified / paper claims / could not verify / wrong; 30-row verdict table.
- `scratch/unification/` : the five elliptic factors of the face-fixed fiber, the unified table of every curve in the literature, rank-bound calibration over all 8,156 faces with p <= 200, the classification of Peschmann's uncovered fibers, the resolution of the EF3/EF4 discrepancy, and a feasibility assessment of Chabauty methods; written by a second AI reviewer seat.

Output files (`*.out`) are git-ignored because they are reproducible from the scripts; the reports quote the numbers.

## Findings (confidence labels in brackets)

1. [reproduced] The face-aspect-ratio exclusion of de Grey, Gibbs and Helm reproduces: with their curves as printed, 58.8 percent of coprime opposite-parity (p, q) with p <= 250 are excluded by an unconditional rank-zero 2-descent bound (their figure: 57 percent for p <= 1000).
2. [reproduced] The displayed definitions of their EF3 and EF4 are a misprint: the proof derives x(x + a^2)(x + d^2) and x(x + b^2)(x + d^2) with d = p^2 + q^2, and all 44 face cuboids with third edge at most 3000 lie on the derived curves and none on the displayed ones; the displayed curves are unrelated to the problem (no shared j-invariant with any Jacobian factor). For p <= 100 the misprint makes Theorem 1 as printed assert 44 exclusions that no curve attached to the problem supports.
3. [proved] In Theorem 1, "both EF3 and EF4 have rank zero" can be replaced by "either": a perfect cuboid gives a non-torsion point on each. This raises the exclusion rate to 78.0 percent for p <= 200. Their EI3 and EI4 (Theorem 4) are the same curves as EF4 and EF3 after a translation.
4. [reproduced, partly proved] The Jacobian of the face-fixed genus-5 fiber is isogenous to EF1 x EF1^(-1) x EF2 x EF4 x EF4^(-1) (quadratic twists by -1). Every elliptic curve in Peschmann's three papers is one of these five up to isogeny, and none of the three cites de Grey, Gibbs and Helm. The factor P+ = EF1^(-1) always has positive rank (short proof from the degenerate point c = 0), which is the curve-level form of de Grey, Gibbs and Helm's Theorem 2.
5. [proved, then measured] Because P+ has positive rank, linear Chabauty on the genus-5 fiber (rank of the Jacobian at most 4) forces one of the other factors to have rank zero, and that alone already finishes the fiber. Linear Chabauty, on the fiber or on its three genus-3 hyperelliptic quotients, is strictly weaker than the elementary rank-zero argument: certified on 33.5 percent of faces with p <= 200, all inside the 78.0 percent.
6. [reproduced] Peschmann's main theorem (1,072 fibers with max(m, n) <= 100 excluded unconditionally) is correct and reproduces in PARI alone; his torsion condition is automatic. Of his 968 uncovered fibers, 603 are excluded by a rank-zero factor, 172 of them by his own curve once the descent is run on the better model EF2, and his "hard fiber" (5, 2) is excluded by EF3. His first paper's Theorem 6.2(a) has a broken proof; his third paper's blocker phenomenon reproduces on all 151,575 released records but its base conjectures restate the problem.
7. [reproduced] Genuinely hard faces, where 2-descent proves all five ranks equal to 1, are 1.9 percent of faces with p <= 200 (smallest: (32, 7)); on 39.1 percent the Jacobian rank is proved to be at least 5, so no linear Chabauty method can apply there.

## Provenance

Human: experiment design, scope, review of judgements. AI: Claude (Claude Code) as the working agent and as two reviewer seats. Scripts record their own inputs; numbers quoted above are reproducible from the files named in `scratch/`.
