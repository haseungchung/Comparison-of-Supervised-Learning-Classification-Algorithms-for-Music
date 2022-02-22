# Residual Convolutional Neural Network for Communication Signal Classification

## Abstract
This work was inspired by Tim O'Shea's "Over the Air Deep Learning Based Radio Signal Classification".

In electronic warfare, the electronic attack division is tasked with attacking and disrupting enemy signals via detection, interception, and exploitation (in that order). Traditionally, detection and interception was done through man-made mathematical algorithms, and the game between attackers and protectors leaned in favor of the protectors, especially when it came to energy efficiency. However, artificial intelligence (AI) has recently been on the forefront of disrupting the field of electronic attack, proving to be more efficient in intercepting enemy signals than traditional methods (such as higher order statistics [HOS]). Tim O'Shea demonstrated this claim in his 2016 paper, "Convolutional Radio Modulation Recognition Networks", and his 2018 work, "Over the Air Deep Learning Based Radio Signal Classification". In this work, the modified residual network (MRN) architecture was recreated and its accuracy in classifying signal modulation types was compared to that of O'Shea's convolution neural network (CNN) from his 2016 paper, and against HOS based classification. Results demonstrated the MRN outperformed the CNN, and both of the AI based methods outperformed the HOS based method.

## Introduction

Artificial intelligence (AI) is a broad field of computer science that is focused on creating intelligent machines that can mimic human intelligence and behavior artificially. Within AI, there is a subfield called machine learning, which is concerned with using data to train computer algorithms to recognize patterns and extract features from data without any explicit instructions or programming. Until recently, machine learning was unpopular because hardware could not practically handle the complex computations necessary to train these algorithms. However, with the advances in high performance computing hardware and software, the field of machine learning is experiencing a revival of sorts, with one particular branch, called deep learning, proving to be exceptionally groundbreaking. By using multiple layers of "neurons" to learn patterns and extract features from data, the algorithm is able to pick up on highly nonlinear, complex patterns that other algorithms would normally be unable to incorporate. With such effectiveness, deep learning has changed entire industries, including self-driving cars, search engines, robotics, warfare, fashion, entertainment, finances, and many more.  

One field in which deep learning is having significant impact is electronic warfare. Electronic warfare is the division of warfare that uses the electromagnetic spectrum or energy to attack, protect, and control the electromagnetic spectrum. It has three components to achieve these goals - electronic attack (EA), electronic protection (EP), and electronic support (ES). In the communications portion of electronic warfare, electronic attacks consist of signal jamming, eavesdropping, as well as intercepting and sending false signals. Because signals are sent through the air, they are at risk of being detected, intercepted, and even exploited during transition. Recently, AI has been on the forefront of electronic warfare, in all three divisions (EA, EP, and ES), as this method has proven to be as effective, if not more, than traditional algorithm based approaches in multiple ways. First, AI based methods need less supervision, as the detection and interception is automatically handled by the network. Second, less expert based input is necessary because the network learns automatically with given data. Third, EA based on AI is more malleable and adaptive to strategy changes from the EP, because there aren't hardcoded rules to follow. For example, EP may decide to adapt to EA by transmitting completely new types of signals (which O'Shea demonstrated in "An Introduction to Deep Learning for the Physical Layer"), which static algorithms cannot adapt to, without expert input.

In this work, the power of AI for EA was demonstrated by applying a MRN to a radio signal dataset consisting of 11 different modulation types. Furthermore, the accuracy of the MRN was demonstrated in relation to a standard CNN, as well as a HOS based method. Results show that the MRN was able to 

## Method
<p align="center">
  <img src=""/>
</p>  
<p align="center"> 
   <em>Adversarial Autoencoder Network Architecture with Backpropagation</em></p>  
   
### Modified Residual Neural Network Architecture (In Order of Processing)
### Residual Unit Architecture (In Order of Processing)
### Residual Stack Architecture (In Order of Processing)

## Solution
Executing the code for 700 epochs of 16, 1024 sized batches resulted in a loss function shown in the graph below.
<p align="center">
  <img src=""/>
</p>  
<p align="center"> 
  <em></em></p>  

<p align="center">
  <img src=""/>
</p>  
<p align="center"> 
   <em></em></p>  
