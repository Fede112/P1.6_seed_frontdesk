#!/bin/bash

data=all_data.dat

X=$1
Y=$2
S=2
NP=8

exe=


send_job(){

XY=${X}x${Y}

fin=${XY}_${S}.in
fout=./striped${S}/${XY}_${S}.data



cat <<EOF > $fin
&dimparam
  gnx = ${X},
  gny = ${Y},
  outfname = '${fout}',
/
EOF

cat <<EOF >job.sh
#!/bin/bash

#PBS -l nodes=1:ppn=24,walltime=3600
#PBS -N binchmark
#PBS -S /bin/bash
#PBS -q mhpc

cd \$PBS_O_WORKDIR

module load netcdf-fortran-parallel/4.4.4/netcdf-parallel/4.6.2/hdf5-parallel/1.8.21/openmpi/3.1.2/gnu/7.2.0

execute(){
	T=\$(mpirun -np $NP ./\$1 \$2 | grep time | awk '{printf \$(NF-1)}') \
	&& echo "\$1 $X $Y $S \$T" >> $data
}

execute allwrite $fin
sleep 1
execute allread $fout
sleep 10
execute collect_and_write $fin
sleep 1
execute read_distribute $fout

EOF

qsub job.sh

}

X=50000
Y=80000

S=2
send_job

S=4
send_job

S=1
send_job


S=1
for (( X = 40000; X<=50000 ; X = X + 10000  ))
do
	Y=80000
	send_job
done


