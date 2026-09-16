\\ 01-five-factors-id.gp
\\ The genus-5 curve X_s for a face with Euclid pair (p,q):  a = p^2-q^2, b = 2pq, d = p^2+q^2.
\\ In the "third edge" coordinate c (x = c^2) the three conditions are
\\     Rat   : c^2 + a^2 = square   (face diagonal a,c)
\\     Master: c^2 + b^2 = square   (face diagonal b,c)
\\     Hsum  : c^2 + d^2 = square   (space diagonal)
\\ so X_s = { y1^2 = c^2+a^2 w^2, y2^2 = c^2+b^2 w^2, y3^2 = c^2+d^2 w^2 } in P^4: 3 diagonal quadrics.
\\ (Z/2)^3-cover of the c-line, 6 branch points, genus 5 by Riemann-Hurwitz.
\\ Seven index-2 subcovers: 3 conics (genus 0), 3 elliptic, 1 genus 2 = F1' x F2'.
\\ This script builds all of them, the prior seat's rho-coordinate versions, dGGH EF1..EF4
\\ (both the displayed and the proof-text reading) and the trilogy curves, and prints
\\ j, conductor, torsion + all isomorphism/isogeny relations.
default(parisize, "1G");
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
info(name, E) = { my(N = ellglobalred(E)[1], T = elltors(E)[2], r = ellrank(E)); printf("  %-26s j = %-34s N = %-14s tors = %-8s rank in [%d,%d]\n", name, E.j, N, T, r[1], r[2]); };
isom(E1,E2) = { if(E1.j != E2.j, return(0)); if(E1.j == 0 || E1.j == 1728, return(-1)); issquare(E1.c6*E2.c4/(E1.c4*E2.c6)); };
isog(E1, E2) = { my(L = ellisomat(E1,,1)[1]); for(i=1,#L, my(Ei = ellinit(L[i])); if(isom(Ei, E2), return(1))); 0; };
{
foreach([[2,1],[3,2],[5,2],[8,5],[13,4]], pq,
  my(p = pq[1], q = pq[2], a = p^2-q^2, b = 2*p*q, d = p^2+q^2, s = a+b, m = p, n = q);
  my(U2 = m^2-n^2, V2 = 2*m*n, W2 = m^2+n^2);
  print("================ (p,q) = ", pq, "   (a,b,d) = ", [a,b,d]);
  my(curves = List(), names = List());
  \\ --- the seven subcovers of X_s in the c-coordinate (x = c) ---
  listput(names,"Q1: Rat x Master");  listput(curves, Eq((x^2+a^2)*(x^2+b^2)));
  listput(names,"Q2: Rat x Hsum");    listput(curves, Eq((x^2+a^2)*(x^2+d^2)));
  listput(names,"Q3: Master x Hsum"); listput(curves, Eq((x^2+b^2)*(x^2+d^2)));
  \\ genus 2: z^2=(c^2+a^2)(c^2+b^2)(c^2+d^2) splits under c -> -c into (X = c^2):
  listput(names,"G2even: (X+a2)(X+b2)(X+d2)"); listput(curves, Eq((x+a^2)*(x+b^2)*(x+d^2)));
  listput(names,"G2odd: X(X+a2)(X+b2)(X+d2)"); listput(curves, Eq(x*(x+a^2)*(x+b^2)*(x+d^2)));
  \\ --- the prior seat's rho-coordinate factors (rho = 2a/c) ---
  listput(names,"E_qS(rho)=RatxMaster"); listput(curves, Eq((x^2+4)*(V2^2*x^2+4*U2^2)));
  listput(names,"E_YS(rho)=RatxHsum");   listput(curves, Eq((x^2+4)*(W2^2*x^2+4*U2^2)));
  listput(names,"E_Yq(rho)=MasterxHsum");listput(curves, Eq((W2^2*x^2+4*U2^2)*(V2^2*x^2+4*U2^2)));
  listput(names,"F1(rho cubic)");        listput(curves, Eq((x+4)*(W2^2*x+4*U2^2)*(V2^2*x+4*U2^2)));
  listput(names,"F2(rho quartic)");      listput(curves, Eq(x*(x+4)*(W2^2*x+4*U2^2)*(V2^2*x+4*U2^2)));
  \\ --- dGGH ---
  listput(names,"EF1 = x(x+a2)(x+b2)");  listput(curves, ellinit([0,a^2+b^2,0,a^2*b^2,0]));
  listput(names,"EF2 = x(x+a4)(x+b4)");  listput(curves, ellinit([0,a^4+b^4,0,a^4*b^4,0]));
  listput(names,"EF3txt = x(x+a2)(x+d2)");listput(curves, ellinit([0,a^2+d^2,0,a^2*d^2,0]));
  listput(names,"EF4txt = x(x+b2)(x+d2)");listput(curves, ellinit([0,b^2+d^2,0,b^2*d^2,0]));
  listput(names,"EF3disp = x(x+a2)(x+s2)");listput(curves, ellinit([0,a^2+s^2,0,a^2*s^2,0]));
  listput(names,"EF4disp = x(x+b2)(x+s2)");listput(curves, ellinit([0,b^2+s^2,0,b^2*s^2,0]));
  listput(names,"EF1twist-1 = x(x-a2)(x-b2)"); listput(curves, ellinit([0,-(a^2+b^2),0,a^2*b^2,0]));
  \\ --- trilogy curves ---
  my(c0 = (U2^2-V2^2)/W2^2, A = 2-4*c0^2);
  listput(names,"E_A(p1)");    listput(curves, ellinit([0,A,0,-4,-4*A]));
  listput(names,"E'_A(p1)");   listput(curves, Eq(x^4-4*x^2+(A+2)));
  listput(names,"E''_A(p1)");  listput(curves, Eq(x^4+4*x^2+(A+2)));
  listput(names,"E_PQ(p2)");   listput(curves, Eq((V2^2*x^2+(4*U2^2-2*V2^2)*x+V2^2)*(W2^2*x^2+2*(U2^2-V2^2)*x+W2^2)));
  listput(names,"E_uV(p2)");   listput(curves, Eq((V2^2*x^2+4*(U2^2-V2^2))*(W2^2*x^2-4*V2^2)));
  listput(names,"E_3(p2)");    listput(curves, Eq((V2^2*x^2+4*U2^2)*(W2^2*x^2+4*U2^2)));
  listput(names,"E_mn(p3)=EF1");listput(curves, ellinit([0,(m^2+n^2)^2,0,4*m^2*n^2*(m^2-n^2)^2,0]));
  for(i=1,#curves, info(names[i], curves[i]));
  print("  --- relations ---");
  for(i=1,#curves, for(j=i+1,#curves,
     my(E1 = curves[i], E2 = curves[j], r = "");
     if(isom(E1,E2), r = "ISOMORPHIC/Q", if(isog(E1,E2), r = "isogenous (not isom)"));
     if(r != "", printf("    %-28s %-30s : %s\n", names[i], names[j], r))));
);
}
