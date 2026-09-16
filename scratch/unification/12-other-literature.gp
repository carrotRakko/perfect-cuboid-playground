\\ 12-other-literature.gp : relate the other curves in the literature to the five factors of J(X_s).
\\ (A) Leech / van Luijk Idea 3 : s*u(v^2-1) = v(u^2-1) with s = (a^2-b^2)/(2ab)  [a,b = Euclid pair]
\\ (B) dGGH congruent-number curve  y^2 = x^3 - n^2 x,  n = squarefree part of pq(p^2-q^2)
\\ (C) arXiv:2407.09825 family  y^2 = x(x-(2s)^2)(x+(s^2-1)^2),  s = q/p or p/q
\\ (D) dGGH EI1..EI4 versus the internal-rectangle genus-5 fibration
\\ (E) Colman / van Luijk (43): w^4+2Aw^3+2w^2-2Aw+1, w^4+(8/A)w^3+2w^2-(8/A)w+1 ; in sigma = w - 1/w
\\     these are sigma^2+2A sigma+4 and sigma^2+(8/A) sigma+4, plus sigma^2+4 for w rational.
default(parisize,"1G");
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
isom(E1,E2) = { if(E1.j != E2.j, return(0)); if(E1.j == 0 || E1.j == 1728, return(-1)); issquare(E1.c6*E2.c4/(E1.c4*E2.c6)); };
isog(E1,E2) = { my(L = ellisomat(E1,,1)[1]); for(i=1,#L, if(isom(ellinit(L[i]), E2), return(1))); 0; };
rel(n1,E1,n2,E2) = { my(r = if(isom(E1,E2), "ISOMORPHIC/Q", if(isog(E1,E2), "isogenous", ""))); if(r != "", printf("      %-26s %-30s : %s\n", n1, n2, r)); r != ""; };
{five(a,b,d) = [ellinit([0,a^2+b^2,0,a^2*b^2,0]), ellinit([0,a^4+b^4,0,a^4*b^4,0]), ellinit([0,a^2+d^2,0,a^2*d^2,0]), ellinit([0,b^2+d^2,0,b^2*d^2,0]), ellinit([0,-(a^2+b^2),0,a^2*b^2,0])];}
fnames = ["EF1","EF2","EF3","EF4","P+"];

print("############ (A) Leech / van Luijk Idea 3 ############");
{
foreach([[2,1],[3,2],[5,2],[4,1]], pq, my(p=pq[1],q=pq[2],a=p^2-q^2,b=2*p*q,d=p^2+q^2, s=a/b);
  my(L = ellinit(ellfromeqn(s*x*(y^2-1) - y*(x^2-1))), F = five(a,b,d));
  printf("  (p,q)=%-8s s=%-8s Leech N=%-10s j=%s\n", Str(pq), s, ellglobalred(L)[1], L.j);
  for(i=1,5, rel("Leech curve", L, fnames[i], F[i])));
}
print("");
print("############ (B) congruent-number curve of dGGH section 5.2 ############");
{
foreach([[2,1],[3,2],[5,2],[4,1],[8,5]], pq, my(p=pq[1],q=pq[2],a=p^2-q^2,b=2*p*q,d=p^2+q^2);
  my(n = core(p*q*(p^2-q^2)), C = ellinit([0,0,0,-n^2,0]), F = five(a,b,d));
  printf("  (p,q)=%-8s n=SFP(area)=%-8s CN curve N=%-10s rank=%s\n", Str(pq), n, ellglobalred(C)[1], ellrank(C)[1..2]);
  for(i=1,5, rel("CN curve", C, fnames[i], F[i])));
}
print("");
print("############ (C) arXiv:2407.09825 family y^2 = x(x-(2s)^2)(x+(s^2-1)^2) ############");
{
foreach([[2,1],[3,2],[5,2],[8,5]], pq, my(p=pq[1],q=pq[2],a=p^2-q^2,b=2*p*q,d=p^2+q^2, F=five(a,b,d));
  foreach([q/p, p/q], s,
    my(E = Eq(x*(x-(2*s)^2)*(x+(s^2-1)^2)));
    printf("  (p,q)=%-8s s=%-8s E N=%-10s j=%s\n", Str(pq), s, ellglobalred(E)[1], E.j);
    for(i=1,5, rel(Str("E_{1,s=",s,"}"), E, fnames[i], F[i]))));
}
print("");
print("############ (D) dGGH EI1..EI4 versus the internal-rectangle genus-5 fibration ############");
\\ internal rectangle (c = edge, d = face diagonal), c^2+d^2 = g^2, free parameter a (an edge),
\\ conditions: d^2-a^2, a^2+c^2, g^2-a^2 all squares.
{fiveI(c,d,g) = [Eq((d^2-x^2)*(x^2+c^2)), Eq((d^2-x^2)*(g^2-x^2)), Eq((x^2+c^2)*(g^2-x^2)), Eq((d^2-x)*(x+c^2)*(g^2-x)), Eq(x*(d^2-x)*(x+c^2)*(g^2-x))];}
inames = ["QI1 (b,e)","QI2 (b,f)","QI3 (e,f)","PI+ cubic","PI- quartic"];
{
foreach([[2,1],[3,2],[5,2]], pq, my(p=pq[1],q=pq[2],U=p^2-q^2,V=2*p*q,W=p^2+q^2);
  my(EI1 = ellinit(ellfromeqn(y^2 - x*(x-U^4)*(x+8*p^2*q^2*(p^4+q^4)))),
     EI2 = ellinit(ellfromeqn(y^2 - x*(x-16*p^4*q^4)*(x+W^4-16*p^4*q^4))),
     EI3 = ellinit([0,-2*(p^4+q^4),0,(p^4-q^4)^2,0]),
     EI4 = ellinit([0,-(W^2+4*p^2*q^2),0,4*p^2*q^2*W^2,0]));
  my(G  = fiveI(U,V,W));   \\ edge c = p^2-q^2, face diagonal d = 2pq
  my(G2 = fiveI(V,U,W));   \\ the swapped labelling: edge 2pq, face diagonal p^2-q^2
  printf("  (p,q)=%s  N(EI1)=%s N(EI2)=%s N(EI3)=%s N(EI4)=%s\n", Str(pq),
     ellglobalred(EI1)[1], ellglobalred(EI2)[1], ellglobalred(EI3)[1], ellglobalred(EI4)[1]);
  printf("    fibration with edge=p^2-q^2: N = %s\n", [ellglobalred(G[i])[1]|i<-[1..5]]);
  printf("    fibration with edge=2pq    : N = %s\n", [ellglobalred(G2[i])[1]|i<-[1..5]]);
  foreach([["EI1",EI1],["EI2",EI2],["EI3",EI3],["EI4",EI4]], t,
    for(i=1,5, rel(t[1], t[2], Str("edge=U: ",inames[i]), G[i]);
               rel(t[1], t[2], Str("edge=V: ",inames[i]), G2[i]))));
}
print("");
print("############ (E) Colman / van Luijk (43) ############");
\\ in sigma: (sigma^2+4) [w rational], (sigma^2+2A sigma+4), (sigma^2+(8/A) sigma+4)
{fiveC(A) = [Eq((x^2+4)*(x^2+2*A*x+4)), Eq((x^2+4)*(x^2+8/A*x+4)), Eq((x^2+2*A*x+4)*(x^2+8/A*x+4))];}
{
foreach([2, 3/2, 5/2, 3, 4/3], D, my(A = D + 1/D, C = fiveC(A));
  printf("  D=%-6s A=%-8s  three elliptic quotients: N = %s   j = %s\n", D, A,
     [ellglobalred(C[i])[1]|i<-[1..3]], [C[i].j|i<-[1..3]]);
);
print("  five factors of X_s for small faces, for comparison:");
foreach([[2,1],[3,2],[5,2],[4,1],[3,1],[5,4],[5,1],[7,2]], pq,
  my(p=pq[1],q=pq[2],a=p^2-q^2,b=2*p*q,d=p^2+q^2,F=five(a,b,d));
  if(gcd(p,q)!=1 || (p-q)%2==0, printf("  (p,q)=%-8s (not admissible)\n", Str(pq)),
  printf("  (p,q)=%-8s N = %s\n", Str(pq), [ellglobalred(F[i])[1]|i<-[1..5]])));
}
