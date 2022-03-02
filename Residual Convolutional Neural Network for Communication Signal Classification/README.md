# Residual Neural Network for Communication Signal Classification

## Abstract
This work was inspired by Tim O'Shea's "Over the Air Deep Learning Based Radio Signal Classification" [1].

In electronic warfare, the electronic attack division is tasked with attacking and disrupting enemy signals via detection, interception, and exploitation (in that order). Traditionally, detection and interception was done through man-made mathematical algorithms, and the game between attackers and protectors leaned in favor of the protectors, especially when it came to energy efficiency. However, artificial intelligence (AI) has recently been on the forefront of disrupting the field of electronic attack, proving to be efficient in intercepting enemy signals [1],[2]. In this work, the modified residual network (MRN) architecture from [1] was recreated and its accuracy in classifying signal modulation types was compared to that of [2]. Results demonstrated the MRN outperformed the CNN, showing that deep learning algorithms can be very effective in signal modulation classification, and that the residual neural network structure was superior to others in this task.

## Introduction

Artificial intelligence (AI) is a broad field of computer science that is focused on creating intelligent machines that can mimic human intelligence and behavior artificially. Within AI, there is a subfield called machine learning, which is concerned with using data to train computer algorithms to recognize patterns and extract features from data without any explicit instructions or programming. Until recently, machine learning was unpopular because hardware could not practically handle the complex computations necessary to train these algorithms. However, with the advances in high performance computing hardware and software, the field of machine learning is experiencing a revival of sorts, with one particular branch, called deep learning, proving to be exceptionally groundbreaking. By using multiple layers of "neurons" to learn patterns and extract features from data, the algorithm is able to pick up on highly nonlinear, complex patterns that other algorithms would normally be unable to incorporate. With such effectiveness, deep learning has changed entire industries, including self-driving cars, search engines, robotics, warfare, fashion, entertainment, finances, and many more.  

One field in which deep learning is having significant impact is electronic warfare. Electronic warfare is the division of warfare that uses the electromagnetic spectrum or energy to attack, protect, and control the electromagnetic spectrum. It has three components to achieve these goals - electronic attack (EA), electronic protection (EP), and electronic support (ES). In the communications portion of electronic warfare, electronic attacks consist of signal jamming, eavesdropping, as well as intercepting and sending false signals. Because signals are sent through the air, they are at risk of being detected, intercepted, and even exploited during transition. Recently, AI has been on the forefront of electronic warfare, in all three divisions (EA, EP, and ES), as this method has proven to be as effective, if not more, than traditional algorithm based approaches in multiple ways. First, AI based methods need less supervision, as the detection and interception is automatically handled by the network. Second, less expert based input is necessary because the network learns automatically with given data. Third, EA based on AI is more malleable and adaptive to strategy changes from the EP, because there aren't hardcoded rules to follow. For example, EP may decide to adapt to EA by transmitting completely new types of signals (which O'Shea demonstrated in [3]), which static algorithms cannot adapt to, without expert input.

In this work, the power of AI for EA was demonstrated by applying a MRN to a radio signal dataset consisting of 11 different modulation types. Furthermore, the accuracy of the MRN was demonstrated in relation to a standard CNN (which had the best results from [2]). Results show that the MRN was able to outperform the CNN from [2], by ~10% in the higher SNR ratios.

## Method

### Dataset

The dataset for this work was the RadioML 2016.10A dataset, consisting of 8 digital and 3 analog radio signal modulation types with varying signal-to-noise (SNR) ratios from -20 dB to 20 dB normalized around 0 dB. Each modulation had 20,000 examples of the I and Q channel values, and were 128 micro seconds long (128 samples of signals per example). The overall dimension of the dataset was therefore (220000, 2, 128). 80% of the total dataset was used for training (68%) and validation (12%), and 20% for testing. 

### Convolutional Neural Network

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/155808802-0a1d8d20-384d-45ba-a98a-5059dd5f54a5.png"/>
</p>  
<p align="center"> 
   <em>Convolutional neural network layout <br> https://arxiv.org/pdf/1712.04578.pdf </em></p>  

Initially in "Convolutional Radio Modulation Recognition Networks", a convolutional neural network with the network shown above was used to show that the CNN architecture can learn to classify radio modulation types very accurately, better than classic machine learning algorithms such as state vector machine (SVM), K nearest neighbors (KNN), Naive Bayes (NB), decision tree (DTree), and Deep Neural Networks (DNN [densely connected]). The results can be seen in the figure below

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/155811229-708f9a8b-23b8-412c-8bbf-bf8518689ad7.png"/>
</p>  
<p align="center"> 
   <em>Results from "Convolutional Radio Modulation Recognition Networks" <br> https://arxiv.org/pdf/1712.04578.pdf </em></p>  
   
At the time of its publication, the CNN was a highly advanced model for deep learning based classification, but did have some issues. For example, vanishing gradients caused some nodes to fail to update, due to the gradient becoming too small by the time it reaches its layer. Another issue was with local minima, in which the network would converge to a non optimal solution, and then become "stuck" in it, unable to search for more accurate solutions.

### Modified Residual Neural Network

By the time O'Shea's [1], the field of deep learning had greatly improved models than the CNN from 2016. One such solution was called residual neural networks, a network that utilized skip connections between layers to make sure that the aforementioned problems from the CNN were solved. Skip connections allowed layers to have non-vanishing gradients by being closer in connection to the error function (at the end of the network), and changed the topography of gradient descent to have less local minima and a more prominent global minimum. 

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/155812250-1beaed78-bf02-4cc8-a6d6-baf9ad0db399.png"/>
</p>  
<p align="center"> 
   <em> The "loss surface", or the gradient descent topography of networks without skip connections (left) and with skip connections (right). <br> https://arxiv.org/pdf/1712.09913.pdf </em></p>  

This discovery in the field of deep learning was utilized by O'Shea for [1], by testing a residual network to classify radio signals. In my project, I repeated the network architecture from [1], and applied it to an older dataset to compare results against the CNN from [2]. The network utilized skip connections in "residual units", and the network architecture is shown below.

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/155807682-b723dff4-7acc-4f2e-9c4b-1a4ce135c753.png"/>
</p>  
<p align="center"> 
   <em>Residual Network Architecture Layout <br> https://arxiv.org/pdf/1712.04578.pdf </em></p>  
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/155812761-590b7065-798c-49f5-8cf3-cef01de1c70d.png"/>
</p>  
<p align="center"> 
   <em>Residual Unit (top) and Residual Stack (bottom) Architecture <br> https://arxiv.org/pdf/1712.04578.pdf </em></p>  

## Solution
Executing the code for 35 epochs of 147, 1024 sized batches resulted in a loss function shown in the graph below.
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156303540-3fe13c14-96ec-4ac6-b87e-c8e1a276d91c.png"/>
</p>  
<p align="center"> 
  <em>Training Performance of MRN from [1] in on RadioML 2016.10A Dataset</em></p>  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156302608-ccf00473-5bb1-46af-93e3-e127f553138d.png"/>
</p>  
<p align="center"> 
  <em>Classification Accuracy Performance of MRN from [1] and CNN from [2] in Classifying Signals from the RadioML 2016.10A Dataset</em></p>  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156303014-db784b24-577e-466f-a97b-99188ef066b9.png"/>
</p>  
<p align="center">
   <em>Confusion Matrix of MRN at SNR=0dB (Signal to Noise Ratio = 1:1)</em></p>  

We can also see from the training performance that the validation accuracy was starting to flatten, indicating that further training could either risk overfitting and/or not helpful, meaning that further epochs were not necessary. After the training sequence, we were able to see and confirm that the MRN was more accurate across the SNR spectrum, having better accuracy than the CNN (whose results were taken directly from [2]). An example of the confusion matrix at SNR=0dB further helps to visually show the accuracy of the MRN, being mostly accurate throughout the different modulation types, except 16-QAM and WBFM. Given more data (and a better division of training, validation, and test data), perhaps the accuracy could get even higher, since larger networks work better with more nontrivial data. 


## References
[1] T. J. O’Shea, T. Roy, and T. C. Clancy, “Over-the-air deep learning based radio signal classification,” IEEE Journal of Selected Topics in Signal Processing, vol. 12, pp. 168–179, Feb 2018.  
[2] T. J. O’Shea, J. Corgan, and T. C. Clancy, “Convolutional radio modulation recognition networks,” in Proc. Int. Conf. Eng. Applications of Neural Networks. Springer, 2016, pp. 213–226.  
[3] T. O'Shea and J. Hoydis, “An introduction to deep learning for the physical layer”. IEEE Transactions on Cognitive Communications and Networking, 2017.
