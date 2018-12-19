import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator
import numpy as np


n_groups=4
def get_lists(filename, n,m):
    size, write, read = [], [], []
    with open(filename, 'r') as f:
        for line in f:
            value = [int(s) for s in line.split()]
            size.append(value[0])
            write.append(value[n]/1024)
            read.append(value[m]/1024)

    return size,write,read,


index = np.arange(n_groups)
s,w,r = get_lists('00.dat',1,3)
s, w1, r1  = get_lists('01.dat',1,3)
s, w2, r2 = get_lists('02.dat',1,3)
s, w3, r3 = get_lists('03.dat',1,3)

s, w_uly, r_uly = get_lists('uly_00.dat',2,4)
s, w_uly1, r_uly1 = get_lists('uly_11.dat',2,4)

print(w_uly)
s = [8,64,128,150]
x_index=np.arange(4)*5
width = 0.5
plt.subplot(121)
plt.bar(x_index - width/2, w, width, color='b', label='ost 0')
plt.bar(x_index - width*(3/2), w1, width, color='r', label='ost 1')
plt.bar(x_index + width/2, w2, width, color='y', label='ost 2')
plt.bar(x_index + width*3/2, w3, width, color='g', label='ost 3')
plt.title('Write Bandwidth EC3')
plt.xlabel('size(GB)')
plt.ylabel('Mbytes/sec')
plt.ylim(0,512)
plt.xticks(x_index, ('8g', '64g', '128g', '150g'))
plt.legend()

plt.subplot(122)
plt.bar(x_index, w_uly, width, color='b', label='ost 0')
plt.bar(x_index + width, w_uly1, width, color='r', label='ost 1')
plt.title('Write Bandwidth (Ulysses)')
plt.xlabel('size(GB)')
plt.ylabel('Mbytes/sec')
plt.xticks(x_index, ('8g', '64g', '128g', '150g'))
plt.legend()

plt.tight_layout()
plt.plot()

plt.savefig('iozone_write.png')
