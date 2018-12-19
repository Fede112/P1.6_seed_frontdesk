import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator
import numpy as np


n_groups=4
def get_lists(filename):
    size, write,read = [], [], []
    with open(filename, 'r') as f:
        for line in f:
            value = [int(s) for s in line.split()]
            size.append(value[0])
            write.append(value[1]/1024)
            read.append(value[3]/1024)

    return size,write,read,


index = np.arange(n_groups)
s,w,r = get_lists('00.dat')
s, w1, r1  = get_lists('01.dat')
s, w2, r2 = get_lists('02.dat')
s, w3, r3 = get_lists('03.dat')
s = [8,64,128,150]
x_index=np.arange(4)*5
# print x_index
# width = np.min(np.diff(x_index))/3
width = 0.5
#print(w)
plt.bar(x_index - width/2, r, width, color='b', label='ost 0')
plt.bar(x_index - width*(3/2), r1, width, color='r', label='ost 1')
plt.bar(x_index + width/2, r2, width, color='y', label='ost 2')
plt.bar(x_index + width*3/2, r3, width, color='g', label='ost 3')
plt.title('Read Bandwidth C3E')
plt.xlabel('size(GB)')
plt.ylabel('Mbytes/sec')
plt.ylim(0,600)
# plt.xticks(s + index + width, ( 8, 64, 128, 150))
plt.xticks(x_index, ('8g', '64g', '128g', '150g'))
plt.xlim(3, 17)

plt.legend()
#plt.yscale('log')
plt.tight_layout()
plt.plot()
plt.savefig('ec3_read.png')
