#!/usr/bin/env python
# coding: utf-8

# # # # # # # # # # # # # #  Assignment1.ML  # # # # # # # # # # # # # # # # # # # # # # 
# 
# 
# Let us consider a data set where we have a value of response y for every feature x: 

# Data Set:
# x= np.array([1,2,3,4,5,6,7,8,9,10])
# y= np.array([100,200,500,600,900,920,940,980,1100,1500])
# The task is to find a line of best fit so that we can predict the response for any new feature values. (if a value of x is # # not present in the dataset). This line is called a regression line.
# The equation of regression line is represented as:
# y=mx+c or
# y=b0+b1(x)+b2(x)

# How to go about it?
# Copy the small data set given into the workspace
# Assume values with different formulae into b0 and b1(x) and so # on..
# Now plot the graph based on calculated values and create some # random predicted values

# Finally, now we estimate the coefficient created

# Predict the values.

# Plot the graph
# In[2]:


import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')

x= np.array([1,2,3,4,5,6,7,8,9,10])
x


# In[3]:


y= np.array([100,200,500,600,900,920,940,980,1100,1500])
y


# In[7]:


m, c = np.polyfit(x, y, 1)
m


# In[8]:


c


# In[9]:


plt.plot(x, y, 'o')

plt.plot(x, m*x + c)


# In[10]:


# OR A one line version to plot the line of best fit.

plt.plot(np.unique(x), np.poly1d(np.polyfit(x, y, 1))(np.unique(x)))


# In[11]:


# OR
from sklearn.linear_model import LinearRegression

X, Y = x.reshape(-1,1), y.reshape(-1,1)
plt.plot( X, LinearRegression().fit(X, Y).predict(X) )


# In[7]:


# OR
import numpy as np
import matplotlib.pyplot as plt


# In[18]:


# size of data set 
# then we call the mean of numpy
# Then we calculate the sum of mean errors i.e total observations y*x-n*means
# Then we calculate the regression coefficients
def estimate_coefficient(x,y):
    n = np.size(x)
    mean_x, mean_y =np.mean(x), np.mean(y)
    SS_xy = np.sum(y*x - n*mean_y*mean_x)
    SS_xx = np.sum(x*x - n*mean_x*mean_x)
    b1 = SS_xy / SS_xx
    b0 = mean_y-b1*mean_x
    return(b0,b1)
    


# In[19]:


# now plot the graph based on calculated values and create some random predicted values.
def plot_regression_line(x,y,b):
    plt.scatter(x,y,color='m',marker="o")
    y_pred = b[0]+b[1]*x
    plt.plot(x,y_pred,color='g')
    plt.xlabel('Size')
    plt.ylabel('Cost')
    plt.show()


# In[20]:


# x = These are house sizes ranging from 1000sqft to 10k sqft
# y = the cost of house in multiple of 1000s
x = np.array([1,2,3,4,5,6,7,8,9,10])
y = np.array([300,350,500,700,800,850,900,900,1000,1200])


# In[21]:


# Now we estimate the coefficient
b = estimate_coefficient(x,y)
print("Estimated Coefficients: \nb0 = {} \nb1 = {}".format([b0],[b1]))
plot_regression_line(x,y,b)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




