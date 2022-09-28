from sklearn.ensemble import RandomForestRegressor
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
from sklearn.metrics import r2_score
from sklearn.metrics import mean_squared_error
from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras import regularizers
from tensorflow.keras.callbacks import ModelCheckpoint
import tensorflow as tf
import rpy2.robjects as robjects
from rpy2.robjects import pandas2ri
from rpy2.robjects.conversion import localconverter

##load snp matrix,already fill missing values and proper scaled
##change the path to your own, use proper function to load the snp
snp_test="snp_path"



##load trait,proper scaled, use proper function to load the trait
##change the path to your own
trait="trait_truth"


X_train,X_test,y_train,y_test=train_test_split(snp_test,trait,test_size=0.3,random_state=1)

forest=RandomForestRegressor(n_estimators=100,criterion='mse',random_state=1,n_jobs=-1)
forest.fit(X_train,y_train)
y_test_pred=forest.predict(X_test)

##change path to save the prediction result
np.savetxt("path",y_test_pred)
