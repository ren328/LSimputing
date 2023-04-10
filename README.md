This is the code for paper Using GWAS summary data to impute traits for genotyped individuals.
This page is still under construction,if you have any questions, please send me an email(ren00075@umn.edu), thank you!


## Data Processing


#### Batchsplit.R
Code to fill NA, center/standardize the SNP matrix, also could be used to split the data into batches, see more details in the file.




## Computational Methods
To run the algorithms, one should prepare the proper scaled SNP matrix and the GWAS summary statistics for the corresponding SNPs.
###### Rtopy.R
This is an R file which is used in .py files to change .RData to the format which python file could use, if the snp matrix is not in .RData file, no need to use this file.

#### LSADMM.py
The python file to implement our ls method with ADMM algorithm.



###### Gety.py
To get the imputed trait value after getting the result of LSADMM.py.

#### Cholesky.py
Code to perform cholesky decomposition.

#### Ginv.py
Code to directly calculate the generalized inverse 

#### Inv.py
Code for the inverse method


## Other Analysis
#### PRS-CS method
The implement of PRS-CS method follows exactly the step described by the following link: https://github.com/getian107/PRScs
See the below reference for more details: Ge, T., Chen, C.Y., Ni, Y., Feng, Y.C.A., Smoller, J.W. Polygenic Prediction via Bayesian Regression and Continuous Shrinkage Priors.
Nature Communications, 10, 1776 (2019). 

##### RF.py
Code to implement RandomForests model.

#### Interaction.R
Code for interaction analysis.

### Simulatio.R
Code for generating the simluated trait values


## Miscellaneous
#### Supp.R
This R file contains miscellaneous parts of the study, including truncate and transform p-value, plot setting, and so on. 
