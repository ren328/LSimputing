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


##Use proper function to load SNP, should be NA filled
snp="path"

##Use proper funciton to load trait
beta="path"
 
##record time
time1=time.process_time()

xxt=np.matmul(snp,snp.T)

xtbeta=np.matmul(snp,beta)

u= scipy.linalg.cholesky(xxt)

w = scipy.linalg.solve(u.T, xtbeta)

yhat=scipy.linalg.solve(u,w)
##end recording time
time2=time.process_time()
chtime=[time2-time1]
##use proper function to save the result
np.savetxt("path",chtime)
np.savetxt("path",yhat)
