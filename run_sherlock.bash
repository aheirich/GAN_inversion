#!/bin/bash
#SBATCH --job-name=GAN_inversion
#SBATCH --time=16:00:00
#SBATCH --cpus-per-task=20
#SBATCH --partition aaiken
#SBATCH --mail-type=END

cd ~/GAN_inversion
ampl < run2.run > run2.log
ampl < run3.run > run3.log
ampl < run4.run > run4.log
ampl < run5.run > run5.log

