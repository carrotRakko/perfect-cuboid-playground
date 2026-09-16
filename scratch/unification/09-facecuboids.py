#!/usr/bin/env python3
"""Item 4(a): generate face cuboids (a,b,c): a^2+b^2 = d^2, b^2+c^2 = e^2, a^2+b^2+c^2 = g^2,
a^2+c^2 NOT a square.  For each, report the face Euclid pair (p,q) and test whether the point
x = c^2 lies on the proof-text curve x(x+b^2)(x+d^2) and on the displayed curve
x(x+4p^2q^2)(x+(p^2-q^2+2pq)^2) = x(x+b^2)(x+(a+b)^2)."""
from math import isqrt, gcd
def issq(n):
    if n < 0: return False
    r = isqrt(n); return r*r == n
def legs(c):
    """all b>0 with b^2 + c^2 a square, via c^2 = (e-b)(e+b)"""
    out = []
    n = c*c
    i = 1
    while i*i < n:
        if n % i == 0:
            u, v = i, n//i
            if (u+v) % 2 == 0:
                b = (v-u)//2
                if b > 0: out.append(b)
        i += 1
    return sorted(set(out))

found = []
CMAX = 3000
for c in range(1, CMAX+1):
    L = legs(c)
    if len(L) < 2: continue
    S = set(L)
    for b in L:                       # b^2+c^2 = e^2
        for g in L:                   # g^2 = c^2 + d^2  -> d = g is a "leg" partner
            pass
    # d must satisfy d^2 + c^2 = g^2, so d is also in L; and d^2 - b^2 = a^2
    for b in L:
        for d in L:
            if d <= b: continue
            t = d*d - b*b
            if t <= 0 or not issq(t): continue
            a = isqrt(t)
            if a == 0: continue
            if issq(a*a + c*c): continue          # must be a *face* cuboid, not a perfect cuboid
            if gcd(gcd(a, b), c) != 1: continue   # primitive body
            found.append((a, b, c, d))
print("face cuboids found with third edge c <= %d: %d" % (CMAX, len(found)))
print()
print("  a      b      c      d=sqrt(a^2+b^2)  (p,q)      face primitive?   c^2+(a+b)^2 square?   c^2+d^2 square?")
shown = 0
for (a, b, c, d) in found:
    # face Euclid pair: a odd leg, b even leg of the (a,b,d) triple; primitive part
    k = gcd(gcd(a, b), d)
    a0, b0, d0 = a//k, b//k, d//k
    if a0 % 2 == 0: a0, b0 = b0, a0            # a0 odd, b0 even
    # p,q from a0 = p^2-q^2, b0 = 2pq, d0 = p^2+q^2
    p2 = (d0 + a0)//2; q2 = (d0 - a0)//2
    pq = None
    if issq(p2) and issq(q2):
        p, q = isqrt(p2), isqrt(q2)
        if p*p - q*q == a0 and 2*p*q == b0: pq = (p, q)
    print("  %-6d %-6d %-6d %-15d %-10s %-17s %-21s %s" % (
        a, b, c, d, str(pq), "yes" if k == 1 else "no (k=%d)" % k,
        issq(c*c + (a+b)**2), issq(c*c + d*d)))
    shown += 1
    if shown >= 60: break
nd = sum(1 for (a,b,c,d) in found if __import__("math").isqrt(c*c+d*d)**2 == c*c+d*d)
ns = sum(1 for (a,b,c,d) in found if __import__("math").isqrt(c*c+(a+b)**2)**2 == c*c+(a+b)**2)
print()
print("SUMMARY over all %d face cuboids:" % len(found))
print("   x = c^2 lies on the proof-text curve  x(x+b^2)(x+d^2)        : %d of %d" % (nd, len(found)))
print("   x = c^2 lies on the displayed curve   x(x+b^2)(x+(a+b)^2)    : %d of %d" % (ns, len(found)))
