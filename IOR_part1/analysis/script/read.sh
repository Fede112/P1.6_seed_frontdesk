#!/bin/bash

FOLDER=$1

DATA=/home/lbonaldo/Documents/SISSA/Corsi/6.SDM/P1.6_seed_frontdesk/ior/data/$1

OUTPUT=/home/lbonaldo/Documents/SISSA/Corsi/6.SDM/P1.6_seed_frontdesk/ior/analysis/$1

touch $OUTPUT/read_plot.txt
echo "#POSIX HDF5 MPIIO NCMPI" >> $OUTPUT/read_plot.txt
for filesystem in lustre NFS;do
    awk '/Summary of all tests/ {for(i=1; i<=3; i++) {getline} print $4}' $DATA/${filesystem}_output.raw | tr '\n' ' ' | awk 'END{print}' | sed 's/ *$//' >> $OUTPUT/read_plot.txt
done
