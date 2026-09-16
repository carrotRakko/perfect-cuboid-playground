\\ Exclusion rate with the face-cuboid curve read from the proof text: x(x+a^2)(x+d^2) (isomorphic to x(x+b^2)(x+d^2)).
default(parisize, "512M");
PMAX = eval(getenv("PMAX")); if (PMAX == 0, PMAX = 100);
ub(E) = my(v = ellrank(E)); v[2];
{
for (p = 2, PMAX, for (q = 1, p - 1,
  if (gcd(p, q) != 1 || (p - q) % 2 == 0, next);
  my(U = p^2 - q^2, V = 2*p*q, W = p^2 + q^2, S = U + V);
  my(R1 = ub(ellinit([0, W^2, 0, V^2*U^2, 0])), R2 = ub(ellinit([0, U^4 + V^4, 0, V^4*U^4, 0])));
  my(R3t = ub(ellinit([0, U^2 + W^2, 0, U^2*W^2, 0])));
  my(R3d = ub(ellinit([0, U^2 + S^2, 0, U^2*S^2, 0])), R4d = ub(ellinit([0, V^2 + S^2, 0, V^2*S^2, 0])));
  print(p, " ", q, " ", R1, " ", R2, " ", R3t, " ", R3d, " ", R4d, " ", (R1==0)||(R2==0)||(R3t==0), " ", (R1==0)||(R2==0)||(R3d==0&&R4d==0));
));
}
