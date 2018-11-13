#!/bin/bash
srun -n 1 -N 1 --cpus-per-task 20 --cpu_bind none --partition aaiken --time 120:00:00 --pty bash
#srun --gres gpu:1 -n 1 -N 1 --cpus-per-task 20 --cpu_bind none --partition aaiken --time 02:00:00 --pty bash
