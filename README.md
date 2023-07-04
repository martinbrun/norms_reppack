# Replication of Brouwer et al (2023): "Teaching Norms: Direct Evidence of Parental Transmission" 
- Martín Brun
- Micole De Vera  
- Valon Kadiru
- Fabian Mierisch

This replication was undertaken as part of the "Vienna Replication Games", organized by the Institute for Replication.

## Licensing

The original replication package contain all necessary data for replication. We have decided to not redistribute any of the original code or data. 

Our code analyzes the author's original data. Each replicator should download the zip-file with data and code from the Zenodo repository (Brouwer et al, 2022). 

The code we distribute are licensed with a CC0 1.0 Universal License (enclosed as part of Brun et al, 2023 replication package). 

## Replication computer environment and running time

The replication results were calculated using the following computer and software:

- Intel Core i5-8250U CPU, 8GB RAM.
- Windows 11 Home, Version 22H2.
- Stata SE version 18, with eststo 1.1.0; esttab 2.1.1 packages.
- R 4.2.2, with dplyr 1.0.10; miceadds 3.16-18; tidyverse 2.0.0; texreg 1.38.6 packages.
  
The main script runs all analysis in less than 1 minute.

## Description of programs/code

| Program | Fig./Tab. | Output file | Note |
| :--- | :--- | :--- | :--- |
| 00.runner.do | - | - | Runs all code for Tables and Figures |
| Table1.do | Table 1 | Table1.tex | - |
| Table2.do | Table 2  | Table2.tex | - |
| Table2.R | Table 2 | Table2.tex | - |
| Figure1a.do | Figure 1a | Table1.tex | - |
| Figure1b.do | Figure 1b | Table1.tex | - |
| TableA2.do | Table A2 | TableA2.tex | - |
| TableA3.do | Table A3 | TableA3.tex | - |
| TableA4.do | Table A4 | TableA4.tex | - |
| TableA5.do | Table A5 | TableA5.tex | - |
| TableA6.do | Table A6 | TableA6X.tex | Produces multiple tables. Main table named 'TableA6.tex' |
| TableA7.do | Table A7 | TableA7X.tex | Produces multiple tables. Main table named 'TableA7.tex' |
| TableA8.do | Table A8 | TableA8X.tex | Produces multiple tables. Main table named 'TableA8.tex' |
| TableA9.do | Table A9 | TableA9X.tex | Produces multiple tables. Main table named 'TableA9.tex' |
| TableA10.do | Table A10 | TableA10X.tex | Produces multiple tables. Main table named 'TableA10.tex' |

## Instructions for replicators

1. Install all software requirements detailed in the README file

2. Download the replication package zip-file and unzip it.

3. Download Brouwer et al (2022) replication package listed in the references. Copy the contents of the 'Data' folder, located in '3 replication package', to the 'data' directory.

4. Change the path for the 'PATH' global in line 6 of '00.runner.do'. Change the path of the working directory in line 11 of 'Table2.R'

5. Run '00.runner.do'

## References

- Brouwer, T., Galeotti, F., & Villeval, M. C. (2022). Teaching Norms: Direct Evidence of Parental Transmission - Replication package. The Economic Journal. doi.org/10.5281/zenodo.7045559
- Brouwer, T., Galeotti, F., & Villeval, M. C. (2023). Teaching Norms: Direct Evidence of Parental Transmission. The Economic Journal, 133(650): 872-887. doi.org/10.1093/ej/ueac074