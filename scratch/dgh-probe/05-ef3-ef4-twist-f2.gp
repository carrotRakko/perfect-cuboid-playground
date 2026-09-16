\\ (1) EF3 = x(x+a^2)(x+d^2) vs EF4 = x(x+b^2)(x+d^2): same j; the quadratic twist D relating them is
\\     D = c6(E4) c4(E3) / (c6(E3) c4(E4)) modulo squares (D square <=> isomorphic over Q).
\\ (2) F2 = x(x-a^2)(x-b^2): (d^2, abd) with d^2 = a^2+b^2 lies on it; torsion or not?
{
forvec(v = [[2,13],[1,12]],
  my(p = v[1], q = v[2]); if (q >= p || gcd(p,q) != 1 || (p-q)%2 == 0, next);
  my(a = p^2-q^2, b = 2*p*q, d = p^2+q^2);
  my(E3 = ellinit([0, a^2+d^2, 0, a^2*d^2, 0]), E4 = ellinit([0, b^2+d^2, 0, b^2*d^2, 0]));
  my(D = core(numerator(E4.c6*E3.c4/(E3.c6*E4.c4)) * denominator(E4.c6*E3.c4/(E3.c6*E4.c4))));
  my(F2 = ellinit([0, -(a^2+b^2), 0, a^2*b^2, 0]), P = [d^2, a*b*d]);
  my(on = ellisoncurve(F2, P), ord = if (on, ellorder(F2, P), -1), tors = elltors(F2)[1]);
  my(r = ellrank(F2));
  print("(",p,",",q,") j(EF3)==j(EF4): ", E3.j == E4.j, "  twist D=", D, if(D==1," (isomorphic over Q)"," (NOT isomorphic: quadratic twist)"), " | F2: (d^2,abd) on=", on, " order=", ord, " tors=", tors, " ellrank=", r[1..2]);
);
}
