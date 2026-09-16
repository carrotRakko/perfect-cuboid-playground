#!/usr/bin/env python3
"""Zero-set breakdown of Peschmann's 968 uncovered fibres."""
import csv, collections
CSV="/workspaces/perfect-cuboid-playground/scratch/peschmann-review/repo/paper3_data_proven_fibers.csv"
rows={}
for line in open("02-five-factors-p100.out"):
    f=line.split(); rows[(int(f[0]),int(f[1]))]=[int(f[2+i]) for i in range(5)]
proven=set((int(r["m"]),int(r["n"])) for r in csv.DictReader(open(CSV)))
un=sorted(set(rows)-proven); names=["EF1","EF2","EF3","EF4","P+"]
print("unproven fibres:",len(un))
pat=collections.Counter(tuple(names[i] for i in range(5) if rows[k][i]==0) for k in un)
for z,c in sorted(pat.items(), key=lambda t:-t[1]):
    print("   zero-set %-22s : %4d" % (",".join(z) if z else "(none)", c))
a0=[k for k in un if any(u==0 for u in rows[k])]; ch=[k for k in un if sum(rows[k])<=4]
print("A0 : %d (%.2f%%)   CH : %d (%.2f%%)   CH subset of A0 : %s"%(
    len(a0),100*len(a0)/len(un),len(ch),100*len(ch)/len(un),set(ch)<=set(a0)))
print("excluded ONLY by EF1 or EF3:",len([k for k in un if (rows[k][0]==0 or rows[k][2]==0) and rows[k][1]!=0 and rows[k][3]!=0]))
print("excluded ONLY by EF2:",len([k for k in un if rows[k][1]==0 and rows[k][0]!=0 and rows[k][2]!=0 and rows[k][3]!=0]))
rest=[k for k in un if not any(u==0 for u in rows[k])]
print("still unexcluded:",len(rest)," bound sums:",dict(sorted(collections.Counter(sum(rows[k]) for k in rest).items())))
print("smallest-sum examples:",sorted(rest,key=lambda k:(sum(rows[k]),k))[:12])
allrest=[k for k in rows if not any(u==0 for u in rows[k])]
print("whole grid, no factor of certified rank 0:",len(allrest),"(%.2f%%)"%(100*len(allrest)/len(rows)),
      "; of those, Peschmann-proven:",len(set(allrest)&proven))
