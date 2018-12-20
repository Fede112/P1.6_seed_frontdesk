#!/usr/bin/python3

import matplotlib.pyplot as plt
import math

f=open("all_data.dat","r")
data={}
data2={}
count={}
names=set()
Nmax=0

for l in f:
	
	try:
		name,x,y,s,t=l.split()
		T=float(t)
	except:
		continue

	
	N = int(x)*int(y)*4
	key = (name,N,s)
	
	if not key in data:
		data[key]=0.0
		count[key]=0
		data2[key]=0.0
	
	data[key] +=T
	data2[key] += T*T
	count[key] +=1
	Nmax=max(N,Nmax)
	names.add(name)

def mean(key):
	return data[key]/count[key]
	
def stdev(key):
	m = mean(key)
	m2 = data2[key]/count[key]
	return math.sqrt(m2 - m**2)

plt.figure(1)
plt.title('Netcdf performance on lustre (8 processes)')
plt.yscale('log')
stripe='1'
for name in names:
	X = sorted([ k[1]
		for k in data if k[0]==name and k[2]==stripe ])
	
	Y = [10**-6 * x/ mean((name,x,stripe)) for x in X  ]
	Yerr = [ 10**-6 * stdev((name,x,stripe)) * x / mean((name,x,stripe))**2  for x in X  ]



	xmb = [x*10**-9 for x in X]
	#ymb = [y*10**-6 for y in Y]
	
	print(Yerr)
	
	plt.errorbar(xmb,Y,yerr=Yerr,fmt="-o",label=name)


plt.xlabel("Size (GB)")
plt.ylabel("Bandwidth (MB/s)")
plt.legend()
plt.savefig("netcdf_1.png")

print(Nmax)


plt.figure(2)
plt.title('Netcdf performance on lustre (8 processes, size ' + str(Nmax * 10**-9) + 'GB)')
plt.yscale('log')
#plt.ylim((10,10**4))
stripes = ['1','2','4']	
plt.xticks( [int(s) for s in stripes] , stripes  )

for name in names:
	Y = [ 10**-6 * Nmax/mean((name,Nmax,s)) for s in stripes  ]
	Yerr = [ 10**-6 * stdev((name,Nmax,s))  * Nmax/mean((name,Nmax,s))**2 for s in stripes  ]
	#ymb = [y*10**-6 for y in Y]
	
	plt.errorbar([int(s) for s in stripes],Y,yerr=Yerr,fmt="-o",label=name)


plt.xlabel("Stripe")
plt.ylabel("Bandwidth (MB/s)")
plt.legend()
plt.savefig("netcdf_2.png")
