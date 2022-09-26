##load snp matirx, n*p
snp_test<-load("path")
##fill missing values
snp<-apply(snp_test, 2, function(x) replace(x, is.na(x), mean(x, na.rm = TRUE)))
snp<-data.frame(snp)


##split into batches, change the seed for different partition
set.seed(1234)
id=1:nrow(snp_test)
index=sample(id)
datasplit<-function(chunksize,test_id,data){
  f1=ceiling(seq_along(test_id)/chunksize)
  data1<-split(data,f=f1)
  return(data1)
}
data<-datasplit(chunksize,index,snp_test)
##scale by batch
scalesnp<-function(snp){
  snp_scale<-scale(snp)
  return(snp_scale)
}
snp_final<-lapply(data,scalesnp)

save(snp_final,file="path")
