##load data with selected significant SNPs from additive model
data_add<-
##load data with selected siginificant SNPs from recessive model
data_rec<-
##load significant pair id
id_sig<-
#load true trait value from training set
y<-


##prune the data
cor_cutoff = 0.99
cor_bed = abs(cor(data_add))
cor_bed =(cor_bed < cor_cutoff)^2
diag(cor_bed) = 1
j = 1
while(j < nrow(cor_bed) )
{
  ind = which(cor_bed[j,] == 1)
  cor_bed = as.matrix(cor_bed[ind,ind])
  j = j + 1
}
data_add1= data_add[,ind]


cor_bed_rec = abs(cor(data_rec))
cor_bed_rec =(cor_bed_rec < cor_cutoff)^2
diag(cor_bed_rec) = 1
j = 1
while(j < nrow(cor_bed_rec) )
{
  ind = which(cor_bed_rec[j,] == 1)
  cor_bed_rec = as.matrix(cor_bed_rec[ind,ind])
  j = j + 1
}
data_rec1= data_rec[,ind]

##select 500 SNPs from recessive model
len<-ncol(data_rec1)
n<-500
set.seed(1234)
id<-sample(1:len,500)
data_rec2<-data_rec1[,id]##snp_rec500,data
id_rec<-colnames(data_rec2)##id_rec500,col

##select 300 SNPs from additive model
id_add<-colnames(data_add1)
index<-match(id_rec,id_add)
index1<-na.omit(index)
id_add1<-id_add[-index1]
data_add2<-data_add1[,id_add1]
n_add<-300
set.seed(1234)
id1<-sample(1:length(id_add1),300)
data_add3<-data_add2[,id1]#data,snpadd300
id_add2<-colnames(data_add3)##idadd300,col


##select 500 SNP pairs from the selected significant pairs
pair_num<-1652
ind_pair<-1:pair_num
index_pair<-combn(ind_pair, 2)
index_pair1<-index_pair[,id_sig]
len1<-ncol(index_pair1)#sigpairindex,len1
n_pair<-500
set.seed(1234)
id_pair<-sample(1:len1,500)
data_pair<-index_pair1[,id_pair]##snppair500,data
index_pair_sig1<-index_pair1[,id_pair]

index_main<-unique(c(data_pair))

data_pair_main<-data_add1[,index_main]##sampleid/pair/snppair500.RData,datapair
id_pair_main<-colnames(data_pair_main)##sampleid/pair/idpair500.RData,idpair


data_addrec<-cbind(data_rec2,data_add3)#dataaddrec,. snpaddrec.RData
id_all<-colnames(data_addrec)
ind_all<-match(id_all,id_pair_main)
index_all<-which(is.na(ind_all)==F)
id_final<-id_all[-index_all]
data_addrec1<-data_addrec[,id_final]
col_addrec1<-colnames(data_addrec1)

main<-c()
for(i in 1:ncol(data_addrec1)){
  outcome <- "y"
  main[i]<-col_addrec1[i]
}
data_final<-cbind(data_addrec1,data_pair_main)

col_pair<-colnames(data_rec1)
variables<-c()
for(i in 1:ncol(index_pair_sig1)){
  outcome <- "y"
  i1<-index_pair_sig1[1,i]
  i2<-index_pair_sig1[2,i]
  variables[i]<-paste0(col_pair[i1],"*",col_pair[i2]) 
}

f<- as.formula(
  paste(outcome, 
        paste(c(variables,main), collapse = " + "),
        sep = " ~ "))
m1<-lm(f,data=data_final)
r<-summary(m1)$r.squared
sd1<-summary(m1)$sigma
set.seed(1)
e<-rnorm(178175,0,sd1)
ytrain<-predict(m1,data_final)+e
##save the data,change the path accordingly 
save(ytrain,"path")
