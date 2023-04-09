##Code to change coding to recessive model and dominant model
## load SNP matrix
snp_test="path"
##dominant model
snp_dom=snp_test
snp_dom[snp_dom==2]<-1
##recessive model
snp_rec=snp_test
snp_rec[snp_rec==1]<-0
snp_rec[snp_rec==2]<-1

##Code to get the adjusted trait values
m1<-lm(HDL~age+sex+age*sex+I(age^2)+I(sex*age^2),data)
ypred<-predict(m1,data)


##setting of correlation plot
plot(,,pch=20,col="#1F53AE",xlab=" ",ylab=" ",main=" ")
abline(a=0,b=1,col="red")

##The Manhattan plot is drawn with manhattan function in R package qqman

##Truncate and transform p-value
##load p_value,change the path to your own
p_value="p_value path"
p1<-p_value
for(i in 1:length(p1)){
  if(p_value[i]<2.2*10^{-16})
  {p1[i]<-2.2*10^{-16}
  }else{
    p1[i]<-p_value[i]
  }
}
p2<--log10(p1)

##find the locus of the SNP
require(data.table)
##load the file partioned the LD block in paper Approximately independent linkage disequilibrium blocks in human populations
ld_block = fread('')
ld_block$chr = substr(ld_block$chr,4,5)
##load the data which we want to find the corresponding loci, sholud contain chr,rs,and position three columns(i.e. chrmosome, rs id and position)
data$locus=0
require(dplyr)
for(i in 1:nrow(data)){
    temp = ld_block %>% filter(chr==data$chr[i])
    id = findInterval(data$pos[i],temp$start)
    data$locus[i]=which(ld_block$chr==temp$chr[id] & ld_block$start == temp$start[id])
}

##The Venn diagrams is drawn with R package Venndiagram and RColorBrewer
display_venn<-function(x,...){
library(VennDiagram)
grid.newpage()
venn_object <- venn.diagram(x, filename = NULL, ...)
grid.draw(venn_object)
}
##Set data in the Venn diagram
set1 <- 
set2<- 
set3 <- 
x = list(A=set1, B=set2,C=set3)
library(RColorBrewer)
myCol <- brewer.pal(3, "Pastel2")
display_venn(x,category.names = c(" ", " " , " ")#set labels
             ,lwd = 2,
             lty = 'blank',
             fill = myCol,
             cex = 3,
             cat.cex = 1.5,
             cat.fontface = "bold",
             cat.default.pos = "outer",
             cat.pos = c(-27, 27, 135),
             cat.dist = c(0.055, 0.055, 0.085),
             cat.fontfamily = "sans"
)




