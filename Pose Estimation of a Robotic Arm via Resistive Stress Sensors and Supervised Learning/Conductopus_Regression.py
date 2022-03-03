import pandas as pd
import numpy as np
from sklearn.model_selection import train _ test _ split
from sklearn.preprocessing import StandardScaler
from sklearn import linear_model
from sklearn.ensemble import RandomForestRegressor
from sklearn.neural_network import MLPRegressor
from sklearn. metrics import classification_report, confusion_matrix
import math
from time import sleep
from matplotlib import pyplot as plt
from matplotlib import rc


font = {’family':'normal’,
  ’weight':'bold’,
  ’size': 20}

rc(’font’, **font)
def trainLSF(x, y):
  LR = linear_model.LinearRegression()
  LR.fit(x,y)
  A = np.transpose(LR.coef_)
  Ax = np.dot(x, A)
  for i in range(len(Ax)):
    Ax[i][0] += LR.intercept[0]
    Ax [i][1] += LR.intercept[1]
  return Ax

def trainRFR(xtrain , xtest, y train , ytest):
  scaler = StandardScaler()
  #Determine scalar range
  scaler.fit(xtrain)
  # Scales down data to smaller range for better convergances
  xtrain = scaler.transform(xtrain)
  xtest= scaler.transform(xtest)

  rf = RandomForestRegressor()
  rf.fit(xtrain , ytrain)
  Ax = rf.predict(scaler.transform(x))

  return Ax

def rotate(vector, theta):
  theta = math.radians(theta)
  return [math.cos(theta)*vector[0] - math.sin(theta)*vector[1],
  math.sin(theta)*vector[0] + math.cos(theta)*vector[1]]

def plotAngles(predictAngles, realAngles, regType, angle):
  bottomVector =(0 , 1)
  middleVector =(0 ,-1)
  topVector =(0 ,-1)
  pA1 = predictAngles[0]
  pA2 = predictAngles[1]
  rA1 = realAngles[0]
  rA2 = realAngles[1]
  middleOffsetP = rotate(middleVector, pA1)
  topOffsetTempP = rotate(topVector, pA1)
  topOffsetP = rotate([-topOffsetTempP[0], -topOffsetTempP[1]], pA2)
  middleOffsetR = rotate(middleVector, rA1)
  topOffsetTempR = rotate(topVector, rA1)
  topOffsetR = rotate([-topOffsetTempR[0], -topOffsetTempR[1]], rA2)

  baseJoint =(0, 0)
  bottomJoint =(0, 1)
  middleJoint P =(middleOffsetP[0], middleOffsetP[1] + 1)
  topJoint P =(middleJointP[0] + topOffsetP[0], middleJointP[1] + topOffsetP[1])
  middleJointR =(middleOffsetR[0], middleOffsetR[1] + 1)
  topJointR =(middleJointR[0] + topOffsetR[0], middleJointR[1] + topOffsetR[1])

  xPosP = [baseJoint[0], bottomJoint[0], middleJointP[0], topJointP[0]]
  yPosP = [baseJoint[1], bottomJoint[1], middleJointP[1], topJointP[1]]
  xPosR = [baseJoint[0], bottomJoint[0], middleJointR[0], topJointR[0]]
  yPosR = [baseJoint[1], bottomJoint[1], middleJointR[1], topJointR[1]]

  regtypeStr =' '
  degree = 0
  percent = 0
  theta =' '
  if regType == 0 :
    if angle == 0 :
      regtypeStr ='LSF'
      degree=(round(abs(predictAngles[0] - realAngles[0]), 2))
      theta = ” ${\Theta}_2$ ”
      percent = round(degree/realAngles[0]*100, 2)
    elif angle == 1 :
      regtypeStr ='LSF'
      angP = predictAngles[1]
      angR = realAngles [1]
      degree=(round(abs(predictAngles[1] - realAngles[1]), 2))
      theta = ” ${\Theta}_1$ ”
      percent = round(degree/realAngles[1] *100 , 2)
    elif angle == 2 :
      regtypeStr='LSF'
      degree=(round(abs(predictAngles[1] - realAngles [1]) + abs(predictAngles[0] - realAngles[0])))
      theta =” ${\Theta}_t$ ”
      percent =(round((abs(predictAngles[1] - realAngles[1])/realAngles[1] + abs(predictAngles[0] - realAngles[0])/realAngles[0])*100,2))
  elif regType == 1 :
    if angle == 0 :
      regtypeStr='RFR’
      degree=(round(abs(predictAngles[0] - realAngles[0]), 2))
      theta = ” ${\Theta}_2$ ”
      percent = round(degree/realAngles[0]*100, 2)
    elif angle == 1 :
      regtypeStr='RFR’
      degree=(round(abs(predictAngles[1] - realAngles[1]),2))
      theta = ” ${\Theta}_1$ ”
      percent = round(degree/realAngles[1] *100 , 2)
    elif angle == 2 :
      regtypeStr='RFR’
      degree=(round(abs(predictAngles[1] - realAngles [1]) + abs(predictAngles[0] - realAngles[0])))
      theta =” ${\Theta}_t$ ”
      percent =(round((abs(predictAngles[1] - realAngles[1])/realAngles[1] + abs(predictAngles[0] - realAngles[0])/realAngles[0])*100,2))

  plt.plot(xPosP, yPosP, linewidth = 4 , label ='predicted’)
  plt.plot(xPosR, yPosR, linewidth = 4 ,label ='Actual')
  plt.axis([-0.5, 2, 0, 3])
  plt.xlabel(’x position’)
  plt.ylabel(’y position’)
  plt.title(r'%s %s Maximum Error : %s${\degree}$(%s %%)’%(regtypeStr, theta, degree, percent))
  plt.legend()
  plt.pause(0.01)
  plt.show()
  plt.gcf().clear()

def maxAngleError(x , y , regType) :
  trials = 20
  averageMaxErrA1 = 0
  averageMaxErrA2 = 0
  averageMaxErrAT = 0
  A1 = 0
  Y1 = 0
  A2 = 0
  Y2 = 0
  AT = 0
  YT = 0
  for trial in range(trials):
    maxA1 = 0
    maxA2 = 0
    maxTotal = 0
    if regType == 0:
      Ax = trainLSF(x, y)
    elif regType == 1:
      xtrain, xtest, ytrain , ytest= train_test_split(x, y, test_size = 0.25)
      Ax = trainRFR(xtrain, xtest, ytrain, ytest)
    for i in range(len(x)):
      if maxA1 < abs(Ax[i][0] - y[i][0]):
        maxA1 = abs(Ax[i][0] - y[i][0])
        A1 = Ax[i]
        Y1 = y[i]
      if maxA2 < abs(Ax[i][1] - y[i][1]):
        maxA2 = abs(Ax[i][1] - y[i][1])
        A2 = Ax[i]
        Y2 = y[i]
      if maxTotal <(abs(Ax[i][1] - y[i][1]) + abs(Ax[i][0] - y[i][0])) :
        maxTotal = abs(Ax[i][1] - y[i][1]) + abs(Ax[i][0] - y[i][0])
        AT = Ax[i]
        YT = y[i]

    averageMaxErrA1 += maxA1
    averageMaxErrA2 += maxA2
    averageMaxErrAT += maxTotal
  printA1
  printA2
  printAT

  plotAngles(A1, Y1, regType, 0)
  plotAngles(A2, Y2, regType, 1)
  plotAngles(AT, YT, regType, 2)

  return maxA1 , maxA2 , maxTotal
def averageAnglePercentError(Ax , y , regType) :
# trials = 20
# for trial in range(trials) :
  maxA1 = 0
  maxA2 = 0
  maxTotal = 0
  maxA11 = 0
  maxA22 = 0
  maxTotalT = 0
  for i in range(len(Ax)) :
    maxA1 +=(abs(Ax[i][0] - y[i][0]) / y[i][0])*100
    maxA2 +=(abs(Ax[i][1] - y[i][1]) / y[i][1])*100
    #maxTotal += maxA1 + maxA2
    maxA11 += abs(Ax[i][0] - y[i][0])
    maxA22 += abs(Ax[i][1] - y[i][1])
    #maxTotalT += maxA11 + maxA22
  print ”Average Percentage Errorfor %s Re g r e s s i o n ”%(regType)
  print ”Average Percentage Errorfor Angle 1 :
%s%%”%(round(maxA1 / l e n(Ax) , 2))
  print ”Average Percentage Errorfor Angle 2 :
%s%%”%(round(maxA2 / l e n(Ax) , 2))

  print ”Average Errorfor Angle 1:
%s ”%(round(maxA22 / l e n(Ax) , 2))
  print ”Average Errorfor Angle 2:
%s ”%(round(maxA11 / l e n(Ax) , 2))


def rootMeanSquaredError(Ax, y):
  meaSqErr1 = 0
  meaSqErr2 = 0
  for i in range(len(Ax)):
    meaSqErr1 +=(Ax[i][1] - y[i][1])**2
    meaSqErr2 +=(Ax[i][0] - y[i][0])**2

def movie(Ax,y):
  plt.ion()
  for i in range(len(Ax)):
    plotAngles(Ax[i], y[i])
    plt.ioff()

armData = pd.read_csv('trial2.csv')
# print armData.head()
# print armData.describe().transpose()
x = armData.drop([’t’,'Angle 1’,'Angle 2’], axis = 1)
y = armData.drop([’t’,’Resistance 1’,’Resistance 2’,’Resistance 3’,’Resistance 4’,'Resistance 5’]
t=armData [’t’]

x = np.asarray(x)
y = np.asarray(y)
t = np.asarray(t)
xtrain , xtest, y train , ytest= train_test_split(x, y, test_size = 0.35)

#BASIC PLOTS#
plt.plot(t , x [: , 0] , color ='y',label = ” Resistance 1 ”)
plt.plot(t , x [: , 1] , color ='g',label = ” Resistance 2 ”)
plt.plot(t , x [: , 2] , color ='b',label = ” Resistance 3 ”)
plt.plot(t , x [: , 3] , color ='k',label = ” Resistance 4 ”)
plt.plot(t , x [: , 4] , color ='r',label = ” Resistance 5 ”)
plt.xlabel('Time(ms)')
plt.ylabel('Resistance(ohm)')
plt.title('Resistance Change In Time of Silicon Wires')
plt.legend()
plt.show()
plt.plot(t , y [: , 1] , color ='r',label = ”Angle 1 ”)
plt.plot(t , y [: , 0] , color ='b',label = ”Angle 2 ”)
plt.xlabel('Time(ms)')
plt.ylabel('Angle(degree)')
plt.title('Angle Change In Time of Arm Joint s')
plt.legend()
plt.show()
#############
#LEAST SQUARE FIT#
print”LEAST SQUARE REGRESSION”
Ax = trainLSF(x , y)
maxAngleError(x , y , 0)
averageAnglePercentError(Ax , y ,'Least Square')
rootMeanSquaredError(Ax , y)
#Movie(Ax , y)
##################

# RandomForestRegressor #

print”RANDOM FOREST REGRESSION”
maxAngleError(x , y , 1)
Ax = trainRFR(xtrain , xtest, y train , ytest)
averageAnglePercentError(Ax , y ,'Random Forest')
rootMeanSquaredError(Ax , y)
#Movie(Ax , y)
print ”Feature importance ”
scaler = StandardScaler()
scaler.fit(xtrain)
xtrain = scaler.transform(xtrain)
xtest= scaler.transform(xtest)
rf = RandomFor e s tRegr e s sor()
rf.fit(xtrain , y train)
rf.predict(scaler.transform(x))
print ”Yellow : %s%%”%(round(rf.feature_importances[0], 2)*100)
print ”Green : %s%%”%(round(rf.feature_importances[1], 2)*100)
print ”Blue : %s%%”%(round(rf.feature_importances[2], 2)*100)
print ”Black : %s%%”%(round(rf.feature_importances[3], 2)*100)
print ”Red : %s%%”%(round(rf.feature_importances[4], 2)*100)
#######################


