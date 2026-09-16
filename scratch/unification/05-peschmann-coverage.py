#!/usr/bin/env python3
"""Item 3: cross Peschmann's 1,072 proven fibres against the five-factor rank data."""
import csv, collections
CSV = "/workspaces/perfect-cuboid-playground/scratch/peschmann-review/repo/paper3_data_proven_fibers.csv"
DATA = "02-five-factors-p100.out"

proven = set(); quot = collections.Counter()
with open(CSV) as fh:
    for r in csv.DictReader(fh):
        proven.add((int(r["m"]), int(r["n"]))); quot[r["quotient"]] += 1
print("Peschmann proven fibres in the CSV:", len(proven), " by quotient:", dict(quot))

rows = {}
for line in open(DATA):
    f = line.split()
    rows[(int(f[0]), int(f[1]))] = [int(f[2+i]) for i in range(5)]
print("fibres with five-factor data (p<=100):", len(rows))
print("proven fibres inside the p<=100 grid:", len(proven & set(rows)))
print("proven fibres outside the grid:", sorted(proven - set(rows))[:10])

names = ["EF1", "EF2", "EF3", "EF4", "F2"]
def klass(U):
    if any(u == 0 for u in U): return "A"
    if any(u < 0 for u in U): return "D"
    return "B" if sum(U) <= 4 else "C"

unproven = sorted(set(rows) - proven)
print("\n=== fibres NOT covered by Peschmann's 1,072:", len(unproven), "===")
c = collections.Counter(klass(rows[k]) for k in unproven)
for k in "ABCD": print("   class %s : %4d (%6.2f%%)" % (k, c[k], 100.0*c[k]/len(unproven)))
ch = [k for k in unproven if all(u >= 0 for u in rows[k]) and sum(rows[k]) <= 4]
print("   sum of the five upper bounds <= 4 (genus-5 linear Chabauty certified): %4d (%6.2f%%)"
      % (len(ch), 100.0*len(ch)/len(unproven)))
for i in range(5):
    k = sum(1 for key in unproven if rows[key][i] == 0)
    print("   %s rank 0 : %4d (%6.2f%%)" % (names[i], k, 100.0*k/len(unproven)))

print("\n=== cross-tab: Peschmann covered vs not, by class ===")
for label, keys in (("Peschmann proven", sorted(proven & set(rows))), ("not proven", unproven)):
    c = collections.Counter(klass(rows[k]) for k in keys)
    print("   %-18s n=%4d  A=%4d B=%d C=%4d D=%d" % (label, len(keys), c["A"], c["B"], c["C"], c["D"]))

print("\n=== consistency: does Peschmann's quotient really have upper bound 0 in my data? ===")
bad = []
with open(CSV) as fh:
    for r in csv.DictReader(fh):
        k = (int(r["m"]), int(r["n"]))
        if k not in rows: continue
        q = r["quotient"]
        # E_3 ~ EF4 (index 3); E_uV ~ EF2 (index 1)
        idx = {"E_3": 3, "E_uV": 1}.get(q)
        if idx is None: bad.append((k, q, "unknown quotient")); continue
        if rows[k][idx] != 0: bad.append((k, q, rows[k]))
print("   mismatches:", len(bad)); print("  ", bad[:10])

print("\n=== the hard fibre (5,2) ===")
print("   five upper bounds [EF1,EF2,EF3,EF4,F2] =", rows[(5,2)], " sum =", sum(rows[(5,2)]))
print("\n=== all fibres with sum of upper bounds <= 3 (p<=100) ===")
tiny = sorted([k for k in rows if all(u>=0 for u in rows[k]) and sum(rows[k]) <= 3], key=lambda k:(sum(rows[k]),k))
print("   count:", len(tiny))
for k in tiny[:25]: print("     ", k, rows[k], "sum", sum(rows[k]), "Peschmann-proven" if k in proven else "NOT proven")
