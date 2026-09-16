default(parisize, 256000000);
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
isog(E1,E2) = { my(L = ellisomat(E1,,1)[1]); for(i=1,#L, my(Ei = ellinit(L[i])); if(Ei.j == E2.j && issquare(Ei.c6*E2.c4/(Ei.c4*E2.c6)), return(1))); 0; };
isom(E1,E2) = E1.j == E2.j && issquare(E1.c6*E2.c4/(E1.c4*E2.c6));
\\ also: is paper-1 E_A: y^2=(x+A)(x-2)(x+2) isomorphic to the Jacobian of the quartic w^2 = mu^4 + A mu^2 + 1 ?
chkEA(s) = { my(a=numerator(s),b=denominator(s),U1=a^2-b^2,V1=2*a*b,W1=a^2+b^2,c=(U1^2-V1^2)/W1^2,A=2-4*c^2); printf("   s=%s: E_A isomorphic to Jac(w^2=mu^4+A mu^2+1)? %d ; E'_A is the (-1)-twist of E''_A? %d\n", s, isom(ellinit([0,A,0,-4,-4*A]), Eq(x^4+A*x^2+1)), isom(Eq(x^4-4*x^2+(A+2)), ellinit(elltwist(Eq(x^4+4*x^2+(A+2)), -4)))); };
foreach([2,3/2,5/2,7/3], s, chkEA(s));
print("== paper 3's Master curve E_{m,n} (Jacobian of s^2 = V2^2 t^4 + (4U2^2-2V2^2) t^2 + V2^2) vs paper 1's E''_A(s=m/n) and dGGH's EF1");
cmpE(mn) = {
  my(m=mn[1], n=mn[2], U2=m^2-n^2, V2=2*m*n, W2=m^2+n^2, c=(U2^2-V2^2)/W2^2, A=2-4*c^2);
  my(Emn = Eq(V2^2*x^4+(4*U2^2-2*V2^2)*x^2+V2^2), Epp = Eq(x^4+4*x^2+(A+2)), EF1 = ellinit([0,W2^2,0,4*m^2*n^2*U2^2,0]));
  printf("   (m,n)=%s: N(E_mn)=%d tors %s ; N(E''_A)=%d ; N(EF1)=%d ; E_mn isog E''_A? %d ; E_mn isog EF1? %d ; E_mn isomorphic to EF1? %d\n", mn, ellglobalred(Emn)[1], elltors(Emn)[2], ellglobalred(Epp)[1], ellglobalred(EF1)[1], isog(Emn,Epp), isog(Emn,EF1), isom(Emn, EF1));
};
foreach([[2,1],[3,2],[5,2],[8,5],[18,7]], mn, cmpE(mn));
