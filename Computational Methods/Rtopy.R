f0<-function(batchsize){
  ##load SNP matrix, should be a .RData file, for diffrent batches, change the RData_path to your own accordingly
  load(file="RData_path")
  ##change the snp matrix name to your own
  return("snp matrix's name in .RData"/(batchsize-1))
}
