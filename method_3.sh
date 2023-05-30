#!/usr/bin/python3

# This is the code for the third method (greedy-2) proposed in the paper

import os
import glob
import numpy as np
import statistics as st
import math
import random as r

def matmulti(x,beta):
    return np.matmul(x, beta)

def Q(x, y, beta):
    return ((matmulti(x, beta)-y).T@(matmulti(x, beta)-y))/(2*y.shape[0])

def gradient_descent(x, y, beta, lr, num_epochs):
    n = x.shape[0]
    grad = []

    for i in range(num_epochs):
        multi_x = matmulti(x, beta)
        cost_val = (1/n)*(x.T@(multi_x - y))
        beta = beta - (lr)*cost_val
        grad.append(Q(x, y, beta))

    return beta, grad 



files=['OUD1.fred','OUD2.fred','OUD3.fred','OUD4.fred','OUD5.fred','OUD6.fred','OUD7.fred','OUD8.fred','OUD9.fred']
res=[[] for i in range(9)]

index=0
mx=0
m=27
diff_flag=0
c=0
avg=0
yhat=0

for i in range(0,200):
	c=c+1
	if i<9:
		index=i
		os.system("fred_job -k script -p run1/"+files[i]+" -m"+str(m)+" -n"+str(m))
	else:
		x=[]
		y=[]
		n=100
		for i in range(0,n):
			num1 = r.randint(1,3)
			num2 = r.randint(1,3)
			x.append([num1,num2,num1*num2])
			
			if num1==1:
				y.append(res[num2-1][r.randint(1,len(res[num2-1]))])
			if num1==2:
				y.append(res[num2+num1][r.randint(1,len(res[num2+num1]))])
			if num1==3:
				y.append(res[num2-4][r.randint(1,len(res[num2-4]))])
		
		y = np.array(y,dtype=np.float64)
		y = np.reshape(y,(n,1))

		x = np.array(x,dtype=np.float64)#.reshape(-1,1)
		x = np.hstack((np.ones((x.shape[0],1)), x))
		beta = np.zeros((x.shape[1], 1))
		learning_rate = 0.05
		num_epochs = 100
		beta, grad_all = gradient_descent(x, y, beta, learning_rate, num_epochs)
		grad = Q(x, y, beta)
		avg=np.average(tot[4])
		yhat = np.matmul([1,2,2,4],beta)
		error = 1.96*math.sqrt((yhat-avg)**2/len(tot[4]))
		diff=abs( (avg-error)-(avg+error))
	        
		index=0
		if(diff<=8.0):
			print("diff become <8")
			diff_flag=1
			break
		
		print("diff now is:",diff)
		#m=25
		
		index=r.randint(0,8)
		os.system("fred_job -k script -p run1/"+files[index]+" -m"+str(m)+" -n"+str(m))

	if diff_flag==1:
		break
	list1 = glob.glob('FRED/RESULTS/JOB/*')

	f = max(list1, key=os.path.getctime)
	
	ls1=[]
	
	
	for j in range(1,m+1):
		fnew = f+'/OUT/RUN'+str(j)+'/DAILY/ORU.DeathOd.txt'
		with open(fnew)  as file:
			for line in file:
				pass
			last_line = line
		last_line = last_line.split(" ")

		file.close()

	p=os.popen("fred_delete -k script","w")
	p.write("y")
	p.close()

print(st.mean(res[0]),math.sqrt(st.variance(res[0])))

f = open("out.txt", "a")

import datetime
f.write("\n===================================\n"+str(datetime.datetime.now())+"\n======================\n")
for i in range(9):
	#print(i+1," ",ci[i]," ",len(res[i]),"\n")
	f.write(str(i+1)+" "+str(st.mean(res[i]))+" "+str(st.variance(res[i]))+" "+str(len(res[i]))+"\n")


print("\ndiff=",diff)
f.write("\navg="+str(avg))
f.write("\nyhat="+str(yhat))
f.write("\ndiff="+str(diff))
f.write("\ncounter:"+str(c))
f.close()
