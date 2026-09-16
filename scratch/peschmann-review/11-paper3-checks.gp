\\ 11-paper3-checks.gp : checks on paper 3 (2605.00573)
default(parisize, 512000000); default(parisizemax, 2000000000);
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
canon(a,b,m,n) = { my(U1=a^2-b^2,V1=2*a*b,W1=a^2+b^2,U2=m^2-n^2,V2=2*m*n,W2=m^2+n^2); [a,b,m,n,a+b,a-b,m+n,m-n,a^2+b^2,a^2-b^2,m^2+n^2,m^2-n^2,a*b,m*n,2*a*b,2*m*n,W1*U2,U1*V2,W1*V2,V1*U2,U1*U2,V1*V2,W1*W2,U1,V1,W1,U2,V2,W2]; };
isog(E1,E2) = { my(L = ellisomat(E1,,1)[1]); for(i=1,#L, my(Ei = ellinit(L[i])); if(Ei.j == E2.j && issquare(Ei.c6*E2.c4/(Ei.c4*E2.c6)), return(1))); 0; };
isom(E1,E2) = E1.j == E2.j && issquare(E1.c6*E2.c4/(E1.c4*E2.c6));
check(a,b,m,n,label) = {
  my(U1=a^2-b^2,V1=2*a*b,W1=a^2+b^2,U2=m^2-n^2,V2=2*m*n,W2=m^2+n^2, M = (V1*U2)^2+(U1*V2)^2, f1 = (W1*U2)^2+(U1*V2)^2, P = Set(abs(canon(a,b,m,n))), F, odd = List(), e1out = List(), oddout = List(), tf);
  printf("== %s (a,b,m,n)=(%d,%d,%d,%d): gcds ok=%d parity ok=%d; M square? %d ; f1 has %d digits; #distinct canonical values = %d\n", label, a,b,m,n, gcd(a,b)==1 && gcd(m,n)==1, (a-b)%2==1 && (m-n)%2==1, issquare(M), #digits(f1), #P);
  gettime(); F = iferr(alarm(900, factor(f1)), err, 0); tf = gettime()/1000.0;
  if(F == 0, print("   factorisation timed out"); return);
  for(i=1,#F[,1], my(p = F[i,1], e = F[i,2], cop = 1); for(k=1,#P, if(P[k] != 0 && P[k] % p == 0, cop = 0));
     if(e%2==1, listput(odd, [p,e,cop])); if(e==1 && cop, listput(e1out, p)); if(e%2==1 && cop, listput(oddout, [p,e])));
  printf("   f1 factorisation (%.1fs): %s\n", tf, F~);
  printf("   odd-exponent primes [p, e, coprime-to-P]: %s\n", Vec(odd));
  printf("   smallest odd-exponent prime outside P: %s ; exponent-one primes outside P: %s ; largest prime outside P: %s (exponent %d)\n", if(#oddout, oddout[1], "none"), Vec(e1out), F[#F[,1],1], F[#F[,1],2]);
};
check(55,48,44,9, "Remark 4.5 example (paper: smallest outside-P odd-exponent prime is '133')");
print("   note: 133 = 7 * 19 is not prime.");
check(835,88,160,89, "Appendix A #1 (k=29)");
check(180133,174512,3977,3904, "Appendix A #2 (k=29)");
check(731423,108452,14896,8177, "Appendix A #3 (k=29)");
check(1162341,60812,18768,11065, "Appendix A #4 (k=89)");
check(1770,1219,1408,477, "Appendix B #1 (largest outside-P prime has even exponent)");
check(39732,16895,6400,3069, "Appendix B #2");
check(50626,33631,6461,3736, "Appendix B #3");
print();
print("== E_{88,7} benchmark (paper 3 section 3.2): minimal model, conductor, torsion, rank bounds");
bench() = {
  my(m=88, n=7, U2=m^2-n^2, V2=2*m*n, E = Eq(V2^2*x^4+(4*U2^2-2*V2^2)*x^2+V2^2), Em = ellminimalmodel(E), Epaper = ellinit([1,0,0,-71221066018500,230819306124825756432]), r);
  printf("   my minimal model a-invariants: %s\n", [Em.a1,Em.a2,Em.a3,Em.a4,Em.a6]);
  printf("   paper's model: conductor %d, torsion %s ; my model conductor %d torsion %s ; isomorphic over Q? %d\n", ellglobalred(Epaper)[1], elltors(Epaper)[2], ellglobalred(Em)[1], elltors(Em)[2], isom(Em, Epaper));
  r = iferr(alarm(600, ellrank(Em, 0)), err, [-1,-1,"timeout"]); printf("   ellrank(effort 0): rank in [%s,%s]  (paper: rank exactly 3 via Magma)\n", r[1], r[2]);
};
bench();
print();
print("== paper 3's Master curve E_{m,n} (Jacobian of s^2 = V2^2 t^4 + (4U2^2-2V2^2) t^2 + V2^2) vs paper 1's E''_A(s=m/n) and dGGH's EF1");
cmp(mn) = {
  my(m=mn[1], n=mn[2], U2=m^2-n^2, V2=2*m*n, W2=m^2+n^2, c=(U2^2-V2^2)/W2^2, A=2-4*c^2);
  my(Emn = Eq(V2^2*x^4+(4*U2^2-2*V2^2)*x^2+V2^2), Epp = Eq(x^4+4*x^2+(A+2)), EF1 = ellinit([0,W2^2,0,4*m^2*n^2*U2^2,0]));
  printf("   (m,n)=%s: N(E_mn)=%d tors %s ; N(E''_A)=%d ; N(EF1)=%d ; E_mn isog E''_A? %d ; E_mn isog EF1? %d ; E_mn isomorphic to EF1? %d\n", mn, ellglobalred(Emn)[1], elltors(Emn)[2], ellglobalred(Epp)[1], ellglobalred(EF1)[1], isog(Emn,Epp), isog(Emn,EF1), isom(Emn, EF1));
};
foreach([[2,1],[3,2],[5,2],[8,5],[18,7]], mn, cmp(mn));
