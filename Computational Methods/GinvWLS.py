beta=np.loadtxt("/panfs/jay/groups/20/panwei/ren00075/1003batchsize/betafinalsdwls.txt")
  
print(beta.shape)
print(type(beta))      
sd=np.loadtxt("/panfs/jay/groups/20/panwei/ren00075/1003batchsize/sdfinalsdwls.txt")

n=178176
batch=25000
p=50000
batch_num=math.ceil(n/batch)
res=[]
ctime=time.process_time()
for j in range(p):
  c=snp[:,j]
  cp=np.matmul(c.T,c)
  cp1=1/cp
  res.append(cp1)

res1=np.diag(res)
print(res1.shape)
##p*p * p*n
cxt1=np.matmul(res1,snp.T)

cxt=np.divide(cxt1.T,sd).T
