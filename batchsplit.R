##use proper function to load snp matrix, change path to your own
snp_test="path"
##fill missing values
snp<-apply(snp_test, 2, function(x) replace(x, is.na(x), mean(x, na.rm = TRUE)))
snp<-data.frame(snp)


##split into batches, change the seed for different partition
set.seed(1234)
id=1:nrow(snp_test)
index=sample(id)
snp_test=snp_test[index,]
datasplit<-function(chunksize,id,data){
  f1=ceiling(seq_along(id)/chunksize)
  data1<-split(data,f=f1)
  return(data1)
}
data<-datasplit(chunksize,id,snp_test)
##scale by batch
scalesnp<-function(snp){
 snp2<-apply(snp, 2, function(y) (y - mean(y)) / sd(y) ^ as.logical(sd(y)))
 return(snp2)
}


snp_final<-lapply(data,scalesnp)
##use proper function to save the result
save(snp_final,file="path")
##snp_final is a list, each element in the list is the data for one batch, each batch could be used as the input in the ls.py.
