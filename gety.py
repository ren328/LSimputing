import json
import numpy as np
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras import regularizers

##This file is to get the result for one batch, to get the result for all sample, change the cp_path to corresponding path 
##input batchsize
batchsize=
def my_loss(y_true, y_pred):
    squared_difference = tf.square(y_true - y_pred)
    return (tf.reduce_sum(squared_difference))

model = keras.Sequential([layers.Dense(units=1, activation = "linear",kernel_regularizer=regularizers.l2(l=0))])
opt = keras.optimizers.Adam(learning_rate=0.001)
model.compile(optimizer=opt,loss = my_loss)

test=np.random.normal(0,1,(1,batchsize))
metric=model.predict(test)


epoch=500
yhat=np.zeros(epoch)
i=500
##change cp_path to the checkpoint path
model.load_weights(r"cp_path/cp-{:04d}.ckpt".format(i)) 
yls=model.weights[0].numpy().reshape(-1)
##use proper function to save the result, change the path to your own
np.savetxt("path",yls)
