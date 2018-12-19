#!/bin/bash

touch write_plot.txt
echo "#POSIX HDF5 MPIIO NCMPI" >> write_plot.txt
for filesystem in lustre NFS local;do
    awk '/Summary of all tests/ {for(i=1; i<=2; i++) {getline} print $4}' ${filesystem}_output.raw | tr '\n' ' ' | awk 'END{print}' | sed 's/ *$//' >> write_plot.txt
done

#touch write_plot.ipynb
#sleep 2
#jupyter-notebook write_plot.ipynb
