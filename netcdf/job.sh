#!/bin/bash

#PBS -l nodes=1:ppn=24,walltime=3600
#PBS -N binchmark
#PBS -S /bin/bash
#PBS -q mhpc

cd $PBS_O_WORKDIR

module load netcdf-fortran-parallel/4.4.4/netcdf-parallel/4.6.2/hdf5-parallel/1.8.21/openmpi/3.1.2/gnu/7.2.0

execute(){
	T=$(mpirun -np 8 ./$1 $2 | grep time | awk '{printf $(NF-1)}') 	&& echo "$1 50000 80000 1 $T" >> all_data.dat
}

execute allwrite 50000x80000_1.in
sleep 1
execute allread ./striped1/50000x80000_1.data
sleep 10
execute collect_and_write 50000x80000_1.in
sleep 1
execute read_distribute ./striped1/50000x80000_1.data

