#!/usr/bin/env python3
"""Item 4(d): faces excluded only under the displayed reading of EF3/EF4.
Reads the requester's probe (p q R1 R2 R3text R3disp R4disp ex_text ex_disp) and this
directory's five-factor upper bounds, and reports the overlap."""
par="/workspaces/perfect-cuboid-playground/scratch/dgh-probe/04-ef-ranks-corrected-p100.out"
mine={}
for line in open("02-five-factors-p100.out"):
    f=line.split(); mine[(int(f[0]),int(f[1]))]=[int(f[2+i]) for i in range(5)]
rows=[]
for line in open(par):
    if "Warning" in line: continue
    f=line.split()
    rows.append(tuple(int(f[i]) for i in range(9)))
print("requester's probe rows:",len(rows))
ex_text=sum(1 for r in rows if r[7]); ex_disp=sum(1 for r in rows if r[8])
print("  excluded by the requester's 'text' criterion  (EF1|EF2|EF3):  %d (%.2f%%)"%(ex_text,100*ex_text/len(rows)))
print("  excluded by dGGH as displayed (EF1|EF2|(EF3d&EF4d))        :  %d (%.2f%%)"%(ex_disp,100*ex_disp/len(rows)))
only_disp=[r for r in rows if r[8]==1 and r[7]==0]
print("\nfaces excluded ONLY under the displayed reading (col9=1, col8=0): %d"%len(only_disp))
names=["EF1","EF2","EF3","EF4","P+"]
still=0; byfac={n:0 for n in names}; notexcl=[]
for r in only_disp:
    U=mine[(r[0],r[1])]
    if any(u==0 for u in U):
        still+=1
        for i in range(5):
            if U[i]==0: byfac[names[i]]+=1
    else: notexcl.append(((r[0],r[1]),U))
print("  of these, still excluded by rank 0 of one of the five true factors: %d (%.2f%%)"%(still,100*still/len(only_disp)))
print("  factor doing the work:",byfac)
print("  NOT excluded by any of the five factors: %d"%len(notexcl))
for t in notexcl: print("   ",t)
only_text=[r for r in rows if r[7]==1 and r[8]==0]
print("\nfaces excluded ONLY under the requester's text criterion: %d"%len(only_text))
corr=sum(1 for k in mine if any(u==0 for u in mine[k][:4]))
print("\nsummary over the 2040 faces:")
print("  displayed-reading criterion : %d (%.2f%%)"%(ex_disp,100*ex_disp/2040))
lit=sum(1 for k in mine if mine[k][0]==0 or mine[k][1]==0 or (mine[k][2]==0 and mine[k][3]==0))
print("  text-reading, dGGH Thm 1 literally (both EF3 and EF4): %d (%.2f%%)"%(lit,100*lit/2040))
print("  text-reading, either EF3 or EF4 : %d (%.2f%%)"%(corr,100*corr/2040))
