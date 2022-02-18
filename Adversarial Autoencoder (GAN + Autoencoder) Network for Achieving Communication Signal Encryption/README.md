# Adversarial Autoencoder (GAN + Autoencoder) Network for Achieving Communication Signal Encryption

## Abstract
This work was inspired by Abadi's "Learning to Protect Communications with Adversarial Neural Cryptography" and O'Shea's autoencoder model from "An Introduction to Deep Learning for the Physical Layer".  

In wireless communications, signals are ofteen at risk of being detected, intercepted, and even exploited (eavesdropped) by a malicious party. In order to prevent exploitation, many trasmitter(Tx) and receivers(Rx) choose to encrypt their signals, commonly with a key that only the two players know. In practice, this can be through static keys, or through dynamic keys, which may update on conditions such as time, signal types, etc... In this work, we choose to model a Tx, Rx, and eavesdropper (Eve) as an adversarial autoencoder, where the Tx is the encoder who wishes to send encrypted messages to Rx (the decoder), all the while as Eve tries to eavesdrop and decrypt these messages. Through supervised learning, the autoencoder was able to learn to create communication signals bit data messages (2 bits) that the Rx can understand (~100% accuracy) without the eavesdropper decrypting messages (~50% ccuracy) by creating its own ecryption method from a shared key (8 bits).  

## Introduction
Artificial intelligence (AI) is a broad field of computer science that is focused on creating intelligent machines that can mimic human intelligence and behavior artificially. Within AI, there is a subfield called machine learning, which is concerned with using data to train computer algorithms to recognize patterns and extract features from data without any explicit instructions or programming. Until recently, machine learning was unpopular because hardware could not practically handle the complex computations necessary to train these algorithms. However, with the advances in high performance computing hardware and software, the field of machine learning is experiencing a revival of sorts, with one particular branch, called deep learning, proving to be exceptionally groundbreaking. By using multiple layers of "neurons" to learn patterns and extract features from data, the algorithm is able to pick up on highly nonlinear, complex patterns that other algorithms would normally be unable to incorporate. With such effectiveness, deep learning has changed entire industries, including self-driving cars, search engines, robotics, warfare, fashion, entertainment, finances, and many more.  

One field in which deep learning could have serious implications is wireless communication systems. Historically, this field has built itself on complex mathematical proofs and theorems, and utilizes well established "best practices" to build networks of highly effective communications systems. However, in "An Introduction to Deep Learning for the Physical Layer", Tim O Shea demonstrated a completely different way to approach wireless communication systems, particularly on the physical layer. By using deep learning, he demonstrated that a transmitter (Tx) - receiver (Rx) system could be modeled as a deep learning neural network (autoencoder), and teach the system using data alone without any other expert input or oversight. He successfully demonstrated its ability to mimic expert based constellation diagrams, such as the 16-PSK, 16-QAM, as well as replicating the efficiency of the Hamming code under the same parameters.  

Similarly in Abadi's work, an adversarial autoencoder system was modeled in which an encoder (Alice) delivers a message to a decoder (Bob) in the presence of a malicious eavesdropper (Eve). He was able to demonstrate that if Alice and Bob shared a secret key, they could automatically learn to encrypt their messages such that Bob could understand Alice's messages, while Eve couldn't. 

Building on the success of Abadi and O'Shea's works, this work demonstrates that a Tx-Rx communication system with a noisy channel can be modeled as an autoencoder against a malicious eavesdropper and learn to encrypt their signals given a secret key shared between the Tx-Rx pair only. 

## Method
The high-level design of the adversarial autoencoder structure from Abadi's work was implemented in this work, as shown in the figure below. In this work, the Tx took the role of Alice, the Rx took the role of Alice, and the eavesdropper's role remained the same. Furthermore, the P represents a 2-bit message that is being communicated, the K represents a 8 bit secret key that is known to only the Tx-Rx pair, and C represents an additive white Gaussian channel with a 7dB signal to noise ratio. 

For low-level design, the Tx-Rx structure was similar to that of the autoencoder structure from O'Shea's work, as shown in the figure below.  


As described in the figure, our network was made such that...

1. A 2 bit message and the secret key is input to the Tx (encoder).
2. The message was processed through three dense layers in the encoder and outputs a 2 dimensional message.
3. The signal is corrupted by channel noise (modeled as additive white Gaussian noise [AWGN]).
4. a) The signal + noise is received by the eavesdropper.  
   b) The signal + noise + key is received by the receiver.
5. a) The signal + noise is processed through three dense layers of the receiver, and then activated via a tanh activation to predict the original bit message.  
   b) The signal + noise is processed through four dense layers of the eavesdropper, and then activated via a tanh activation to predict the original message.  

## Solution
Executing the code for 700 epochs of 16, 1024 sized batches resulted in a loss function shown in the graph below.
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/154606632-20b83801-54df-45fe-8e6e-61ee37738cd7.png"/>
</p>  
<p align="center"> 
  Loss Function Values for all 700 epoches of 16, 1024 sized batches in the training sequence</p>  
  
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/154606990-644fc5bb-c3e3-4419-b39c-c17e7500d564.png"/>
</p>  
<p align="center"> 
  Loss Function Values for the first 200 iterations in the training sequence.</p>  
  
At the very beginning of the training sequence, Eve was able to decrypt the Tx's message better than the Rx, but shortly after, around 150~200 iterations, the Tx-Rx system started outperforming Eve. After Tx-Rx learned to encrypt their messages, Eve essentially hovered at a loss value of 1 (which indicates an optimal ~50% error rate), while the Tx-Rx system hovered near 0 (~100% accuracy). The finals results support this claim, as a test case of 10000 messages showed that Tx-Rx was able to communicate with 100% accuracy, while Eve was able to figure out 43.49% of all bits in the messages.
