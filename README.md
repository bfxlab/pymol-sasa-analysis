# PyMOL SASA Analysis

This repository contains a PyMOL script for **Solvent Accessible Surface Area (SASA)** analysis of protein structures.

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
Barbara Silva Barbosa
