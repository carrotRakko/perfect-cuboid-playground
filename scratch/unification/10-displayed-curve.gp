\\ 10-displayed-curve.gp : is the DISPLAYED dGGH curve EF3d = x(x+a^2)(x+(a+b)^2) (resp.
\\ EF4d = x(x+b^2)(x+(a+b)^2)) related to any of the five factors of J(X_s)?
\\ The five factors are EF1, EF2, EF3 = x(x+a^2)(x+d^2), EF4 = x(x+b^2)(x+d^2), P+ = x(x-a^2)(x-b^2);
\\ the three genus-3 quotients of X_s have Jacobians Qi x P+ x P-, P- = EF2, so the same five curves
\\ exhaust everything that occurs in J(X_s) or in any genus-3 quotient.
\\ Also: the displayed curves are the EF3/EF4 of the *edge* case?  Check against dGGH EI1..EI4 too.
default(parisize,"512M");
isom(E1,E2) = { if(E1.j != E2.j, return(0)); if(E1.j == 0 || E1.j == 1728, return(-1)); issquare(E1.c6*E2.c4/(E1.c4*E2.c6)); };
isog(E1,E2) = { my(L = ellisomat(E1,,1)[1]); for(i=1,#L, if(isom(ellinit(L[i]), E2), return(1))); 0; };
{
my(nrel = 0, ntest = 0, jeq = 0);
for(p = 2, 24, for(q = 1, p-1,
  if(gcd(p,q)!=1 || (p-q)%2==0, next);
  my(a=p^2-q^2, b=2*p*q, d=p^2+q^2, s=a+b);
  my(F = [ellinit([0,a^2+b^2,0,a^2*b^2,0]), ellinit([0,a^4+b^4,0,a^4*b^4,0]),
           ellinit([0,a^2+d^2,0,a^2*d^2,0]), ellinit([0,b^2+d^2,0,b^2*d^2,0]),
           ellinit([0,-(a^2+b^2),0,a^2*b^2,0])]);
  my(names = ["EF1","EF2","EF3","EF4","P+"]);
  my(D  = [ellinit([0,a^2+s^2,0,a^2*s^2,0]), ellinit([0,b^2+s^2,0,b^2*s^2,0])]);
  my(dn = ["EF3disp","EF4disp"]);
  for(i=1,2, for(j=1,5, ntest++;
    if(D[i].j == F[j].j, jeq++; print("  j-equal: (",p,",",q,") ",dn[i]," ",names[j]));
    if(isom(D[i],F[j]) || isog(D[i],F[j]), nrel++;
       print("  RELATED: (",p,",",q,") ",dn[i]," ~ ",names[j]))));
  \\ also compare the two displayed curves with each other
  if(isog(D[1],D[2]), print("  (",p,",",q,") EF3disp ~ EF4disp"));
));
print("pairs tested: ", ntest, "   isogeny/isomorphism relations found: ", nrel, "   j-invariant coincidences: ", jeq);
}
print("");
print("--- conductors at a few fibres, displayed vs the five factors ---");
{
foreach([[2,1],[3,2],[5,2],[8,5],[13,4]], pq,
  my(p=pq[1],q=pq[2],a=p^2-q^2,b=2*p*q,d=p^2+q^2,s=a+b);
  printf("(%d,%d): N(EF1)=%-10s N(EF2)=%-14s N(EF3)=%-10s N(EF4)=%-10s N(P+)=%-10s || N(EF3disp)=%-12s N(EF4disp)=%s\n",
    p,q, ellglobalred(ellinit([0,a^2+b^2,0,a^2*b^2,0]))[1], ellglobalred(ellinit([0,a^4+b^4,0,a^4*b^4,0]))[1],
    ellglobalred(ellinit([0,a^2+d^2,0,a^2*d^2,0]))[1], ellglobalred(ellinit([0,b^2+d^2,0,b^2*d^2,0]))[1],
    ellglobalred(ellinit([0,-(a^2+b^2),0,a^2*b^2,0]))[1],
    ellglobalred(ellinit([0,a^2+s^2,0,a^2*s^2,0]))[1], ellglobalred(ellinit([0,b^2+s^2,0,b^2*s^2,0]))[1]);
);
}
print("");
print("--- what IS the displayed curve?  x(x+a^2)(x+(a+b)^2) is the 'EF3/EF4 shape' with d replaced by a+b;");
print("--- (a+b)^2 = d^2 + 2ab, so it is the face-cuboid curve of a rectangle with sides a,b and *diagonal a+b*, which is not a rectangle at all.");
