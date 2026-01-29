# PyMOL SASA Analysis

This repository contains a PyMOL script for **Solvent Accessible Surface Area (SASA) **analysis of protein structures.

### Scientific Background

The Solvent Accessible Surface Area (SASA) is a fundamental structural descriptor
in protein biophysics, representing the surface of a biomolecule that is accessible
to solvent molecules. SASA is widely used to infer protein stability, residue exposure,
and molecular interactions.

In the context of protein–protein and protein–ligand interactions, changes in SASA
(ΔSASA) upon complex formation are commonly used to quantify interface regions,
as buried surface area is directly correlated with binding affinity and interaction
specificity.

## Features
- Total SASA calculation
- SASA per residue (CSV output)
- Interface ΔSASA for protein complexes

## Requirements
- PyMOL 2.x

## Usage
```pml
run sasa_analysis.pml
sasa_total myprotein
sasa_per_residue myprotein, chain A, out=sasa_chainA.csv
sasa_interface mycomplex, chain A, chain B
```

## Parameters
- dot_density = 4
- solvent_radius = 1.4 Å

## Author
Barbara Barbosa
