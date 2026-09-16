\\ 04-CA-points.gp : search for non-degenerate rational points on C_A : w^2 = lam^8 + A lam^4 + 1 for s = a/b, 1<=b<a<=20 (all parities), height bound 2000 on lam.
\\ Also: for each point found, test whether f1 and f2 are separately squares (that would be a perfect cuboid).
default(parisize, 256000000);
{
my(total = 0, found = List());
for(a = 2, 20, for(b = 1, a-1, if(gcd(a,b) != 1, next);
  my(U1 = a^2-b^2, V1 = 2*a*b, W1 = a^2+b^2, C = U1^2-V1^2, pol, pts);
  pol = W1^4*x^8 + (2*W1^4 - 4*C^2)*x^4 + W1^4;   \\ = W1^4 (lam^8 + A lam^4 + 1)
  pts = hyperellratpoints(pol, 2000);
  for(i = 1, #pts, my(l = pts[i][1]); if(l == 0 || l == 1 || l == -1, next);
     my(f1 = W1^2*(l^2-1)^2 + 4*U1^2*l^2, f2 = W1^2*(l^2-1)^2 + 4*V1^2*l^2);
     listput(found, [a, b, l, pts[i][2], issquare(f1), issquare(f2), core(numerator(f1)*denominator(f1)), core(numerator(f2)*denominator(f2))]);
  );
  total++;
));
printf("s-values tested: %d ; non-degenerate C_A points found (a,b,lambda,w,f1 square?,f2 square?,sqf(f1),sqf(f2)):\n", total);
for(i = 1, #found, print("  ", found[i]));
if(#found == 0, print("  none"));
}
