#!/usr/bin/python3

#This is the code for second method proposed

import os
import glob
#import numpy as np
import statistics as st
import math
import random as r
import pipes


files=['OUD1.fred','OUD2.fred','OUD3.fred','OUD4.fred','OUD5.fred','OUD6.fred','OUD7.fred','OUD8.fred','OUD9.fred']
res=[[] for i in range(9)]
ci=[[0,0] for i in range(9)]
index=0
mx=0
m=25
mx_flag=0
c=0
for i in range(0,100):
	c=c+1
	if i<9:
		index=i
		os.system("fred_job -k script -p run1/"+files[i]+" -m"+str(m)+" -n"+str(m))
	else:
		mx=0
		index=0
		for j in range(9):
			error=1.96*math.sqrt(st.variance(res[j]))/math.sqrt(len(res[j]))
			ci[j][0]=st.mean(res[j])-error
			ci[j][1]=st.mean(res[j])+error
			if(abs(ci[j][0]-ci[j][1])>mx):
				mx=abs(ci[j][0]-ci[j][1])
				index=j
		if(mx<5.5):
			print("mx become <1.5")
			mx_flag=1
			break
		
		print("mx now is:",mx)
		m=25
		os.system("fred_job -k script -p run1/"+files[index]+" -m"+str(m)+" -n"+str(m))

	if mx_flag==1:
		break
	list1 = glob.glob('FRED/RESULTS/JOB/*')
	print("i:",i,list1)
	f = max(list1, key=os.path.getctime)
	
	ls1=[]
	
	for j in range(1,m+1):
		print(j,f)
		fnew = f+'/OUT/RUN'+str(j)+'/DAILY/ORU.DeathOd.txt'
		with open(fnew)  as file:
			for line in file:
				pass
			last_line = line
		last_line = last_line.split(" ")

		res[index].append(int(last_line[-1]))
		if index==0:
			print("r:",res[0])
		file.close()

	p=os.popen("fred_delete -k script","w")
	p.write("y")
	p.close()

print(st.mean(res[0]),math.sqrt(st.variance(res[0])))

f = open("out.txt", "a")

import datetime
f.write("\n===================================\n"+str(datetime.datetime.now())+"\n======================\n")
for i in range(9):
	print(i+1," ",ci[i]," ",len(res[i]),"\n")
	f.write(str(i+1)+" "+str(ci[i])+" "+str(len(res[i]))+"\n")

#print(ci)
print("\n mx=",mx)
f.write("\nmx="+str(mx))
f.write("\ncounter:"+str(c))
f.close()
