This is the code for paper Imputing genetic components of trait values with GWAS summary data and individual-level genotypic data.
This page is still under construction,if you have any questions, please send me an email(ren00075@umn.edu), thank you!


## Data Processing


#### batchsplit.R
Code to fill NA, center/standardize the SNP matrix, also could be used to split the data into batches, see more details in the file.

#rtopy.R
This is an R file which is used in ls.py to change .RData to the format which python file could use, if the snp matrix is not in .RData file, no need to use this file.


## Computational Methods
#lsADAM.py
The python file to implement our ls method with ADAM algorithm.

#gety.py
To get the imputed trait value after getting the result of ls.py.

#PRS-CS method
The implement of PRS-CS method follows exactly the step described by the following link: https://github.com/getian107/PRScs
See the below reference for more details: Ge, T., Chen, C.Y., Ni, Y., Feng, Y.C.A., Smoller, J.W. Polygenic Prediction via Bayesian Regression and Continuous Shrinkage Priors.
Nature Communications, 10, 1776 (2019). 

#RF.py
Code to implement RandomForests model.

#interaction.R
Code for interaction analysis.

#cholesky.py
Code to perform cholesky decomposition.

#ginv.py
Code to directly calculate the generalized inverse 

#ginv1.py
Code for the inverse method

#supp.R
This R file contains miscellaneous parts of the study, including truncate and transform p-value, plot setting, and so on. 
