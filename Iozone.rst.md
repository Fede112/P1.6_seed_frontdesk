Iozone

 In this exercise we ran the ozone bench mark for both Ulysses and c3e. We measured the read and write bandwidth  of different sizes(8GB,64GB, 128GB, 150GB) on 4 OSTs.    We  go the expected results that reading  of 8GB file had high bandwidth because the values were buffered in the cache, of which  this doesn't really show a true  reflection of the bandwidth. 

From the results it can be noted that the  bandwidth  is almost the same for all the OSTs in both reading and writing.EC3 has a read bandwidth  in Ulysses by a factor of 2. 