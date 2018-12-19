#!/bin/bash

DATA=/home/lbonaldo/Documents/SISSA/Corsi/6.SDM/P1.6_seed_frontdesk/ior/data/np48_blocksize3GiB

OUTPUT=/home/lbonaldo/Documents/SISSA/Corsi/6.SDM/P1.6_seed_frontdesk/ior/analysis/np48_blocksize3GiB

touch $OUTPUT/write_plot.txt
echo "#POSIX HDF5 MPIIO NCMPI" >> $OUTPUT/write_plot.txt
for filesystem in lustre NFS;do
    awk '/Summary of all tests/ {for(i=1; i<=2; i++) {getline} print $4}' $DATA/${filesystem}_output_np48_3g.raw | tr '\n' ' ' | awk 'END{print}' | sed 's/ *$//' >> $OUTPUT/write_plot.txt
done
