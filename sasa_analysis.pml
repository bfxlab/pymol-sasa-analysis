#####################################################################
# PyMOL SASA analysis script
# Author: Barbara Silva Barbosa
#
# Script for Solvent Accessible Surface Area (SASA) analysis
# Compatible with PyMOL 2.x
#####################################################################

set dot_density, 4
set solvent_radius, 1.4
set solvent, on
set cartoon_sampling, 10

python
from pymol import cmd

def _assert_object(obj):
    if not cmd.count_atoms(obj):
        raise ValueError(f"[SASA] Object or selection not found: {obj}")
python end

python
def sasa_total(obj, sele="polymer.protein", state=1):
    _assert_object(obj)
    area = cmd.get_area(f"({obj}) and ({sele})", state=state)
    print(f"[SASA] Total SASA: {area:.2f} Å^2")
    return area
cmd.extend("sasa_total", sasa_total)
python end

python
def sasa_per_residue(obj, sele="polymer.protein", state=1, out="sasa_per_residue.csv"):
    _assert_object(obj)
    sel = f"({obj}) and ({sele})"
    cmd.get_area(sel, state=state, load_b=1)

    stored = {}
    cmd.iterate(sel, "stored.setdefault((chain,resi,resn),0); stored[(chain,resi,resn)] += b", space={'stored': stored})

    import csv
    with open(out, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["chain","resi","resn","SASA_A2"])
        for (c,r,n),v in stored.items():
            w.writerow([c,r,n,f"{v:.3f}"])

    print(f"[SASA] Per-residue SASA written to {out}")
cmd.extend("sasa_per_residue", sasa_per_residue)
python end

python
def sasa_interface(obj, partA="chain A", partB="chain B", state=1, out="interface_dSASA.csv"):
    _assert_object(obj)
    A = f"({obj}) and ({partA})"
    B = f"({obj}) and ({partB})"

    sasaA_bound = cmd.get_area(A, state=state)
    sasaB_bound = cmd.get_area(B, state=state)

    cmd.create("__tmpA__", A, state=state)
    cmd.create("__tmpB__", B, state=state)

    sasaA_un = cmd.get_area("__tmpA__")
    sasaB_un = cmd.get_area("__tmpB__")

    dA = sasaA_un - sasaA_bound
    dB = sasaB_un - sasaB_bound

    import csv
    with open(out, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["Partner","SASA_bound","SASA_unbound","dSASA"])
        w.writerow(["A",sasaA_bound,sasaA_un,dA])
        w.writerow(["B",sasaB_bound,sasaB_un,dB])
        w.writerow(["TOTAL","","",dA+dB])

    cmd.delete("__tmpA__")
    cmd.delete("__tmpB__")

    print(f"[SASA] Interface ΔSASA written to {out}")
cmd.extend("sasa_interface", sasa_interface)
python end
