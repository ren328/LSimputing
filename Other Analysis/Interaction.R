require(data.table)
##load SNP matrix, already fill missing values, with significant SNPs already selected.
##load the SNP, change the path to your own
data1="interaction_snp_path"
##prune process
cor_cutoff = 0.99
cor_bed = abs(cor(data1))
cor_bed =(cor_bed < cor_cutoff)^2
diag(cor_bed) = 1
j = 1
while(j < nrow(cor_bed) )
{
  ind = which(cor_bed[j,] == 1)
  cor_bed = as.matrix(cor_bed[ind,ind])
  j = j + 1
}
snp_test = data1[,ind]

len<-ncol(snp_test)
##load trait values
##change the path to your own
trait="trait_path"


index<-1:len
index1<-combn(index, 2)

beta<-c()
beta_sd<-c()
p_value<-c()
for(i in 1:ncol(index1)){
  m1<-lm(trait~snp_test[,index1[1,i]]*snp_test[,index1[2,i]])
  beta[i]<-summary(m1)$coef[4,1]
  beta_sd[i]<-summary(m1)$coef[4,2]
  p_value[i]<-summary(m1)$coef[4,4]
}
#save the result,change the path to your own
save(beta,beta_sd,p_value,file="interaction_result_path")
