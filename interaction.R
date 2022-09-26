require(data.table)
#load snp matrix
load("path")
snp_test<-"change the name of snp matrix into snp_test"

len<-ncol(snp_test)
##load trait value
trait<-load("trait_path")
traitnew<-scale(trait,scale=F)
index<-1:len
index1<-combn(index, 2)

beta<-c()
beta_sd<-c()
p_value<-c()
for(i in 1:ncol(index1)){
  print(i)
  m1<-lm(traitnew~snp_test[,index[1,i]]*snp_test[,index[2,i]])
  beta[i]<-summary(m1)$coef[4,1]
  beta_sd[i]<-summary(m1)$coef[4,2]
  p_value[i]<-summary(m1)$coef[4,4]
}
#save the result
save(beta,beta_sd,p_value,file="path")