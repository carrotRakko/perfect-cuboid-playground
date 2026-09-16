\\ Peschmann's "hard fiber" (m,n) = (5,2): a = 21, b = 20, d = 29. Which of the five factors has rank 0, and are its torsion points degenerate?
p = 5; q = 2; a = p^2-q^2; b = 2*p*q; d = p^2+q^2; print("a b d = ", [a,b,d]);
L = [["EF1", ellinit([0, a^2+b^2, 0, a^2*b^2, 0])], ["EF2", ellinit([0, a^4+b^4, 0, a^4*b^4, 0])], ["EF3", ellinit([0, a^2+d^2, 0, a^2*d^2, 0])], ["EF4", ellinit([0, b^2+d^2, 0, b^2*d^2, 0])], ["F2", ellinit([0, -(a^2+b^2), 0, a^2*b^2, 0])]];
{
for (i = 1, 5, my(nm = L[i][1], E = L[i][2], r = ellrank(E), T = elltors(E));
  print(nm, ": conductor ", ellglobalred(E)[1], " ellrank [lo,up] = ", r[1..2], " torsion ", T[1], " ", T[2]);
  if (r[2] == 0, my(pts = List()); for (k = 1, #T[3], my(P = T[3][k]); for (j = 1, T[1], listput(pts, ellmul(E, P, j))));
     my(xs = Set(apply(P -> if(#P==2, P[1], "oo"), Vec(pts)))); print("   torsion x-coordinates: ", xs, "  squares among them: ", select(x -> x != "oo" && issquare(x), xs)));
);
}
