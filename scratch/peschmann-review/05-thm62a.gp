\\ 05-thm62a.gp : Theorem 6.2(a) of paper 1 ("delta_3 = 1 implies f(P) == 2 mod squares, hence not a square").
\\ Checks: torsion structure of E_A, which 2-torsion point is halved (paper's proof assumes 2T4 = T1),
\\ descent triple and f-value at the 4-torsion points (they have delta_3 = 1 and f = +-1),
\\ and a search for NON-torsion points with delta_3 = 1 to test the intermediate claim f/2 in Q^{*2}.
default(parisize, 256000000);
sqf(q) = if(q == 0, 0, core(numerator(q)*denominator(q)));
delta(P, A) = [sqf(P[1]+A), sqf(P[1]-2), sqf(P[1]+2)];
fP(P) = 2*P[2]/((P[1]-2)*(P[1]+2));
dotest(s) = {
  my(a = numerator(s), b = denominator(s), U1 = a^2-b^2, V1 = 2*a*b, W1 = a^2+b^2, c = (U1^2-V1^2)/W1^2, A = 2-4*c^2, kap = 4*a*b*U1/W1^2);
  my(E = ellinit([0, A, 0, -4, -4*A]), T = elltors(E), tors = List(), T4s = List(), r, cnt = 0, hits = 0, sqhits = 0);
  printf("== s = %s : A = %s, kappa = %s, torsion %s\n", s, A, kap, T[2]);
  \\ enumerate torsion subgroup
  for(j = 0, T[1]-1, for(k = 0, 1, my(P = elladd(E, ellmul(E, T[3][1], j), if(#T[3] > 1, ellmul(E, T[3][2], k), [0]))); listput(tors, P)));
  tors = Set(tors);
  for(i = 1, #tors, my(P = tors[i]); if(P == [0], next); my(o = ellorder(E, P));
     if(o == 4, printf("   order-4 point P = %s : 2P = %s (T1=(-A,0)=%s, T2=(2,0), T3=(-2,0)); x(P) in {2+-4kappa}? %d ; delta = %s ; f(P) = %s ; x+2 square? %d\n", P, ellmul(E,P,2), [-A,0], (P[1]==2+4*kap)||(P[1]==2-4*kap), delta(P,A), fP(P), issquare(P[1]+2))));
  r = iferr(alarm(180, ellrank(E, 0)), err, [-1,-1,0,[]]);
  printf("   ellrank: rank in [%s,%s], %d generators found\n", r[1], r[2], #r[4]);
  for(g = 1, #r[4], my(G = r[4][g]);
    for(k = 1, 4, for(i = 1, #tors,
       my(P = elladd(E, ellmul(E, G, k), tors[i])); if(P == [0] || P[1] == 2 || P[1] == -2 || P[1] == -A, next);
       cnt++;
       my(d = delta(P,A), f = fP(P));
       if(d[3] == 1, hits++; printf("   NON-TORSION P with delta_3 = 1: k=%d P=%s delta=%s f(P)=%s f square? %d f/2 square? %d -> paper's intermediate claim 'f == 2 mod squares' %s\n", k, P, d, f, issquare(f), issquare(f/2), if(issquare(f/2), "holds here", "FAILS here")); if(issquare(f), sqhits++));
    )));
  printf("   tested %d non-torsion points; %d had delta_3 = 1; %d of those had f square (would contradict Thm 6.2(a))\n", cnt, hits, sqhits);
};
{
foreach([2, 3, 3/2, 4, 5/2, 5/3, 7/2, 8/3, 7/4, 9/2], s, dotest(s));
}
