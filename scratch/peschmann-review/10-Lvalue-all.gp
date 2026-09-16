\\ 10-Lvalue-all.gp : PARI-only re-certification of rank 0 for all 504 fibers that the paper-2 CSV marks rank_resolution = modular_symbol
\\ (468 via E_3, 36 via E_uV). For each: ellrank effort 0 (60 s alarm; effort 2 was tested on 21 fibers in 08-Lvalue.out and never sharpened the bound); L(E,1) via ellL1; Sage-style integrality bound C = 8 d t
\\ (d = lcm of isogeny degrees in the class, t = torsion order); n = L(E,1) C / omega_1 must be a nonzero integer; exact modular symbol when N < 20000.
default(parisize, 512000000); default(parisizemax, 2000000000);
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
rk(E, eff, sec) = iferr(alarm(sec, ellrank(E, eff)), err, [-1,-1,"timeout"]);
{
my(L = readvec("ms_fibers.txt.gp"), nsharp2 = 0, nnonzero = 0, nbad = 0, maxerr = 0, nms = 0);
for(i = 1, #L,
  my(m = L[i][1], n = L[i][2], q = L[i][3], U2 = m^2-n^2, V2 = 2*m*n, W2 = m^2+n^2, E);
  if(q == "E_3", E = Eq((V2^2*x^2+4*U2^2)*(W2^2*x^2+4*U2^2)), E = Eq((V2^2*x^2+4*(U2^2-V2^2))*(W2^2*x^2-4*V2^2)));
  my(Em = ellminimalmodel(E), N = ellglobalred(Em)[1], r2 = rk(Em, 0, 60));
  gettime(); my(L1 = iferr(alarm(300, ellL1(Em)), err, 0), tL = gettime()/1000.0);
  my(om = Em.omega[1], t = elltors(Em)[1], isoM = ellisomat(Em,,1)[2], d = 1); for(j=1,#isoM[1,], d = lcm(d, isoM[1,j]));
  my(C = 8*d*t, nn = L1*C/om, nr = round(nn), er = abs(nn-nr), msval = "-");
  if(N <= 2000, my(ms = msfromell(Em, 1)); msval = mseval(ms[1], ms[2], [0, oo]); nms++);
  if(r2[1]==0 && r2[2]==0, nsharp2++); if(nr != 0 && er < 1e-10, nnonzero++, nbad++); maxerr = max(maxerr, er);
  printf("(%d,%d) %s N=%d sqf=%d tors=%d | ellrank eff0=[%s,%s] | L1=%.6g (%.1fs) d=%d C=%d n=L1*C/omega=%d err=%.1e | modsym=%s\n", m, n, q, N, issquarefree(N), t, r2[1], r2[2], L1, tL, d, C, nr, er, msval);
);
printf("SUMMARY: %d fibers; ellrank effort 0 sharp [0,0]: %d; L-value certificate nonzero integer: %d; failures: %d; max rounding error %.2e; exact modular symbols computed: %d\n", #L, nsharp2, nnonzero, nbad, maxerr, nms);
}
