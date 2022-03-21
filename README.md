# 19th Student Colloquium CS 2021-2022

The code in this work is used to write the Paper "GPU-Accelerated Frequent Itemset Mining: An In-depth Evaluation of GMiner". 

This repository contains a number of scripts that can be used to replicate our work, or evaluate algorithms using different parameters.
Note that this work was only ever ran on the [Peregrine HPC cluster](https://www.rug.nl/society-business/centre-for-information-technology/research/services/hpc/facilities/peregrine-hpc-cluster), for which no assurances are made that it works on any other device.

## Repository Contents
The ``results`` folder contains all results of our experiments. 
These were generated in a number of different experiment runs, for which they are put in different folders. 
Each ``.out`` file contains the following information: general data set information, repetition output, dataset pattern information, and some basic dataset statistics.

The ``src`` folder contains all scripts used in this experiment.

The ``repositories`` folder is generated after downloading the third-party repositories, and contains data of those repositories. 

The ``datasets`` folder contains all generated datasets.

## Using the repository
In order to replicate our results, do the following.
Note, all commands are expected to be executed in the repository's root.

1) As our solution depends on a number of external codebases, these have to be downloaded. 
You can do this by running ``./src/download_repos.sh``. 
2) To run the experiment, run ``./src/run_experiment.sh``. 

In case you want to run the experiment with different parameters, these have to be changed in the ``./src/run_experiment.sh`` itself.
Note that this experiment is by no means fast, so expect to wait for a period of time before results are generated.
