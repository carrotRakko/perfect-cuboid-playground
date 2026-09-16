\\ 06-fibers-m25.gp : reproduce the paper-2 classification for all 131 fibers (m,n), m<=25, using PARI only.
\\ For each fiber: E_3 and E_uV Weierstrass models via ellfromeqn; ellrank (effort 0, 90 s alarm); elltors.
default(parisize, 256000000);
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
rk(E) = iferr(alarm(90, ellrank(E, 0)), err, [-1,-1,"timeout"]);
{
my(fibers = readvec("fibers_m25.txt.gp"));
for(i = 1, #fibers,
  my(m = fibers[i][1], n = fibers[i][2], U2 = m^2-n^2, V2 = 2*m*n, W2 = m^2+n^2, E3, EuV, r3, ruV, t3, tuV, N3, NuV, verdict = "none");
  E3  = Eq((V2^2*x^2+4*U2^2)*(W2^2*x^2+4*U2^2));
  EuV = Eq((V2^2*x^2+4*(U2^2-V2^2))*(W2^2*x^2-4*V2^2));
  N3 = ellglobalred(E3)[1]; NuV = ellglobalred(EuV)[1];
  t3 = elltors(E3)[1]; tuV = elltors(EuV)[1];
  gettime(); r3 = rk(E3); my(dt3 = gettime()/1000.0);
  ruV = rk(EuV); my(dtuV = gettime()/1000.0);
  if(r3[1] == 0 && r3[2] == 0 && t3 == 4, verdict = "E_3");
  if(verdict == "none" && ruV[1] == 0 && ruV[2] == 0 && tuV == 8, verdict = "E_uV");
  printf("%d %d | E3: N=%d tors=%d rank=[%s,%s] %.1fs | EuV: N=%d tors=%d rank=[%s,%s] %.1fs | verdict=%s\n", m, n, N3, t3, r3[1], r3[2], dt3, NuV, tuV, ruV[1], ruV[2], dtuV, verdict);
);
}
