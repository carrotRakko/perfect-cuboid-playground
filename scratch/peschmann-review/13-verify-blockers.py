# 13-verify-blockers.py (v2: stored factorisations are of f1/g^2 = x^2+y^2+z^2; partial records separated) : reproduce paper 3's Verification 4.2 (exponent-one blocker outside the 29 canonical expressions)
# from the released file csv/prim_brick_factors.csv.gz (keyed by primitive brick (x,y,z); (a,b,m,n) recovered via paper 2 Thm 2.4).
import gzip, csv, collections
from math import gcd, isqrt
def issq(n):
    if n < 0: return False
    r = isqrt(n); return r*r == n
def euclid(U, V):
    W2 = U*U + V*V; W = isqrt(W2)
    if W*W != W2 or (W+U) % 2 or (W-U) % 2: return None
    a2, b2 = (W+U)//2, (W-U)//2; a, b = isqrt(a2), isqrt(b2)
    if a*a != a2 or b*b != b2: return None
    return a, b
def master_tuple(x, y, z):
    edges = [x, y, z]; odd = [e for e in edges if e % 2 == 1]
    if len(odd) != 1: return None
    X = odd[0]; rest = [e for e in edges if e % 2 == 0]
    Y, Z = rest
    d, e = gcd(X, Y), gcd(X, Z)
    ab = euclid(X//d, Y//d); mn = euclid(X//e, Z//e)
    if ab is None or mn is None: return None
    return ab[0], ab[1], mn[0], mn[1]
def canon(a, b, m, n):
    U1, V1, W1 = a*a-b*b, 2*a*b, a*a+b*b; U2, V2, W2 = m*m-n*n, 2*m*n, m*m+n*n
    L = [a, b, m, n, a+b, a-b, m+n, m-n, W1, U1, W2, U2, a*b, m*n, V1, V2, W1*U2, U1*V2, W1*V2, V1*U2, U1*U2, V1*V2, W1*W2, U1, V1, W1, U2, V2, W2]
    return set(abs(v) for v in L if v != 0)
recs = collections.OrderedDict()
with gzip.open('repo/prim_brick_factors.csv.gz', 'rt') as fh:
    for r in csv.DictReader(fh):
        key = (int(r['x_prim']), int(r['y_prim']), int(r['z_prim']))
        recs.setdefault(key, []).append((int(r['prime']), int(r['exponent']), r['is_blocker'] == 't'))
print("distinct primitive bricks in file:", len(recs))
n_ok = n_fail = n_notmaster = n_badf1 = n_perfect = n_nomt = n_partial = n_full = 0
num_blockers = collections.Counter(); five_e1 = 0; smallest_ge3 = 0; largest_even = 0; kdist = collections.Counter(); fails = []
noblocker_at_all = 0; bad_flag = 0
for (x, y, z), fac in recs.items():
    mt = master_tuple(x, y, z)
    if mt is None: n_nomt += 1; continue
    a, b, m, n = mt
    U1, V1, W1 = a*a-b*b, 2*a*b, a*a+b*b; U2, V2, W2 = m*m-n*n, 2*m*n, m*m+n*n
    g = gcd(U1, U2)
    if (U1*U2//g, V1*U2//g, U1*V2//g) != (x, y, z) and (U1*U2//g, U1*V2//g, V1*U2//g) != (x, y, z): n_fail += 1; fails.append(('brick mismatch', x, y, z, mt)); continue
    if not issq(y*y + z*z) and not issq(x*x+y*y) and not issq(x*x+z*z): n_notmaster += 1
    f1 = (W1*U2)**2 + (U1*V2)**2
    f1p = f1 // (g*g)          # the file stores the factorisation of the primitive value f1/g^2 = x^2+y^2+z^2
    assert f1p == x*x + y*y + z*z
    prod = 1
    for p, e, blk in fac:
        prod *= p**e
        if blk != (e % 2 == 1): bad_flag += 1
    if prod != f1p:
        if f1p % prod == 0: n_partial += 1; continue      # partially factored record (D_part)
        n_badf1 += 1; fails.append(('f1 mismatch', x, y, z, mt)); continue
    n_full += 1
    if issq(f1): n_perfect += 1
    P = canon(a, b, m, n)
    def outside(p): return all(v % p != 0 for v in P)
    blockers = [p for p, e, blk in fac if e % 2 == 1]
    num_blockers[len(blockers)] += 1
    if not blockers: noblocker_at_all += 1
    e1_out = [p for p, e, blk in fac if e == 1 and outside(p)]
    if e1_out: n_ok += 1
    else: n_fail += 1; fails.append(('no exponent-one blocker outside P', x, y, z, mt, fac))
    if any(p == 5 and e == 1 for p, e, blk in fac): five_e1 += 1
    odd_out = sorted((p, e) for p, e, blk in fac if e % 2 == 1 and outside(p))
    if odd_out and odd_out[0][1] >= 3: smallest_ge3 += 1
    out_all = sorted((p, e) for p, e, blk in fac if outside(p))
    if out_all and out_all[-1][1] % 2 == 0: largest_even += 1
    if blockers and all(e == 1 for p, e, blk in fac if e % 2 == 1):
        g0 = gcd(W1*U2, U1*V2); xi, eta = W1*U2//g0, U1*V2//g0; rf = 1
        for p in blockers: rf *= p
        q, rem = divmod(xi*xi + eta*eta, rf)
        k = isqrt(q) if rem == 0 else -1
        kdist[k if (rem == 0 and k*k == q) else -1] += 1
print("records with master tuple recovered:", len(recs) - n_nomt, " (no master tuple:", n_nomt, ")")
print("fully factored records (D_fact):", n_full, "(paper: 151,575) ; partially factored (D_part):", n_partial, "(paper: 506) ; genuine f1 mismatches:", n_badf1, " blocker-flag inconsistencies:", bad_flag, " not Master-Hit:", n_notmaster, " f1 square (perfect!):", n_perfect)
print("Verification 4.2 (exponent-one blocker outside P): holds for", n_ok, " fails for", n_fail)
print("records with no blocker at all (f1 square):", noblocker_at_all)
print("num_blockers distribution (first 8):", sorted(num_blockers.items())[:8], " single-blocker records:", num_blockers[1], "(paper: 272)")
print("records with v_5(f1) = 1:", five_e1, "(paper: 0)")
print("smallest outside-P odd-exponent prime has exponent >= 3:", smallest_ge3, "(paper: 242)")
print("largest outside-P prime has even exponent:", largest_even, "(paper: 3)")
tot = sum(kdist.values()); print("all-blockers-exponent-1 records:", tot, "(paper: 136,674); k distribution top:", sorted(kdist.items(), key=lambda t: -t[1])[:8], " k=1 fraction:", kdist[1]/tot if tot else None)
for f in fails[:10]: print("  FAIL:", f)
