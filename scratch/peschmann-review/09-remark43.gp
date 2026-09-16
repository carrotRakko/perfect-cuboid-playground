\\ 09-remark43.gp : paper 1 Remark 4.3: for s' = a/b with 1<=a<b<=19, gcd(a,b)=1 ("119 pairs"), ellrank certifies rank 0 for E_A in 42 cases and for E'_A in 54 cases.
default(parisize, 256000000);
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
rk(E) = iferr(alarm(60, ellrank(E, 0)), err, [-1,-1,"timeout"]);
{
my(pairs = 0, pairs_par = 0, z0A = 0, z0Ap = 0, z0A_par = 0, z0Ap_par = 0, tA = 0, tAp = 0);
for(b = 2, 19, for(a = 1, b-1, if(gcd(a,b) != 1, next);
  my(U1 = a^2-b^2, V1 = 2*a*b, W1 = a^2+b^2, c = (U1^2-V1^2)/W1^2, A = 2-4*c^2);
  my(EA = ellminimalmodel(ellinit([0,A,0,-4,-4*A])), EAp = Eq(x^4-4*x^2+(A+2)));
  my(rA = rk(EA), rAp = rk(EAp), par = (a-b)%2);
  pairs++; if(par, pairs_par++);
  if(rA[1]==0 && rA[2]==0, z0A++; if(par, z0A_par++)); if(rA[2]=="timeout", tA++);
  if(rAp[1]==0 && rAp[2]==0, z0Ap++; if(par, z0Ap_par++)); if(rAp[2]=="timeout", tAp++);
  printf("a/b=%d/%d par=%d | E_A N=%d rank=[%s,%s] | E'_A N=%d rank=[%s,%s]\n", a, b, par, ellglobalred(EA)[1], rA[1], rA[2], ellglobalred(EAp)[1], rAp[1], rAp[2]);
));
printf("SUMMARY: coprime pairs a<b<=19: %d (of which a-b odd: %d); sharp rank 0: E_A %d (odd-parity subset %d), E'_A %d (odd-parity subset %d); timeouts E_A %d, E'_A %d\n", pairs, pairs_par, z0A, z0A_par, z0Ap, z0Ap_par, tA, tAp);
}
