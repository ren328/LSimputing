##use proper function to load snp matrix, change path to your own
snp_test="path"
##center(T) or standardization(F)
center=T
##fill missing values
snp<-apply(snp_test, 2, function(x) replace(x, is.na(x), mean(x, na.rm = TRUE)))
snp<-data.frame(snp)



##batch split          
##split data into batches, change the seed for different partition.
          
set.seed(1234)
id=1:nrow(snp)
index=sample(id)
snp1=snp[index,]

##chunksize:sample size in per batch
datasplit<-function(chunksize,id,data){
  f1=ceiling(seq_along(id)/chunksize)
  data1<-split(data,f=f1)
  return(data1)
}
##change the chunksize to your own           
data<-datasplit(chunksize,id,snp1)

##centered(scale=F)/standardized(scale=T) by batch
if(center=F){
snp_final<-lapply(data, function(y) {
  apply(y, 2, function(z) {
    (z - mean(z)) / (sd(z) * as.logical(sd(z)))
  })
})}else{
snp_final<-lapply(data,scale,scale=F)
}
           
##save the result
save(snp_final,file="path")
##snp_final is a list, each element in the list is the data for one batch
