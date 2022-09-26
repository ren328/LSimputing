from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras import regularizers
from tensorflow.keras.callbacks import ModelCheckpoint
import tensorflow as tf
import numpy as np
import json
import os
import pandas as pd
import rpy2.robjects as robjects
from rpy2.robjects import pandas2ri
from rpy2.robjects.conversion import localconverter


##change Rtoptyhon_pyth to your own     
r = robjects.r
r['source']('Rtopython_pyth/rtopy.R')
rfunction = robjects.globalenv['f0']
with localconverter(robjects.default_converter + pandas2ri.converter):
     snp_test= rfunction(1)
     snp_test= snp_test.T
        
##load GWAS summary statistics(\beta*)
beta_final=np.loadtxt("path")


## custom loss
def my_loss(y_true, y_pred):
    squared_difference = tf.square(y_true - y_pred)
    return (tf.reduce_sum(squared_difference))

## build model
model = keras.Sequential([layers.Dense(units=1, activation = "linear",kernel_regularizer=regularizers.l2(l=0))])
opt = keras.optimizers.Adam(learning_rate=0.001)
model.compile(optimizer=opt,loss = my_loss)


##checkpoint
##change checkpoin_path to your own
checkpoint_path = "checkpoint_path"
checkpoint_dir = os.path.dirname(checkpoint_path)
cp_callback = tf.keras.callbacks.ModelCheckpoint(
   checkpoint_path, verbose=1, save_weights_only=True,
   # Save weights, every epoch.
   save_freq='epoch')

history=model.fit(
  snp_test,beta_final,epochs=500,batch_size = 512,shuffle=True,
  callbacks = [cp_callback] 
)

##save the model, change model_path to your own
model.save("model_path")
##save the loss,change the json_path to your own
json.dump(history.history, open("json_path",'w'))