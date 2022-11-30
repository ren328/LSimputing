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


##Code to pursue marginal association
##Use proper function to load SNP data,change the path to your own, should be NA filled 
snp="snp_path"
##Use proper function to load trait
trait="trait_path"

beta<-c()
beta_sd<-c()
p_value<-c()
for(i in 1:ncol(snp)){
    #print(i)
    m1<-lm(trait~snp[,i])
    beta[i]<-m1$coef[2]
    beta_sd[i]<-summary(m1)$coef[2,2]
    p_value[i]<-summary(m1)$coef[2,4]
}
##save the result with proper function, change the path to your own
save(beta,beta_sd,p_value,"result_path")

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




