# Adversarial Autoencoder (GAN + Autoencoder) Network for Achieving Communication Signal Encryption

## Abstract
This work was inspired by Abadi's "Learning to Protect Communications with Adversarial Neural Cryptography" and O'Shea's autoencoder model from "An Introduction to Deep Learning for the Physical Layer".  

In wireless communications, signals are ofteen at risk of being detected, intercepted, and even exploited (eavesdropped) by a malicious party. In order to prevent exploitation, many trasmitter(Tx) and receivers(Rx) choose to encrypt their signals, commonly with a key that only the two players know. In practice, this can be through static keys, or through dynamic keys, which may update on conditions such as time, signal types, etc... In this work, we choose to model a Tx, Rx, and eavesdropper (Eve) as an adversarial autoencoder, where the Tx is the encoder who wishes to send encrypted messages to Rx (the decoder), all the while as Eve tries to eavesdrop and decrypt these messages. Through a semi-supervised learning method, the autoencoder was able to learn to create communication signals bit data messages (2 bits) that the Rx can understand (~100% accuracy) without the eavesdropper decrypting messages (~50% ccuracy) by creating its own ecryption method from a shared key (8 bits).  

## Background 
Artificial intelligence (AI) is a broad field of computer science that works with making intelligent machines that can mimic human intelligence and behavior artificially. Within AI, there is a field called machine learning, which is concerned with using data to train computer algorithms to recognize patterns and extract features from data without any explicit programming. Deep learning is a type of machine learning that uses multiple layers of "neurons" to learn patterns and extract features from data. Unlike classic/traditional machine learning algorithms, deep learning excels in learning highly nonlinear data, but typically requires much more data to reliably learn. With the advances in high performance computing hardware and software, deep learning, which was at one time too mathematically intensive to use practically, it has now changed entire industries, and assimilated into the lives of people around the world. Such examples include self-driving cars, facial recognition in surveillance and cameras, and recommendation algorithms for search engines, streaming sites, and shopping sites, 






Just as in both Abadi's work and Tim O'Shea's work, the approach to this work differed from traditional wireless communications in that instead of approaching with well established theory, we allowed a neural network to learn to accomplish it

## Method

## Solution
