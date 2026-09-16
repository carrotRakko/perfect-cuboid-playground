\\ 08-Lvalue.gp : (a) paper-2 worked examples: ranks of E_PQ, E_uV, E_3 at (2,1) and (5,2);
\\ (b) PARI-only rank-0 certification of E_3 on the 21 fibers (m<=25) where ellrank(effort 0) is ambiguous:
\\     ellrank effort 2; numerical L(E,1) via ellL1; exact modular symbol via msfromell/mseval; Sage-style denominator bound C = 8 d t.
default(parisize, 512000000);
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
rk(E, eff, sec) = iferr(alarm(sec, ellrank(E, eff)), err, [-1,-1,"timeout"]);
{
print("== (a) paper's worked examples");
foreach([[2,1],[5,2]], mn,
  my(m = mn[1], n = mn[2], U2 = m^2-n^2, V2 = 2*m*n, W2 = m^2+n^2);
  my(EPQ = Eq((V2^2*x^2+(4*U2^2-2*V2^2)*x+V2^2)*(W2^2*x^2+2*(U2^2-V2^2)*x+W2^2)));
  my(EuV = Eq((V2^2*x^2+4*(U2^2-V2^2))*(W2^2*x^2-4*V2^2)));
  my(E3  = Eq((V2^2*x^2+4*U2^2)*(W2^2*x^2+4*U2^2)));
  printf("  (m,n)=%s: rank E_PQ=%s  E_uV=%s  E_3=%s ; tors E_3 = %s (paper: (2,1)->1,0,0 tors4 ; (5,2)->2,1,1)\n", mn, rk(EPQ,0,120)[1..2], rk(EuV,0,120)[1..2], rk(E3,0,120)[1..2], elltors(E3)[2]);
);
print("== (b) ambiguous E_3 fibers (m<=25): PARI-only certification");
my(amb = readvec("amb3_m25.txt"));
for(i = 1, #amb,
  my(m = amb[i][1], n = amb[i][2], U2 = m^2-n^2, V2 = 2*m*n, W2 = m^2+n^2);
  my(E = Eq((V2^2*x^2+4*U2^2)*(W2^2*x^2+4*U2^2)), Em = ellminimalmodel(E), N = ellglobalred(E)[1]);
  my(r0 = rk(Em,0,60), r2 = rk(Em,2,120));
  gettime();
  my(L1 = ellL1(Em), tL = gettime()/1000.0);
  my(om = Em.omega[1], t = elltors(Em)[1]);
  my(isoM = ellisomat(Em,,1)[2], d = 1); for(j=1,#isoM[1,], d = lcm(d, isoM[1,j]));
  my(C = 8*d*t, nn = L1*C/om, nr = round(nn));
  my(ms = iferr(alarm(300, msfromell(Em, 1)), err, 0), msval = "n/a", tms = 0);
  gettime();
  if(ms != 0, msval = iferr(mseval(ms[1], ms[2], [0, oo]), err, Str("err:",err)); tms = gettime()/1000.0);
  printf("  (%d,%d) N=%d sqf=%d tors=%d | ellrank eff0=%s eff2=%s | L(E,1)=%.6f (%.1fs) omega=%.6f  d=%d C=%d  L*C/omega=%.6f -> round %d (|err| %.2e) | exact modsym {0,oo} = %s (%.1fs)\n",
     m, n, N, issquarefree(N), t, r0[1..2], r2[1..2], L1, tL, om, d, C, nn, nr, abs(nn-nr), msval, tms);
);
}
