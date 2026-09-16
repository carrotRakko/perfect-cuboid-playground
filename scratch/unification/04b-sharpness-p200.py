#!/usr/bin/env python3
"""Sharpness of ellrank on the five factors, p <= 200, and the Chabauty inequality both ways."""
import collections
rows=[]
for line in open("03-five-factors-p200.out"):
    f=line.split(); rows.append((int(f[0]),int(f[1]),[(int(f[2+2*i]),int(f[3+2*i])) for i in range(5)]))
N=len(rows); names=["EF1","EF2","EF3","EF4","P+"]
print("fibres:",N)
print("\n--- sharpness of ellrank (lower == upper) per factor ---")
for i in range(5):
    sharp=sum(1 for _,_,LU in rows if LU[i][0]==LU[i][1])
    gap=collections.Counter(LU[i][1]-LU[i][0] for _,_,LU in rows)
    print("  %-4s sharp on %5d (%6.2f%%)   gap distribution %s" % (names[i],sharp,100*sharp/N,dict(sorted(gap.items()))))
print("  all five sharp: %d (%.2f%%)"%(sum(1 for _,_,LU in rows if all(l==u for l,u in LU)),
      100*sum(1 for _,_,LU in rows if all(l==u for l,u in LU))/N))
lo=[sum(l for l,u in LU) for _,_,LU in rows]; hi=[sum(u for l,u in LU) for _,_,LU in rows]
print("\n--- genus-5 Chabauty inequality, raw bounds ---")
print("  sum of UPPER <= 4 : %5d (%6.2f%%)"%(sum(1 for h in hi if h<=4),100*sum(1 for h in hi if h<=4)/N))
print("  sum of LOWER <= 4 : %5d (%6.2f%%)"%(sum(1 for l in lo if l<=4),100*sum(1 for l in lo if l<=4)/N))
print("  undecided band    : %5d (%6.2f%%)"%(sum(1 for l,h in zip(lo,hi) if l<=4<h),100*sum(1 for l,h in zip(lo,hi) if l<=4<h)/N))
print("  certified rk J >= 5 (raw lower bounds): %5d (%6.2f%%)"%(sum(1 for l in lo if l>=5),100*sum(1 for l in lo if l>=5)/N))
print("\n--- P+ lower-bound distribution (ellrank effort 0; the true value is >= 1 by section 1(f)) ---")
print("  ",dict(sorted(collections.Counter(LU[4][0] for _,_,LU in rows).items())))
lo2=[sum(l for l,u in LU[:4])+max(LU[4][0],1) for _,_,LU in rows]
print("\n--- same, using the PROVED lower bound rk P+ >= 1 ---")
print("  sum of corrected LOWER >= 5 (Chabauty provably unavailable): %5d (%6.2f%%)"%(sum(1 for l in lo2 if l>=5),100*sum(1 for l in lo2 if l>=5)/N))
print("  sum of corrected LOWER <= 4                                : %5d (%6.2f%%)"%(sum(1 for l in lo2 if l<=4),100*sum(1 for l in lo2 if l<=4)/N))
print("  undecided band (corrected lower <= 4 < upper)              : %5d (%6.2f%%)"%(sum(1 for l,h in zip(lo2,hi) if l<=4<h),100*sum(1 for l,h in zip(lo2,hi) if l<=4<h)/N))
print("  distribution of the corrected lower-bound sum:",dict(sorted(collections.Counter(lo2).items())))
