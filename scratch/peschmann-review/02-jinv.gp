\\ 02-jinv.gp : compare the elliptic quotients of paper 1 (C_A, s=m/n), paper 2 (H_{m,n}), the reviewer's predicted curves, and de Grey-Gibbs-Helm EF1..EF4 with (p,q)=(m,n)
default(parisize, 128000000);
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));   \\ Jacobian of y^2 = pol(x)
info(name, E) = { my(N = ellglobalred(E)[1], T = elltors(E)[2]); printf("  %-12s j = %-40s  N = %-16s tors = %s\n", name, E.j, N, T); };
isom(E1,E2) = { if(E1.j != E2.j, return(0)); if(E1.j == 0 || E1.j == 1728, return(-1)); issquare(E1.c6*E2.c4/(E1.c4*E2.c6)); };
isog(E1, E2) = { my(L = ellisomat(E1,,1)[1]); for(i=1,#L, my(Ei = ellinit(L[i])); if(isom(Ei, E2), return(1))); 0; };
{
foreach([[2,1],[3,2],[5,2],[4,1]], mn,
  my(m = mn[1], n = mn[2], U2 = m^2-n^2, V2 = 2*m*n, W2 = m^2+n^2, s = m/n, c, A, curves = List(), names = List());
  print("================ (m,n) = ", mn, "   (paper-1 parameter s = m/n = ", s, ")");
  \\ paper 2 curves (fiber (m,n))
  listput(names, "E_PQ(p2)"); listput(curves, Eq((V2^2*x^2+(4*U2^2-2*V2^2)*x+V2^2)*(W2^2*x^2+2*(U2^2-V2^2)*x+W2^2)));
  listput(names, "E_uV(p2)"); listput(curves, Eq((V2^2*x^2+4*(U2^2-V2^2))*(W2^2*x^2-4*V2^2)));
  listput(names, "E_3(p2)");  listput(curves, Eq((V2^2*x^2+4*U2^2)*(W2^2*x^2+4*U2^2)));
  \\ paper 1 curves at s = m/n (so (U1,V1,W1) = (U2,V2,W2))
  c = (U2^2-V2^2)/W2^2; A = 2-4*c^2;
  listput(names, "E_A(p1)");   listput(curves, ellinit([0,A,0,-4,-4*A]));
  listput(names, "E'_A(p1)");  listput(curves, Eq(x^4-4*x^2+(A+2)));
  listput(names, "E''_A(p1)"); listput(curves, Eq(x^4+4*x^2+(A+2)));
  \\ reviewer's predicted curves (rho-line, conditions Rat: rho^2+4, Master: V^2 rho^2+4U^2, Hsum: W^2 rho^2 + 4U^2)
  listput(names, "E_qS=RatMas"); listput(curves, Eq((x^2+4)*(V2^2*x^2+4*U2^2)));
  listput(names, "E_Yq=MasHs");  listput(curves, Eq((W2^2*x^2+4*U2^2)*(V2^2*x^2+4*U2^2)));
  listput(names, "E_YS=RatHs");  listput(curves, Eq((x^2+4)*(W2^2*x^2+4*U2^2)));
  listput(names, "F1(cubicR)");  listput(curves, Eq((x+4)*(W2^2*x+4*U2^2)*(V2^2*x+4*U2^2)));
  listput(names, "F2(quartR)");  listput(curves, Eq(x*(x+4)*(W2^2*x+4*U2^2)*(V2^2*x+4*U2^2)));
  \\ de Grey-Gibbs-Helm with (p,q) = (m,n): a = U2, b = V2, d = W2
  listput(names, "EF1"); listput(curves, ellinit([0,(m^2+n^2)^2,0,4*m^2*n^2*(m^2-n^2)^2,0]));
  listput(names, "EF2"); listput(curves, ellinit([0,(m^2-n^2)^4+16*m^4*n^4,0,16*m^4*n^4*(m^2-n^2)^4,0]));
  listput(names, "EF3=x(x+a2)(x+d2)"); listput(curves, Eq(x*(x+U2^2)*(x+W2^2)));
  listput(names, "EF4=x(x+b2)(x+d2)"); listput(curves, Eq(x*(x+V2^2)*(x+W2^2)));
  listput(names, "EF3text=x(x+a2)(x+(a+b)2)"); listput(curves, Eq(x*(x+U2^2)*(x+(U2+V2)^2)));
  for(i=1,#curves, info(names[i], curves[i]));
  print("  --- isomorphism (=) / isogeny (~) relations among distinct-name curves:");
  for(i=1,#curves, for(j=i+1,#curves,
     my(E1 = curves[i], E2 = curves[j], r = "");
     if(isom(E1,E2), r = "ISOMORPHIC", if(isog(E1,E2), r = "isogenous (not isomorphic)"));
     if(r != "", printf("    %-14s %-3s %-28s : %s\n", names[i], "vs", names[j], r))));
);
}
