\\ de Grey-Gibbs-Helm: the displayed definitions of EF3/EF4 use (p^2-q^2+2pq)^2 = (a+b)^2 as the third root,
\\ but the proof text (7.1.3) derives x(x+a^2)(x+d^2) with d = p^2+q^2.  Compare both readings at small (p,q).
ub(E) = my(v = ellrank(E)); v[2];
{
forvec(v = [[2,12],[1,11]],
  my(p = v[1], q = v[2]);
  if (q >= p || gcd(p,q) != 1 || (p-q) % 2 == 0, next);
  my(a = p^2-q^2, b = 2*p*q, d = p^2+q^2, s = a+b);
  my(E3def = ellinit([0, a^2+s^2, 0, a^2*s^2, 0]), E4def = ellinit([0, b^2+s^2, 0, b^2*s^2, 0]));
  my(E3txt = ellinit([0, a^2+d^2, 0, a^2*d^2, 0]), E4txt = ellinit([0, b^2+d^2, 0, b^2*d^2, 0]));
  print(p, " ", q, "  def(EF3,EF4)=[", ub(E3def), ",", ub(E4def), "] j=", E3def.j, "|", E4def.j,
        "   text(EF3,EF4)=[", ub(E3txt), ",", ub(E4txt), "] j=", E3txt.j, "|", E4txt.j);
);
}
