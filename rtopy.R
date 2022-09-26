##if scale by batch
f0<-function(batchsize){
  load(file="RData_path")
  
  return("snp matrix's name in RData"/(batchsize-1))
}
