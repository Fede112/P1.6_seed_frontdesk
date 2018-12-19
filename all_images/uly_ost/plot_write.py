import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator
import numpy as np


n_groups=4
def get_lists(filename):
    size, write, read= [], [], []
    with open(filename, 'r') as f:
        for line in f:
            value = [int(s) for s in line.split()]
            size.append(value[0])
            write.append(value[2]/1024)
            read.append(value[4]/1024)

    return size,write,read,

index = np.arange(n_groups)
s,w,r = get_lists('uly_00.dat')
s,w1,r1  = get_lists('uly_11.dat')

s = [8,64,128,150]
x_index=np.arange(4)*5
width = 0.5
print(w)
print(w1)

plt.bar(x_index , w, width, color='b', label='ost 0')
plt.bar(x_index + width, w1, width, color='r', label='ost 1')
plt.title('Write Bandwidth (Ulysses)')
plt.xlabel('size(GB)')
plt.ylabel('Mbytes/sec')
#plt.ylim(0,512)
plt.xticks(x_index, ('8g', '64g', '128g', '150g'))
plt.legend()
plt.tight_layout()
plt.plot()
plt.savefig('uly_ost_write.png')
