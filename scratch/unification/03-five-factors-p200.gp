\\ 03-five-factors-p200.gp : same five factors as 02-five-factors-p100.gp, but for p <= 200 and
\\ recording BOTH bounds returned by ellrank (lower bound from found points, upper bound from 2-descent).
\\ Output line: p q L1 U1 L2 U2 L3 U3 L4 U4 L5 U5 sec   (-1 -1 = timed out)
default(parisize, "768M");
PMAX = eval(getenv("PMAX"));  if (PMAX == 0, PMAX = 200);
RES  = eval(getenv("RES"));
TLIM = eval(getenv("TLIM"));  if (TLIM == 0, TLIM = 60);
rk(E) = my(r = alarm(TLIM, ellrank(E)[1..2])); if (type(r) == "t_ERROR", [-1,-1], r);
{
for (p = 2, PMAX,
  if (p % 4 != RES, next);
  for (q = 1, p - 1,
    if (gcd(p, q) != 1 || (p - q) % 2 == 0, next);
    my(a = p^2 - q^2, b = 2*p*q, d = p^2 + q^2, t0 = getabstime());
    my(r1 = rk(ellinit([0,  a^2 + b^2, 0, a^2*b^2, 0])),
       r2 = rk(ellinit([0,  a^4 + b^4, 0, a^4*b^4, 0])),
       r3 = rk(ellinit([0,  a^2 + d^2, 0, a^2*d^2, 0])),
       r4 = rk(ellinit([0,  b^2 + d^2, 0, b^2*d^2, 0])),
       r5 = rk(ellinit([0, -a^2 - b^2, 0, a^2*b^2, 0])));
    print(p," ",q," ",r1[1]," ",r1[2]," ",r2[1]," ",r2[2]," ",r3[1]," ",r3[2]," ",r4[1]," ",r4[2]," ",r5[1]," ",r5[2]," ",(getabstime()-t0)/1000.0);
  );
);
}
