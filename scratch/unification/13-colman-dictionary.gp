\\ 13-colman-dictionary.gp : test whether Colman's parameter D (van Luijk (43), conic AD = D^2+1)
\\ is the face aspect ratio 2pq : (p^2-q^2), by comparing conductors/j with the five factors of X_s.
default(parisize,"1G");
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
isom(E1,E2) = { if(E1.j != E2.j, return(0)); if(E1.j == 0 || E1.j == 1728, return(-1)); issquare(E1.c6*E2.c4/(E1.c4*E2.c6)); };
isog(E1,E2) = { my(L = ellisomat(E1,,1)[1]); for(i=1,#L, if(isom(ellinit(L[i]), E2), return(1))); 0; };
{five(a,b,d) = [ellinit([0,a^2+b^2,0,a^2*b^2,0]), ellinit([0,a^4+b^4,0,a^4*b^4,0]), ellinit([0,a^2+d^2,0,a^2*d^2,0]), ellinit([0,b^2+d^2,0,b^2*d^2,0]), ellinit([0,-(a^2+b^2),0,a^2*b^2,0])];}
fnames = ["EF1","EF2","EF3","EF4","P+"];
{
foreach([[2,1],[3,2],[5,2],[4,1],[5,4]], pq, my(p=pq[1],q=pq[2],a=p^2-q^2,b=2*p*q,d=p^2+q^2);
  my(D = b/a, A = D + 1/D, F = five(a,b,d));
  my(C = [Eq((x^2+4)*(x^2+2*A*x+4)), Eq((x^2+4)*(x^2+8/A*x+4)), Eq((x^2+2*A*x+4)*(x^2+8/A*x+4))]);
  printf("(p,q)=%-8s D=b/a=%-8s A=%-10s\n", Str(pq), D, A);
  printf("   X_s factors      N = %s\n", [ellglobalred(F[i])[1]|i<-[1..5]]);
  printf("   Colman quotients N = %s   j = %s\n", [ellglobalred(C[i])[1]|i<-[1..3]], [C[i].j|i<-[1..3]]);
  for(i=1,3, for(j=1,5,
    if(isom(C[i],F[j]), printf("      Colman-%d == %s  (ISOMORPHIC/Q)\n", i, fnames[j]),
       if(isog(C[i],F[j]), printf("      Colman-%d ~ %s  (isogenous)\n", i, fnames[j])))));
  \\ conductor of the genus-2 part
  my(g2 = (x^2+4)*(x^2+2*A*x+4)*(x^2+8/A*x+4));
  my(den = denominator(content(g2)), G = subst(numerator(g2*den^2), x, x));
  printf("   genus-2 part: disc-based reduction ... (see genus2red below)\n");
);
}
