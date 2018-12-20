#!/bin/bash

#PBS -N IOR_stripes 
#PBS -l walltime=12:00:00
#PBS -l nodes=2:ppn=24
#PBS -q mhpc

# module purge
module load netcdf-fortran-parallel/4.4.4/netcdf-parallel/4.6.2/pnetcdf/1.10.0/hdf5-parallel/1.8.21/openmpi/3.1.2/gnu/7.2.0
module load openmpi/3.1.2/gnu/7.2.0
module load darshan/3.1.6/openmpi/3.1.2/gnu/7.2.0


cd $PBS_O_WORKDIR

export DARSHAN_LOG_DIR_PATH=$PBS_O_WORKDIR
export path=/lustre/MHPC18/jespinoz 
MPIRUN=$(which mpirun)
IOR=~/software/ior/3.2.0rc1/bin/ior

SIZE=3g

for api in POSIX HDF5 MPIIO; do
	mkdir -p ${DARSHAN_LOG_DIR_PATH}/${api}
	$MPIRUN -np 48 \
	-x LD_PRELOAD=$(echo $LD_LIBRARY_PATH |cut -d':' -f1)/libdarshan.so \
	-x ${DARSHAN_LOG_DIR_PATH}/ \
    ${IOR} -s 1 -a ${api} -wr -t 1m -b ${SIZE} -g -o ${path}/testfile.ior
    mv *.darshan ${DARSHAN_LOG_DIR_PATH}/${api}/ 
done

# RESULTS=/u/MHPC18/jespinoz/P6_Ex/results
