# Machine Learning and Deep Learning Projects

## Introduction:
This repository serves as a portal into the various machine learning and deep learning projects that I have done and am doing. In terms of timeline, these projects range from 2017 to the present, and my hope is that they showcase my growth, versatility, and aptitude as an AI engineer.  

You can scroll through this page to read short descriptions of each project, or click the respective links in the titles (in both the project list section and the project summary section.  

## Project List Sorted by Newest to Oldest:

1. Real Time Posture Detection and Correction Using the Yolov3 Algorithm and a Residual Neural Network 
2. Residual Neural Network for Communication Signal Classification
3. Adversarial Autoencoder (GAN + Autoencoder) Network for Achieving Communication Signal Encryption
4. Deep Learning Based Signal Constellation Design Using an Autoencoder
5. Pose Estimation of a Robotic Arm via Resistive Stress Sensors and Supervised Learning
6. Prediction of H1B Visa Approval using Machine Learning Algorithms
7. Comparison of Supervised Learning Classification Algorithms for Music  

## Project Summaries:

### 1. Real Time Posture Detection and Correction Using the Yolov3 Algorithm and a Residual Neural Network - current  

In this personal project inspired by my desire to improve my sitting posture, the objectives were to
1. Detect a person in the frame
2. Focus in on the person and then detect their posture
3. Send feedback to the user in live time to alert them when posture is poor  

The plan to accomplish these goals are to first run a yolov3 object detection algorithm to detect a person in the frame, and then use a cropped image of the person to detect their posture using a residual neural network. Based on these results, the program is to alert the user of poor posture in an annoying way, such that he or she fixes it. So far, the yolov3 object detection algorithm with pretrained weights have been successfully applied. I am currently working on producing data to train a residual neural network for posture detection.

### [2. Residual Neural Network for Communication Signal Classification - 2020](Residual%20Neural%20Network%20for%20Communication%20Signal%20Classification) 
In this work, Tim O'Shea's residual neural network from "Over the Air Deep Learning Based Radio Signal Classification" was replicated, and applied to the Radio ML 2016c dataset of 11 different signal modulations. Results confirmed higher classification accuracy for the residual neural network than conventional convolutional neural networks due to more information being retained through skip connections in the network.

### [3. Adversarial Autoencoder (GAN + Autoencoder) Network for Achieving Communication Signal Encryption - 2019](Adversarial%20Autoencoder%20(GAN%20%2B%20Autoencoder)%20Network%20for%20Achieving%20Communication%20Signal%20Encryption)
Inspired by Abadi's "Learning to Protect Communications with Adversarial Neural Cryptography" and O'Shea's autoencoder model from "An Introduction to Deep Learning for the Physical Layer", this work models an adversarial autoencoder, where a transmitter, Tx, is the encoder, a receiver, Rx, is the decoder, and an eavesdropper, Eve, tries to eavesdrop on Tx's message. The objective of this work was to have the Tx learn to create communication signals that the Rx can understand without the eavesdropper being able to in a semi-supervised manner. Given a random 2-bit message for the Tx, and an 8-bit key known to the Tx and Rx, The Tx-Rx system was able to send and receive signals with ~100% accuracy with the eavesdropper having little success (43% accuracy, close to the 50% accuracy goal).

### [4. Deep Learning Based Signal Constellation Design Using an Autoencoder - 2019](Deep%20Learning%20Based%20Signal%20Constellation%20Design%20Using%20an%20Autoencoder)
In this work, the results of Tim O'Shea's "An Introduction to Deep Learning for the Physical Layer" was replicated in Python using Keras. We essentially modeled a transmitter-receiver pair as an autoencoder, to accomplish two goals...
1. Have the transmitter (encoder) learn to create communication signals given specific constraints out of bit data messages
2. Have the receiver (decode) learn to receive and decode the messages into the original bit data messages, with additional noise from the environment  

The trained autoencoder designed signals that greatly resembled existing theory based communication signals, i.e. phase shift keying and quadrature amplitude modulation for the energy constraint and amplitude constrant, respectively. For an average energy constraint it was able to create more efficient signal patterns than existing patterns (16 QAM).

### [5. Pose Estimation of a Robotic Arm via Resistive Stress Sensors and Supervised Learning - 2018](Pose%20Estimation%20of%20a%20Robotic%20Arm%20via%20Resistive%20Stress%20Sensors%20and%20Supervised%20Learning)
This work explored a possible method of pose estimation that is both biomimetric and compatible with soft-body robotics. For an example case, a robotic arm is affixed with segments of carbon-impregnated silicone cords, serving as resistive stretch sensors. By employing various machine learning algorithms in the form of least squares regression (LSR) and random forest regression (RFR) we have developed a method for resistance readings through the stretch sensors to joint angles of the robotic arm. RFR the best of the two methods, yielding average errors for the two explored angles of 0.43 and 0.58%. These results suggest that these silicone sensors would be suitable for implementation in a soft-bodied robot.  

### [6. Prediction of H1B Visa Approval Using Machine Learning Algorithms - 2018](Prediction%20of%20H1B%20Visa%20Approval%20Using%20Machine%20Learning%20Algorithms)
In this work, the accuracies of various supervised learning classification algorithms under different preprocessing methods were investigated for H1-B Employment Applications. A dataset of 27932 cases of H1B applications with their case statuses (labels) were used, first being preprocessed through singular value decomposition (SVD) or kept as raw categorical data. The data was then trained separately using the Naïve Bayes method (NB), the K nearest neighbors method (Knn), and the classification trees method (CART). These models were then tested for the classification accuracy. The results showed that all classification methods were more accurate when preprocessed with SVD except the CART method. CART was most accurate, followed by Knn with SVD, NB with SVD, Knn without SVD, and then finally NB without SVD. All analysis was carried out with MATLAB and its programming language and computational algorithms.  

### [7. Comparison of Supervised Learning Classification Algorithms for Music - 2018](Comparison%20of%20Supervised%20Learning%20Classification%20Algorithms%20for%20Music)
In this work, the accuracies of three, supervised machine learning classification algorithms is investigated and explored for different sets of music as follows...
1. From three different artists of different genres
2. From three different artists from the same genre
3. From various songs from three different genres  

For each set, using three, five-second clips from each of 20 songs for each of the three different groups, the data was preprocessed through spectrogram and through singular value decomposition (SVD). The data is then trained separately using the Naïve Bayes method (NB), support vector machine method (SVM), and classification tree method (CART). These models are then tested against five second clips of five songs of each group to test the classification accuracy. The results show that for songs that are processed as spectrograms with SVD, CART was most accurate, followed by SVM, and then by Naïve Bayes, which was no better than a random guess. All analysis was carried out with MATLAB and its programming language and computational algorithms.
