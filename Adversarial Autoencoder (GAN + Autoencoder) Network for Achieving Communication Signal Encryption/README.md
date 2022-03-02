# Adversarial Autoencoder (GAN + Autoencoder) Network for Achieving Communication Signal Encryption

## Abstract
This work was inspired by Abadi's "Learning to Protect Communications with Adversarial Neural Cryptography" [1] and O'Shea's autoencoder model from "An Introduction to Deep Learning for the Physical Layer" [2].  

In wireless communications, signals are often at risk of being detected, intercepted, and even exploited (eavesdropped) by a malicious party. In order to prevent exploitation, many trasmitters (Tx) and receivers (Rx) choose to encrypt their signals, commonly with a key that only the two players know. In practice, this can be through static keys, or through dynamic keys, which may update on conditions such as time, signal types, etc... In this work, we choose to model a Tx, Rx, and eavesdropper (Eve) as an adversarial autoencoder, where the Tx is the encoder who wishes to send encrypted messages to Rx (the decoder), all the while as Eve tries to eavesdrop and decrypt these messages. Through supervised learning, the autoencoder was able to learn to create communication signals bit data messages (2 bits) that the Rx can understand (~100% accuracy) without the eavesdropper decrypting messages (43% ccuracy) by creating its own ecryption method from a shared key (8 bits).  

## Introduction
Artificial intelligence (AI) is a broad field of computer science that is focused on creating intelligent machines that can mimic human intelligence and behavior artificially. Within AI, there is a subfield called machine learning, which is concerned with using data to train computer algorithms to recognize patterns and extract features from data without any explicit instructions or programming. Until recently, machine learning has been unpopular because hardware could not practically handle the complex computations necessary to train these algorithms. However, with the advances in high performance computing hardware and software, the field of machine learning is experiencing a revival of sorts, with one particular branch, called deep learning, proving to be exceptionally groundbreaking. By using multiple layers of "neurons" to learn patterns and extract features from data, the algorithm is able to pick up on highly nonlinear, complex patterns that other algorithms would normally be unable to incorporate. With such effectiveness, deep learning has changed entire industries, including self-driving cars, search engines, robotics, warfare, fashion, entertainment, finances, and many more.  

One field in which deep learning is making serious impact is wireless communication systems. Historically, this field has built itself on complex mathematical proofs and theorems, and utilizes well established "best practices" to build networks of highly effective communications systems. However, in [2], Tim O'Shea demonstrated a completely different way to approach wireless communication systems, particularly on the physical layer. By using deep learning, he demonstrated that a transmitter (Tx) - receiver (Rx) system could be modeled as a deep learning neural network (autoencoder), and teach the system using data alone without any other expert input or oversight. He successfully demonstrated its ability to mimic expert based constellation diagrams, such as the 16-PSK, 16-QAM, as well as replicating the efficiency of the Hamming code under the same parameters.  

Similarly in [1], an adversarial autoencoder system was modeled in which an encoder (Alice) delivers a message to a decoder (Bob) in the presence of a malicious eavesdropper (Eve). He was able to demonstrate that if Alice and Bob shared a secret key, they could automatically learn to encrypt their messages such that Bob could understand Alice's messages, while Eve couldn't. 

Building on the success of [1] and [2], this work demonstrates that a Tx-Rx communication system with a noisy channel can be modeled as an autoencoder against a malicious eavesdropper and learn to encrypt their signals given a secret key shared between the Tx-Rx pair only. 

## Method
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/155038773-3f0f9674-ef18-4b17-ae2b-fc6b36f9e05d.png"/>
</p>  
<p align="center"> 
   <em>Adversarial Autoencoder Network Architecture with Backpropagation</em></p>  

The high-level design of the adversarial autoencoder similar to that of [1] was implemented in this work, as shown in the figure above. In this work, the Tx took the role of Alice, the Rx took the role of Bob, and the eavesdropper's role remained the same. Furthermore, the k represents a 2-bit message that is being communicated, the key vector is a 8 bit secret key that is known to only the Tx-Rx pair, and the channel is an AWGN (Additive White Gaussian Noise) channel with 10dB. The encoder outputs a two dimensional message with a maximum energy of 1 per component.  

What is also highlighted in the diagram are the backpropagation paths that the network goes through to update itself (via weight updating). More specifically, the training sequence is as follows:

### Training Sequence (per batch)
1. A 2 bit message and a secret key is input to the Tx (encoder).
2. The message + key is processed through three dense layers in the encoder and outputs a 2 dimensional message.
3. The signal is corrupted by channel noise (modeled as additive white Gaussian noise [AWGN]).
4. The signal + noise is received by the Rx (the Rx [decoder] is assumed to know the key perfectly).
5. The signal + noise is processed through three dense layers of the decoder, and then activated via a tanh activation to predict the original bit message.  
6. Using the difference between the receiver's recovered message and the original message, the weights of the Tx-Rx autoencoder (without Eve) are updated.
7. Steps 1-3 are repeated.
8. The signal + noise is received by Eve (without any knowledge of the key).
9. The signal + noise is processed through four dense layers of the Eve, and then activated via a tanh activation to predict the original message.  
10. Using the difference between Eve's recovered message and the original message, the weights of Eve are updated (Tx's weights are frozen during this portion to make sure the Tx doesn't update according to the results of Eve).
11. Steps 7-10 are repeated (Eve is trained twice every time Tx-Rx is trained once, to ensure the Eve has a training advantage).

## Solution
Executing the code for 700 epochs of 16, 1024 sized batches resulted in a loss function shown in the graph below.
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/154609061-90bb066f-5a06-4d4d-bbaa-4294c98a6d8b.png"/>
</p>  
<p align="center"> 
  <em>Loss Function Values for all 700 epoches of 16, 1024 sized batches (11,200 total iterations) in the training sequence</em></p>  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/154606990-644fc5bb-c3e3-4419-b39c-c17e7500d564.png"/>
</p>  
<p align="center"> 
   <em>Loss Function Values for the first 500 iterations in the training sequence</em></p>  
  
At the very beginning of the training sequence, Eve was able to decrypt the Tx's message better than the Rx, but shortly after, around 150~200 iterations, the Tx-Rx system started outperforming Eve. After Tx-Rx learned to encrypt their messages, Eve essentially hovered at a loss value of 1 (which indicates an optimal ~50% error rate), while the Tx-Rx system hovered near 0 (~100% accuracy). The finals results support this claim, as a test case of 10000 messages showed that Tx-Rx was able to communicate with 100% accuracy, while Eve was able to figure out 43.49% of all bits in the messages. It is also worth noting that Eve is updated twice every time that Tx-Rx is updated, which is to ensure if Eve is unable to decrypt Tx-Rx's messages, it can only be attributed to its failure to decrypt the encrypted messages, and not because Tx-Rx is training "faster" than it.

## References
[1] M. Abadi and D. Andersen, "Learning to protect communications with adversarial neural cryptography". In Proc. International Conference on Learning Representations (ICLR), 2017.
[2] T. O'Shea and J. Hoydis, “An introduction to deep learning for the physical layer”. IEEE Transactions on Cognitive Communications and Networking, 2017.
