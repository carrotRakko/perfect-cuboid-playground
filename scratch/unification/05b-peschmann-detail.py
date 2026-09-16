#!/usr/bin/env python3
"""Detail for item 3(c): Peschmann's CSV rows versus the five-factor 2-descent bounds."""
import csv, collections
CSV="/workspaces/perfect-cuboid-playground/scratch/peschmann-review/repo/paper3_data_proven_fibers.csv"
rows={}
for line in open("02-five-factors-p100.out"):
    f=line.split(); rows[(int(f[0]),int(f[1]))]=[int(f[2+i]) for i in range(5)]
recs=list(csv.DictReader(open(CSV)))
print("rank_resolution values:", dict(collections.Counter(r["rank_resolution"] for r in recs)))
mis=[]; ok=collections.Counter()
for r in recs:
    k=(int(r["m"]),int(r["n"])); idx={"E_3":3,"E_uV":1}[r["quotient"]]
    if rows[k][idx]==0: ok[(r["quotient"],r["rank_resolution"])]+=1
    else: mis.append((k,r["quotient"],r["rank_resolution"],rows[k]))
print("agreeing:",dict(ok))
print("rows where 2-descent on the dGGH model does NOT give 0:",len(mis),
      "by resolution:",dict(collections.Counter(m[2] for m in mis)),
      "by quotient:",dict(collections.Counter((m[1],m[2]) for m in mis)))
proven=set((int(r["m"]),int(r["n"])) for r in recs)
u2=set(k for k in rows if rows[k][1]==0); u4=set(k for k in rows if rows[k][3]==0)
print("|EF2 ub=0| =",len(u2)," |EF4 ub=0| =",len(u4)," |union| =",len(u2|u4))
print("union minus proven:",len((u2|u4)-proven)," proven minus union:",len(proven-(u2|u4)),
      " |union U proven| =",len(u2|u4|proven))
extra=sorted((u2|u4)-proven)
print("by factor: EF2-only",len([k for k in extra if rows[k][1]==0 and rows[k][3]!=0]),
      " EF4-only",len([k for k in extra if rows[k][3]==0 and rows[k][1]!=0]),
      " both",len([k for k in extra if rows[k][1]==0 and rows[k][3]==0]))
print("first 12:",[(k,rows[k]) for k in extra[:12]])
