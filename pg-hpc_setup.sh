#!/bin/sh

# Enable CUDA
module load CUDA/10.2.89-GCC-8.3.0
srun --gres=gpu:1 --partition=gpushort --time=01:00:00 --pty /bin/bash


