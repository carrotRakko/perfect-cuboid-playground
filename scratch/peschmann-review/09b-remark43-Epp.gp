\\ 09b-remark43-Epp.gp : same 119 pairs as 09; rank bounds of E''_A (sigma^4 + 4 sigma^2 + (A+2)) and distribution of E'_A bounds
default(parisize, 256000000);
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
rk(E) = iferr(alarm(60, ellrank(E, 0)), err, [-1,-1,"timeout"]);
{
my(z0 = 0, hist = Map(), histp = Map(), pairs = 0);
for(b = 2, 19, for(a = 1, b-1, if(gcd(a,b) != 1, next);
  my(U1 = a^2-b^2, V1 = 2*a*b, W1 = a^2+b^2, c = (U1^2-V1^2)/W1^2, A = 2-4*c^2);
  my(Epp = Eq(x^4+4*x^2+(A+2)), Ep = Eq(x^4-4*x^2+(A+2)), r = rk(Epp), rp = rk(Ep), key = Str(r[1..2]), keyp = Str(rp[1..2]));
  pairs++; if(r[1]==0 && r[2]==0, z0++);
  mapput(hist, key, iferr(mapget(hist,key),e,0)+1); mapput(histp, keyp, iferr(mapget(histp,keyp),e,0)+1);
  printf("a/b=%d/%d | E''_A N=%d rank=%s | E'_A N=%d rank=%s\n", a, b, ellglobalred(Epp)[1], r[1..2], ellglobalred(Ep)[1], rp[1..2]);
));
printf("SUMMARY: %d pairs; E''_A sharp rank 0: %d (paper's 'E'_A' count: 54); E''_A bound histogram %s ; E'_A bound histogram %s\n", pairs, z0, Vec(hist), Vec(histp));
}
