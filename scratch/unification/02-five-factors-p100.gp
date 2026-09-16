\\ 02-five-factors-p100.gp
\\ Rank upper bounds (PARI ellrank, effort 0 = unconditional 2-descent bound) for the five
\\ elliptic factors of J(X_s) for the face with Euclid pair (p,q):
\\    a = p^2-q^2,  b = 2pq,  d = p^2+q^2
\\    R1 = EF1  = x(x+a^2)(x+b^2)          [ ~ Rat x Master quotient; Euler-brick curve ]
\\    R2 = EF2  = x(x+a^4)(x+b^4)          [ = F1, the even part of the genus-2 quotient ]
\\    R3 = EF3  = x(x+a^2)(x+d^2)          [ ~ Rat x Hsum quotient ]
\\    R4 = EF4  = x(x+b^2)(x+d^2)          [ ~ Master x Hsum quotient ]
\\    R5 = F2   = x(x-a^2)(x-b^2)          [ = EF1 twisted by -1, odd part of the genus-2 quotient ]
\\ -1 in a column = ellrank did not finish inside TLIM seconds.
\\ class: A = some factor has upper bound 0 (fiber excluded)
\\        B = no factor certified rank 0, but the sum of the five upper bounds is <= 4
\\        C = sum of the five upper bounds is >= 5
\\        D = at least one column timed out and no factor is certified rank 0
\\ Output line: p q R1 R2 R3 R4 R5 class zerolist seconds
default(parisize, "768M");
PMAX = eval(getenv("PMAX"));  if (PMAX == 0, PMAX = 100);
PMIN = eval(getenv("PMIN"));  if (PMIN == 0, PMIN = 2);
RES  = eval(getenv("RES"));
TLIM = eval(getenv("TLIM"));  if (TLIM == 0, TLIM = 60);
ubt(E) = my(r = alarm(TLIM, ellrank(E)[2])); if (type(r) == "t_ERROR", -1, r);
{
for (p = PMIN, PMAX,
  if (p % 4 != RES, next);
  for (q = 1, p - 1,
    if (gcd(p, q) != 1 || (p - q) % 2 == 0, next);
    my(a = p^2 - q^2, b = 2*p*q, d = p^2 + q^2, t0 = getabstime());
    my(R = vector(5));
    R[1] = ubt(ellinit([0,  a^2 + b^2, 0, a^2*b^2, 0]));
    R[2] = ubt(ellinit([0,  a^4 + b^4, 0, a^4*b^4, 0]));
    R[3] = ubt(ellinit([0,  a^2 + d^2, 0, a^2*d^2, 0]));
    R[4] = ubt(ellinit([0,  b^2 + d^2, 0, b^2*d^2, 0]));
    R[5] = ubt(ellinit([0, -a^2 - b^2, 0, a^2*b^2, 0]));
    my(zeros = "", nto = 0, tot = 0);
    for (i = 1, 5,
      if (R[i] == 0, zeros = Str(zeros, i));
      if (R[i] < 0, nto++, tot += R[i]));
    if (zeros == "", zeros = "-");
    my(cl);
    if (zeros != "-", cl = "A",
      if (nto > 0, cl = "D",
        if (tot <= 4, cl = "B", cl = "C")));
    print(p, " ", q, " ", R[1], " ", R[2], " ", R[3], " ", R[4], " ", R[5], " ", cl, " ", zeros, " ", (getabstime()-t0)/1000.0);
  );
);
}
