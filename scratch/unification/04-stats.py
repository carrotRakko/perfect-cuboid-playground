#!/usr/bin/env python3
"""Aggregate 02-five-factors-p100.out (columns: p q U1 U2 U3 U4 U5 class zeros sec)."""
import sys, collections
fn = sys.argv[1] if len(sys.argv) > 1 else "02-five-factors-p100.out"
rows = []
for line in open(fn):
    f = line.split()
    if len(f) < 9: continue
    p, q = int(f[0]), int(f[1])
    U = [int(f[2+i]) for i in range(5)]
    rows.append((p, q, U, f[7], f[8]))
N = len(rows)
print("file =", fn, " fibres =", N)

def cls(U):
    if any(u < 0 for u in U): 
        return "D" if not any(u == 0 for u in U) else "A"
    if any(u == 0 for u in U): return "A"
    return "B" if sum(U) <= 4 else "C"

cnt = collections.Counter(cls(U) for _, _, U, _, _ in rows)
print("\n--- requester's classes (A = some factor ub 0; B = no zero and sum<=4; C = sum>=5; D = timeout) ---")
for k in "ABCD":
    print("  %s : %5d  (%6.2f%%)" % (k, cnt[k], 100.0*cnt[k]/N))

ch  = [r for r in rows if all(u >= 0 for u in r[2]) and sum(r[2]) <= 4]
a0  = [r for r in rows if any(u == 0 for u in r[2])]
print("\n--- refined ---")
print("  A0  some factor has certified rank 0 (dGGH-style exclusion) : %5d (%6.2f%%)" % (len(a0), 100.0*len(a0)/N))
print("  CH  sum of the five 2-descent upper bounds <= 4             : %5d (%6.2f%%)" % (len(ch), 100.0*len(ch)/N))
print("  CH is a subset of A0 :", all(any(u == 0 for u in r[2]) for r in ch))
print("  fibres in A0 but NOT CH (rank-0 excluded, Chabauty bound fails) : %5d (%6.2f%%)" % (len(a0)-len(ch), 100.0*(len(a0)-len(ch))/N))

print("\n--- which factor certifies rank 0 (A0 fibres; a fibre can appear in several rows) ---")
names = ["EF1 = x(x+a2)(x+b2)", "EF2 = x(x+a4)(x+b4)", "EF3 = x(x+a2)(x+d2)",
         "EF4 = x(x+b2)(x+d2)", "F2  = x(x-a2)(x-b2)"]
for i in range(5):
    k = sum(1 for _, _, U, _, _ in rows if U[i] == 0)
    print("   %-22s rank 0 on %5d fibres (%6.2f%%)" % (names[i], k, 100.0*k/N))
only = collections.Counter()
for _, _, U, _, _ in rows:
    z = [i for i in range(5) if U[i] == 0]
    if len(z) == 1: only[z[0]] += 1
print("  fibres where exactly one factor is certified rank 0, by factor:",
      {names[i].split()[0]: only[i] for i in sorted(only)})

print("\n--- dGGH Theorem 1 as literally stated (EF1 or EF2 rank 0, or BOTH EF3 and EF4 rank 0) ---")
dggh = sum(1 for _,_,U,_,_ in rows if U[0]==0 or U[1]==0 or (U[2]==0 and U[3]==0))
print("   excluded: %5d (%6.2f%%)" % (dggh, 100.0*dggh/N))
print("--- the same with 'EF3 or EF4' (what the genus-5 picture gives) ---")
dggh2 = sum(1 for _,_,U,_,_ in rows if U[0]==0 or U[1]==0 or U[2]==0 or U[3]==0)
print("   excluded: %5d (%6.2f%%)" % (dggh2, 100.0*dggh2/N))
print("--- adding the fifth factor F2 (all five) ---")
print("   excluded: %5d (%6.2f%%)" % (len(a0), 100.0*len(a0)/N))

print("\n--- by band of p (25 wide) ---")
print("  band        n    A0 %     CH %   EF1=0 %  EF2=0 %  EF3=0 %  EF4=0 %   F2=0 %   mean sum(ub)")
for lo in range(0, 200, 25):
    hi = lo + 25
    sub = [r for r in rows if lo < r[0] <= hi]
    if not sub: continue
    n = len(sub)
    a = sum(1 for r in sub if any(u == 0 for u in r[2]))
    c = sum(1 for r in sub if all(u >= 0 for u in r[2]) and sum(r[2]) <= 4)
    zz = [100.0*sum(1 for r in sub if r[2][i] == 0)/n for i in range(5)]
    ms = sum(sum(r[2]) for r in sub)/n
    print("  %3d-%-3d %5d  %6.2f  %6.2f    %6.2f  %6.2f  %6.2f  %6.2f  %6.2f   %6.3f"
          % (lo+1, hi, n, 100.0*a/n, 100.0*c/n, zz[0], zz[1], zz[2], zz[3], zz[4], ms))

print("\n--- distribution of sum of the five upper bounds ---")
ds = collections.Counter(sum(r[2]) for r in rows if all(u >= 0 for u in r[2]))
for k in sorted(ds): print("   sum = %2d : %5d (%6.2f%%)" % (k, ds[k], 100.0*ds[k]/N))

print("\n--- distribution per factor of the upper bound ---")
for i in range(5):
    dd = collections.Counter(r[2][i] for r in rows)
    print("   %-22s %s" % (names[i], dict(sorted(dd.items()))))
