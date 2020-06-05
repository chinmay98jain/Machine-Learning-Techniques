# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Importing the dataset
dataset = pd.read_csv('Position_Salaries.csv')
X = dataset.iloc[:, 1:2].values
Y = dataset.iloc[:, 2].values

from sklearn.ensemble import RandomForestRegressor
reg=RandomForestRegressor(n_estimators=281,random_state=0)
reg.fit(X,Y)

X_grid=np.arange(min(X),max(X),0.1)
X_grid=X_grid.reshape((len(X_grid),1))
plt.scatter(X,Y,color='red')
plt.plot(X_grid,reg.predict(X_grid),color='blue')

y_pred=reg.predict(np.array([[6.5]]))
y_pred