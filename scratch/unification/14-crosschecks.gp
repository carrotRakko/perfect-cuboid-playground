\\ 14-crosschecks.gp
\\ (i) is Colman's third quotient the congruent-number curve y^2 = x^3 - n^2 x, n = SFP(pq(p^2-q^2)) ?
\\ (ii) is the internal-rectangle fibration's QI1/QI2 factor equal to a factor of the FACE fibration
\\      for the same (p,q)?  (both have conductor 240 at (2,1))
default(parisize,"1G");
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
isom(E1,E2) = { if(E1.j != E2.j, return(0)); my(t = E1.c6*E2.c4/(E1.c4*E2.c6)); if(E1.j==0 || E1.j==1728, my(u4 = E2.c4/E1.c4, u6 = E2.c6/E1.c6); return(if(E1.j==1728, issquare(u4) && issquare(sqrtint(numerator(u4))), 0))); issquare(t); };
sameiso(E1,E2) = { my(M1 = ellminimalmodel(E1), M2 = ellminimalmodel(E2)); M1[1..5] == M2[1..5]; };
isog(E1,E2) = { my(L = ellisomat(E1,,1)[1]); for(i=1,#L, if(sameiso(ellinit(L[i]), E2), return(1))); 0; };
print("=== (i) Colman quotient 3 versus the congruent-number curve ===");
{
foreach([[2,1],[3,2],[5,2],[4,1],[5,4],[8,5]], pq, my(p=pq[1],q=pq[2],a=p^2-q^2,b=2*p*q);
  my(D=b/a, A=D+1/D, C3 = Eq((x^2+2*A*x+4)*(x^2+8/A*x+4)), n = core(p*q*(p^2-q^2)), CN = ellinit([0,0,0,-n^2,0]));
  printf("  (p,q)=%-8s n=%-8s N(C3)=%-10s N(CN)=%-10s  minimal models equal? %d   isogenous? %d\n",
    Str(pq), n, ellglobalred(C3)[1], ellglobalred(CN)[1], sameiso(C3,CN), isog(C3,CN)));
}
print("");
print("=== (ii) internal-rectangle fibration factors versus the face fibration factors, same (p,q) ===");
{fiveI(c,d,g) = [Eq((d^2-x^2)*(x^2+c^2)), Eq((d^2-x^2)*(g^2-x^2)), Eq((x^2+c^2)*(g^2-x^2)), Eq((d^2-x)*(x+c^2)*(g^2-x)), Eq(x*(d^2-x)*(x+c^2)*(g^2-x))];}
{five(a,b,d) = [ellinit([0,a^2+b^2,0,a^2*b^2,0]), ellinit([0,a^4+b^4,0,a^4*b^4,0]), ellinit([0,a^2+d^2,0,a^2*d^2,0]), ellinit([0,b^2+d^2,0,b^2*d^2,0]), ellinit([0,-(a^2+b^2),0,a^2*b^2,0])];}
fnames = ["EF1","EF2","EF3","EF4","P+"];
inames = ["QI1","QI2","QI3","PI+","PI-"];
{
foreach([[2,1],[3,2],[5,2]], pq, my(p=pq[1],q=pq[2],U=p^2-q^2,V=2*p*q,W=p^2+q^2);
  my(F = five(U,V,W), GU = fiveI(U,V,W), GV = fiveI(V,U,W));
  printf("  (p,q)=%s\n", Str(pq));
  for(i=1,5, for(j=1,5,
    if(isog(GU[i],F[j]), printf("     internal(edge=p^2-q^2) %s ~ face %s\n", inames[i], fnames[j]));
    if(isog(GV[i],F[j]), printf("     internal(edge=2pq)     %s ~ face %s\n", inames[i], fnames[j]))));
);
}
