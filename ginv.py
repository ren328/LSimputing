import math
import scipy
import scipy.linalg 
import tensorflow as tf
import numpy as np
import json
import os
import pandas as pd
import time
import rpy2.robjects as robjects
from rpy2.robjects import pandas2ri
from rpy2.robjects.conversion import localconverter


##Use proper function to load SNP, should be NA filled and centered
snp="path"
snp=np.array(snp)
p=np.shape(snp)[1]

time1=time.process_time()
for j in range(p):
  c=snp[:,j]
  cp=np.matmul(c.T,c)
  cp1=1/cp
  res.append(cp1)

res1=np.diag(res)
cxt=np.matmul(res1,snp.T)


##Use proper funciton to load GWAS summary statistics
beta="path"
 

xxt=np.matmul(cxt.T,cxt)

xxtinv=np.linalg.pinv(xxt,rcond=math.sqrt(np.finfo(float).eps))

reg=np.matmul(xxtinv,cxt.T)

yhat=np.matmul(reg,beta)
##end recording time
time2=time.process_time()
chtime=[time2-time1]
##use proper function to save the result
np.savetxt("path",chtime)
np.savetxt("path",yhat)
