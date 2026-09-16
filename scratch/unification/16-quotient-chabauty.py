#!/usr/bin/env python3
"""Item 6: how often does Chabauty apply on X_s or on one of its quotients?
J(X_s) ~ EF1 x EF2 x EF3 x EF4 x P+  (indices 0..4).
Genus-3 hyperelliptic quotients X_s/<sigma_i sigma_j> have Jacobian Q x P+ x EF2 with
Q = EF1 (over the Hsum conic, Peschmann's C_A), EF3 (over the Master conic), EF4 (over the Rat conic,
Peschmann's H_{m,n}).  Chabauty needs rk Q + rk P+ + rk EF2 <= 2, and rk P+ >= 1 always."""
import collections
def load_ub(fn):
    R={}
    for line in open(fn):
        f=line.split(); R[(int(f[0]),int(f[1]))]=[int(f[2+i]) for i in range(5)]
    return R
for fn,tag in (("02-five-factors-p100.out","p<=100"),("03-five-factors-p200.ub.out","p<=200")):
    R=load_ub(fn); N=len(R)
    print("=== %s  (%d faces) ==="%(tag,N))
    c=sum(1 for k in R if sum(R[k])<=4)
    print("  genus-5 X_s, linear Chabauty  (sum of five bounds <= 4)          : %5d (%6.2f%%)"%(c,100*c/N))
    for idx,name,quot in ((0,"EF1","C_A  (over the Hsum conic)"),(2,"EF3","(over the Master conic)"),(3,"EF4","H_{m,n} (over the Rat conic)")):
        c=sum(1 for k in R if R[k][idx]+R[k][4]+R[k][1] <= 2)
        print("  genus-3 %-28s rk %s + rk P+ + rk EF2 <= 2 : %5d (%6.2f%%)"%(quot,name,c,100*c/N))
    anyq=sum(1 for k in R if min(R[k][0],R[k][2],R[k][3])+R[k][4]+R[k][1] <= 2)
    print("  some genus-3 quotient works                                       : %5d (%6.2f%%)"%(anyq,100*anyq/N))
    a0=sum(1 for k in R if any(u==0 for u in R[k]))
    print("  elementary: some factor certified rank 0                          : %5d (%6.2f%%)"%(a0,100*a0/N))
    g2=sum(1 for k in R if R[k][1]==0 and R[k][4]==1)
    print("  genus-2 quotient (Jac = P+ x EF2), rk <= 1                        : %5d (%6.2f%%)"%(g2,100*g2/N))
    print()
rows={}
for line in open("03-five-factors-p200.out"):
    f=line.split(); rows[(int(f[0]),int(f[1]))]=[(int(f[2+2*i]),int(f[3+2*i])) for i in range(5)]
N=len(rows)
allone=[k for k in rows if all(l==u==1 for l,u in rows[k])]
print("=== p<=200: faces where all five ranks are PROVED to be exactly 1 (rk J(X_s) = 5 exactly) ===")
print("   count: %d (%.2f%%)"%(len(allone),100*len(allone)/N))
print("   smallest:",sorted(allone)[:10])
sharp=[k for k in rows if all(l==u for l,u in rows[k])]
print("\n=== all five ranks determined exactly by 2-descent: %d (%.2f%%) ==="%(len(sharp),100*len(sharp)/N))
print("   of those, rk J >= 5: %d (%.2f%%)"%(sum(1 for k in sharp if sum(u for l,u in rows[k])>=5),
      100*sum(1 for k in sharp if sum(u for l,u in rows[k])>=5)/N))
print("   of those, rk J <= 4: %d (%.2f%%)"%(sum(1 for k in sharp if sum(u for l,u in rows[k])<=4),
      100*sum(1 for k in sharp if sum(u for l,u in rows[k])<=4)/N))
print("   exact rk J distribution over those faces:",dict(sorted(collections.Counter(sum(u for l,u in rows[k]) for k in sharp).items())))
