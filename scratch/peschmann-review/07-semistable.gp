\\ 07-semistable.gp : conductors of E_3, E_uV, E_PQ for all 2040 fibers max(m,n)<=100; squarefree (semistable) check; torsion of E_uV (claim: always >= 8)
default(parisize, 256000000);
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
{
my(fibers = readvec("fibers_all.txt.gp"), cnt = 0, nonss3 = 0, nonssuV = 0, nonssPQ = 0, tuVmin = 1000, tuVhist = Map());
for(i = 1, #fibers,
  my(m = fibers[i][1], n = fibers[i][2], U2 = m^2-n^2, V2 = 2*m*n, W2 = m^2+n^2, E3, EuV, EPQ, N3, NuV, NPQ, t3, tuV, tPQ);
  E3  = Eq((V2^2*x^2+4*U2^2)*(W2^2*x^2+4*U2^2));
  EuV = Eq((V2^2*x^2+4*(U2^2-V2^2))*(W2^2*x^2-4*V2^2));
  EPQ = Eq((V2^2*x^2+(4*U2^2-2*V2^2)*x+V2^2)*(W2^2*x^2+2*(U2^2-V2^2)*x+W2^2));
  N3 = ellglobalred(E3)[1]; NuV = ellglobalred(EuV)[1]; NPQ = ellglobalred(EPQ)[1];
  t3 = elltors(E3)[1]; tuV = elltors(EuV)[1]; tPQ = elltors(EPQ)[1];
  if(!issquarefree(N3), nonss3++); if(!issquarefree(NuV), nonssuV++); if(!issquarefree(NPQ), nonssPQ++);
  tuVmin = min(tuVmin, tuV); mapput(tuVhist, tuV, iferr(mapget(tuVhist, tuV), e, 0) + 1);
  printf("%d %d | N3=%d sqf=%d tors3=%d | NuV=%d sqf=%d torsuV=%d | NPQ=%d sqf=%d torsPQ=%d\n", m, n, N3, issquarefree(N3), t3, NuV, issquarefree(NuV), tuV, NPQ, issquarefree(NPQ), tPQ);
  cnt++;
);
printf("SUMMARY: %d fibers; non-squarefree conductors: E_3 %d, E_uV %d, E_PQ %d; min |E_uV tors| = %d; E_uV torsion histogram = %s\n", cnt, nonss3, nonssuV, nonssPQ, tuVmin, Vec(tuVhist));
}
