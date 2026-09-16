\\ 06-euv-check.gp : on fibres where EF2 = x(x+a^4)(x+b^4) has 2-descent upper bound 0 but which are
\\ absent from Peschmann's proven list, recompute Peschmann's own E_uV and E_3 and test the isogeny
\\ E_uV ~ EF2 = F1, E_3 ~ EF4.
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
isom(E1,E2) = { if(E1.j != E2.j, return(0)); if(E1.j == 0 || E1.j == 1728, return(-1)); issquare(E1.c6*E2.c4/(E1.c4*E2.c6)); };
isog(E1,E2) = { my(L = ellisomat(E1,,1)[1]); for(i=1,#L, if(isom(ellinit(L[i]), E2), return(1))); 0; };
{
foreach([[29,6],[31,26],[33,4],[33,32],[35,24],[37,30],[39,34],[24,1],[26,23],[5,2]], mn,
  my(m = mn[1], n = mn[2], U2 = m^2-n^2, V2 = 2*m*n, W2 = m^2+n^2);
  my(a = U2, b = V2, d = W2);
  my(EuV = Eq((V2^2*x^2+4*(U2^2-V2^2))*(W2^2*x^2-4*V2^2)));
  my(E3  = Eq((V2^2*x^2+4*U2^2)*(W2^2*x^2+4*U2^2)));
  my(EF2 = ellinit([0, a^4+b^4, 0, a^4*b^4, 0]));
  my(EF4 = ellinit([0, b^2+d^2, 0, b^2*d^2, 0]));
  printf("(m,n)=%-9s EuV: N=%-12s rank=%s tors=%s | EF2: N=%-12s rank=%s | isog(EuV,EF2)=%d || E3: N=%-10s rank=%s | EF4: N=%-10s rank=%s | isog(E3,EF4)=%d\n",
     Str(mn), ellglobalred(EuV)[1], ellrank(EuV)[1..2], elltors(EuV)[2], ellglobalred(EF2)[1], ellrank(EF2)[1..2], isog(EuV,EF2),
     ellglobalred(E3)[1], ellrank(E3)[1..2], ellglobalred(EF4)[1], ellrank(EF4)[1..2], isog(E3,EF4));
);
}
