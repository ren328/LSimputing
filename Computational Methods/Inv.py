import math
import scipy
import scipy.linalg 
import numpy as np
import os
import pandas as pd
import time
import rpy2.robjects as robjects
from rpy2.robjects import pandas2ri
from rpy2.robjects.conversion import localconverter

##value of lambda, could be changed to  your own choice
lam=1e-6
##change wls to True if want use WLS method
wls=False

##Use proper funciton to load GWAS summary statistics
beta="path"
sd="path"
##Use proper function to load SNP, should be NA filled and centered
snp="path"
snp=np.array(snp)
p=np.shape(snp)[1]
res=[]
time1=time.process_time()
for j in range(p):
  c=snp[:,j]
  cp=np.matmul(c.T,c)
  cp1=1/cp
  res.append(cp1)

res1=np.diag(res)
if wls==True:
  beta=np.divide(beta,sd)
  cxt1=np.matmul(res1,snp.T)
  cxt=np.divide(cxt1.T,sd).T
else:
  cxt=np.matmul(res1,snp.T)


 

xxt=np.matmul(cxt.T,cxt)

a1=np.diag(xxt)
a2=a1+lam
np.fill_diagonal(xxt,a2)
xxtinv=np.linalg.inv(xxt)

reg=np.matmul(xxtinv,cxt.T)

yhat=np.matmul(reg,beta)
##end recording time
time2=time.process_time()
chtime=[time2-time1]
##use proper function to save the result
np.savetxt("path",chtime)
np.savetxt("path",yhat)
