#!/bin/bash

##Directivas
##SBATCH --partition=guane_24_cores
##SBATCH --ntasks=2
##SBATCH --gres=gpu:1
#SBATCH --job-name=suma
##SBATCH --time=01:00:00
##SBATCH --nodes=2
##SBATCH --mem=23000
##SBATCH --ntasks-per-node=24
#SBATCH --output=output_summaSimple.txt
#SBATCH --error=output_summaSimple.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alvarojvillamizar@gmail.com

## Modulos de ambiente

module load devtools/gcc/8.3.0

## Ejecucion

gcc -fopenmp omp_summaSimple.c -lm -o omp_summaSimple
./omp_summaSimple  
