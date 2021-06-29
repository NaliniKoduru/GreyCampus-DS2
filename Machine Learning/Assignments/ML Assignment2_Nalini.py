#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Agenda: Using logistic regression you predict whether a passenger is alive or not.

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')
import math

titanic_data = pd.read_csv(r"C:\Users\korad\Downloads\titanic.csv")
titanic_data


# In[2]:


# Countplot for survived vs sex
sns.countplot(x = "Survived", hue= "Sex", data=titanic_data)


# In[3]:


# Find out the number of missing values
titanic_data.isnull()


# In[4]:


titanic_data.isnull().sum()
# From the output, there are no null values in the titanic dataset.


# In[5]:


# Boxplot for Pclass and age
sns.boxplot(x="Pclass", y="Age", data=titanic_data)

# passengers travelling in class 1 & 2 are older than class 3.


# In[6]:


# Heatmap to check for null values.


# In[7]:


titanic_data.head(5)

# we notice that we can apply values of categorical value. hence we choose survived


# In[10]:


# to drop na values
# titanic_data.dropna(inplace=True)

# Then check with heat map for any NA values. You can also use cbar(colorbar)=false to remove colors.

sns.heatmap(titanic_data.isnull(), yticklabels=False, cmap='viridis')


# In[11]:


# to check if it is in string or not and to check different ways remove drop_first=True and test again.
#sex pd.get_dummies(titanic_data['Sex'])

sex = pd.get_dummies(titanic_data['Sex'],drop_first=True)
sex.head(5)


# In[15]:


pcl = pd.get_dummies(titanic_data['Pclass'], drop_first=True)
pcl.head(5)


# In[14]:


titanic_data=pd.concat([titanic_data,sex,pcl],axis=1)
titanic_data.head(5)


# In[16]:


# let us now drop a column to print a data set - name and pclass
titanic_data.drop(['Sex','Pclass','Name'],axis=1,inplace=True)


# In[17]:


titanic_data


# In[18]:


# from sklearn.cross_validation import train_test_split
from sklearn.model_selection import train_test_split
X = titanic_data.drop('Survived', axis = 1)
y = titanic_data['Survived']


# In[19]:


# Random state will take the same sample every time. Try changing for different samples.
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=1)


# In[20]:


from sklearn.linear_model import LogisticRegression
logmodel = LogisticRegression()


# In[21]:


logmodel.fit(X_train, y_train)


# In[22]:


predictions = logmodel.predict(X_test)
predictions


# In[24]:


# To test how a model is performing we can test the accuracy or classification report
# This is method 1
from sklearn.metrics import classification_report
classification_report(y_test,predictions)


# In[25]:


# Now we can check confusion matrix and check - Method 2
from sklearn.metrics import confusion_matrix


# In[26]:


#Predicted No, Predicted yes - col1 and col2
# Actual No, Actual Yes -row1 and row2
confusion_matrix(y_test,predictions)


# In[27]:


from sklearn.metrics import accuracy_score
accuracy_score(y_test,predictions)


# In[ ]:


# the value of the model predicts 0.76, that would mean a person is 76% alive and 24% dead.

