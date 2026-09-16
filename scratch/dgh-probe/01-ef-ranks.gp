\\ de Grey-Gibbs-Helm (2024) Theorem 1: face aspect ratio (p^2-q^2):2pq is excluded from a perfect cuboid
\\ if EF1 or EF2 has rank 0, or if both EF3 and EF4 have rank 0.  Curves as quoted from the paper:
\\   EF1: y^2 = x^3 + (p^2+q^2)^2 x^2 + 4 p^2 q^2 (p^2-q^2)^2 x
\\   EF2: y^2 = x^3 + ((p^2-q^2)^4 + 16 p^4 q^4) x^2 + 16 p^4 q^4 (p^2-q^2)^4 x
\\   EF3: y^2 = x (x + (p^2-q^2)^2) (x + (p^2-q^2+2pq)^2)
\\   EF4: y^2 = x (x + 4 p^2 q^2) (x + (p^2-q^2+2pq)^2)
\\ Output: p q R1 R2 R3 R4 excluded(0/1) seconds   where Ri = unconditional upper bound for the rank from ellrank (2-descent)
default(parisize, "512M");
PMAX = eval(getenv("PMAX"));
if (PMAX == 0, PMAX = 30);
ub(E) = my(v = ellrank(E)); v[2];
{
for (p = 2, PMAX,
  for (q = 1, p - 1,
    if (gcd(p, q) != 1 || (p - q) % 2 == 0, next);
    my(U = p^2 - q^2, V = 2*p*q, W = p^2 + q^2, S = U + V, t0 = getabstime());
    my(E1 = ellinit([0, W^2, 0, V^2*U^2, 0]));
    my(E2 = ellinit([0, U^4 + V^4, 0, V^4*U^4, 0]));
    my(E3 = ellinit([0, U^2 + S^2, 0, U^2*S^2, 0]));
    my(E4 = ellinit([0, V^2 + S^2, 0, V^2*S^2, 0]));
    my(R1 = ub(E1), R2 = ub(E2), R3 = ub(E3), R4 = ub(E4));
    my(ex = (R1 == 0) || (R2 == 0) || (R3 == 0 && R4 == 0));
    print(p, " ", q, " ", R1, " ", R2, " ", R3, " ", R4, " ", ex, " ", (getabstime() - t0) / 1000.0);
  );
);
}
