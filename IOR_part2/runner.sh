#!/bin/bash
#PBS -N IOR_stripes 
#PBS -l walltime=12:00:00
#PBS -l nodes=2:ppn=24
#PBS -q mhpc

# Load modules
module purge
module load netcdf-fortran-parallel/4.4.4/netcdf-parallel/4.6.2/pnetcdf/1.10.0/hdf5-parallel/1.8.21/openmpi/3.1.2/gnu/7.2.0

cd ${PBS_O_WORKDIR}

# Path to binary to execute
IOR=~/software/ior/3.2.0rc1/bin/ior

# Number of processors
nproc=48
path=/lustre/MHPC18/jespinoz 
fs=lustre
SIZE=1g

RESULTS=/u/MHPC18/jespinoz/P6_Ex/results

for stripe in 1 2 4; do 
        for api in POSIX HDF5 MPIIO NCMPI;do
		mkdir -p ${path}/${stripe}
		lfs setstripe -c ${stripe} -i 0 ${path}/${stripe}/
                 
                $(which mpirun) -np ${nproc} ${IOR} \
                -s 1 -d 5 -w -r -i 1 -e -t ${SIZE} -b ${SIZE} -vv -k -B -a  \
                ${api} -o ${path}/${stripe}/testfile.tmp \
                1> ${RESULTS}/${stripe}_${api}_output.raw
        done
done
