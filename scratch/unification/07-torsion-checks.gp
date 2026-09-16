\\ 07-torsion-checks.gp
\\ (i)  the point (d^2, abd) on P+ : y^2 = x(x-a^2)(x-b^2) has infinite order on every face p <= PMAX
\\ (ii) torsion structure of the five factors is constant
\\ (iii) a perfect cuboid on the face gives a point with x = c^2 > 0 on EF1, EF3, EF4; if the factor has
\\       rank 0 that x must be a torsion x-coordinate. The only positive torsion x-coordinates are
\\       ab (EF1), ad (EF3), bd (EF4). Test whether any of them is a perfect square.
default(parisize,"512M");
PMAX = eval(getenv("PMAX")); if(PMAX==0, PMAX=200);
{
my(bad1=0, bad2=0, sqab=List(), sqad=List(), sqbd=List(), tors=Map(), n=0);
for(p=2,PMAX, for(q=1,p-1,
  if(gcd(p,q)!=1 || (p-q)%2==0, next);
  n++;
  my(a=p^2-q^2, b=2*p*q, d=p^2+q^2);
  my(Pp = ellinit([0,-(a^2+b^2),0,a^2*b^2,0]), G=[d^2, a*b*d]);
  if(!ellisoncurve(Pp,G), bad1++);
  if(ellorder(Pp,G)!=0, bad2++);
  if(issquare(a*b), listput(sqab,[p,q]));
  if(issquare(a*d), listput(sqad,[p,q]));
  if(issquare(b*d), listput(sqbd,[p,q]));
  if(1,
    my(k = Str(elltors(ellinit([0,a^2+b^2,0,a^2*b^2,0]))[2], " ",
               elltors(ellinit([0,a^4+b^4,0,a^4*b^4,0]))[2], " ",
               elltors(ellinit([0,a^2+d^2,0,a^2*d^2,0]))[2], " ",
               elltors(ellinit([0,b^2+d^2,0,b^2*d^2,0]))[2], " ",
               elltors(Pp)[2]));
    mapput(tors, k, if(mapisdefined(tors,k), mapget(tors,k), 0) + 1));
));
print("faces tested (p <= ", PMAX, "): ", n);
print("(d^2,abd) not on P+            : ", bad1);
print("(d^2,abd) of finite order on P+: ", bad2, "   [0 means rk P+ >= 1 on every face]");
print("faces with a*b a perfect square : ", #sqab, "  ", Vec(sqab));
print("faces with a*d a perfect square : ", #sqad, "  ", Vec(sqad));
print("faces with b*d a perfect square : ", #sqbd, "  ", Vec(sqbd));
print("torsion [EF1 EF2 EF3 EF4 P+] multiset over the whole range:");
foreach(Vec(tors), k, print("   ", k, " : ", mapget(tors,k)));
}
