# -*- coding: utf-8 -*-
"""
Created on Wed Jun  1 09:36:01 2016

@author: thauser
"""

import numpy as np
import matplotlib.pyplot as plt

def f(x):
    "quadratic function"
    y = x[0]**2+2*x[0]*x[1]**2+3*x[1]**2+4*x[0]+5*x[1]+6
    return y
    
def grad_f(x):
    "gradient of function f"
    a = 2*x[0] + 2*x[1]**2 + 4
    b = 4*x[0]*x[1] + 6*x[1] + 5
    y = [a,b]
    return y
    
def hess_f(x):
    "Hessian of f; or Jacobian of grad_f"
    a = 2
    b = 4*x[1]
    c = 4*x[0]+6
    y = [a,b,b,c]
    y = np.reshape(y,(2,2))
    return y


#%%
 x = np.arange(202)
 x[101:] = x[101:]-101
 x = np.reshape(x,(2,101))
# x[1,] = 1
 x = x-50
 print(x)
 
#%% plot the original function
 y= np.zeros((101,101))
for i in range(0,101):
    for ii in range(0,101):
        y[i,ii] = f([x[0,i], x[1,ii]])
        
 
plt.imshow(y)
plt.colorbar()
plt.xlabel("$x_2$", fontsize=25)
plt.ylabel("$x_1$", fontsize=25)
 
#%% plot gradient
 
 y2 = np.zeros((2,101))
 for i in range(0,101):
     y2[:,i] = grad_f([x[0,1],x[0,i]])
     
plt.subplot(2,1,1)
plt.plot(y[1,:])
plt.title("function, x1=1")
plt.subplot(2,1,2)
plt.plot(y2[1,])
plt.xlabel("gradient ($x_1$)")

#%% hessian
y3 = np.zeros((2,2,101))
for i in range(0,101):
     y3[:,:,i] = hess_f([1,x[0,i]])
plt.plot(y3[0,0,])


plt.subplot(3,1,1)
plt.plot(y[1,:])
plt.title("function, x1=1")
plt.subplot(3,1,2)
plt.plot(y2[1,])
plt.xlabel("gradient ($x_1$)")
plt.subplot(3,1,3)
plt.plot(y3[0,0,])
plt.xlabel("2nd derivative ($x_1$)")