## Netcdf benchmark.

The performance of the Netcdf library for Fortran has been
benchmarked in the lustre filesystem of the C3E cluster.

The benchmark consists of the execution of 4 fortran codes 
each one spanning 8 MPI processes.
Two of the aforementioned codes, 'collect_and_write.F90' and 'read_distribute.F90', 
perform write and read operations using the spokesperson approach.
While the other two, 'allwrite.F90' and 'allread.F90', perform 
those operations in parallel using the syntactic ease of Netcdf.
The results of the benchmark are show in pictures 'netcdf_1.png' and 'netcdf_2.png'.

'netcdf_1.png': Shows the bandwidth obtained for the four codes at different global data sizes.

'netcdf_2.png': Shows the bandwidth obtained for the four codes for a fized global data size
and while stripping the target file in 1, 2 and 4 pieces.

In both cases the 'allread', reaching bandwidths of the order of 10 GB/s, outperforms
the physical capabilities of the OST servers, which for a stripping factor of 1
cannot exceed 400 MB/s. The explanation to this behaviour is that the targed data,
once written into disk it remains cached in RAM and after the consecutive read request
it is read from the latter faster device.

On the other hand, writing bandwidths seem to be legitimate.
These show that without the stripping factor, the 'allwrite' program is outperformed by
'collect_and_write', possibly due to overhead of the different software layers from 
which Netcdf is made off. This fact persists in spite of 
the spokesperson approach's bandwidth remaining almost constant independent of the data size,
while the parallel writting ('allwrite') gains significant performance for 10 GB 
data sizes. For striped files, the situation is reversed: having parallel writting
perfoming slightly better than 'collect_and_write'.
