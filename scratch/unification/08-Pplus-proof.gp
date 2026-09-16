\\ 08-Pplus-proof.gp : the five steps of the proof that P+ = EF1^(-1) : y^2 = x(x-a^2)(x-b^2)
\\ always has rank >= 1, with the explicit point G = (d^2, abd).
\\  (1) G is on the curve and x(G), x(G)-a^2, x(G)-b^2 are all squares  => G in 2 E(Q)
\\  (2) no rational 4-torsion: needs |a^2-b^2| square, which with a^2+b^2 = d^2 gives a^4-b^4 or
\\      b^4-a^4 a square, impossible (Fermat).  Checked numerically here.
\\  (3) ord(G) != 3, i.e. x(2G) != x(G): (d^4-a^2b^2)^2 = 4a^2b^2d^4 would force d^2 = ab(+-1+-sqrt2).
\\  (4) hence G is not torsion and rk P+ >= 1.
\\ Also: torsion of P+ and ellorder(G) over the whole range.
default(parisize,"512M");
PMAX = eval(getenv("PMAX")); if(PMAX==0, PMAX=200);
print("--- symbolic step (1): with a^2+b^2 = d^2,  x = d^2, x-a^2 = b^2, x-b^2 = a^2 ---");
print("    (immediate from a^2+b^2 = d^2; no computation needed)");
print("--- symbolic step (3): x(2G) - x(G) for y^2 = x^3 - d^2 x^2 + a^2 b^2 x at G = (d^2, abd) ---");
{
my(A=-d^2, B=a^2*b^2, x0=d^2, y0=a*b*d);
my(x2 = ((x0^2 - B)/(2*y0))^2);
print("    x(2G) = ", x2, "   x(2G) = x(G)  <=>  ", numerator(x2 - x0));
print("    so x(2G)=x(G) needs (d^4-a^2b^2)^2 = 4a^2b^2 d^4, i.e. d^4 -+ 2abd^2 - a^2b^2 = 0,");
print("    i.e. d^2 = ab(+-1+-sqrt(2)) : impossible for rational nonzero a,b,d.");
}
{
my(n=0, bad4=0, badorder=0, tors=Map(), nonsq=0);
for(p=2,PMAX, for(q=1,p-1,
  if(gcd(p,q)!=1 || (p-q)%2==0, next);
  n++;
  my(a=p^2-q^2, b=2*p*q, d=p^2+q^2, E=ellinit([0,-(a^2+b^2),0,a^2*b^2,0]), G=[d^2,a*b*d]);
  if(issquare(abs(a^2-b^2)), bad4++);
  if(ellorder(E,G)!=0, badorder++);
  my(k=Str(elltors(E)[2]));
  mapput(tors,k, if(mapisdefined(tors,k), mapget(tors,k),0)+1);
));
print("--- numeric over ", n, " faces with p <= ", PMAX, " ---");
print("    faces where |a^2-b^2| is a square (would allow 4-torsion): ", bad4);
print("    faces where G has finite order                          : ", badorder);
print("    torsion structures of P+ seen                           : ");
foreach(Vec(tors), k, print("       ", k, " on ", mapget(tors,k), " faces"));
}
