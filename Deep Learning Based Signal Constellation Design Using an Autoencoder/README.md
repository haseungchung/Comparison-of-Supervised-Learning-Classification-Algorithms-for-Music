# Deep Learning Based Signal Constellation Design Using an Autoencoder

## Abstract
In this work, the results of Tim O'Shea's "An Introduction to Deep Learning for the Physical Layer" was replicated in Python using Keras with tensorflow backend. Wireless communication systems utilize complex algorithms based on mathematical intricate theorems and proofs to send and receive signals efficiently. The last layer for sending and the first layer for receiving signals in devices is the physical layer, where a lot of the physical formation of the signals take place. Such physical attributes include what energy level (amplitude) you use to transmit wirelessly on a cosine wave (the in-phase channel, I), and a sine wave (shifted 90 degrees from the in-phase channel, Q), to represent the bit data being sent. The possible messages that can be sent is known as its constellation diagram, mapping on a 2-D plot of the amplitude in the I channel, and the Q channel. Up until this point, the every part of the physical layer, including the constellation diagram design, has been designed using heavy mathematics and theorems, but Tim O'Shea approached it from a whole new method, using data driven deep learning to see how wireless systems can be trained end-to-end, without any expert information. The results showed that an autoencoder can model a transmitter as the encoder, and a receiver as the decoder, and learn constellation diagrams nearly identical to expert designs, and even outperform expert designs. Furthermore, Hamming code, which is an XOR based error correcting code for ensuring accurate message delivery despite noisy channels, could also be replicated using end-to-end deep learning method for an autoencoder. 

## Background 

### Part 1: Constellation Diagram for 4 Bit Messages (16 Total Possibilities)

The goal of a constellation diagram for 4 bit messages is to stay within a specific design constraint, while maximizing successful communication over noisy channels (the space between the transmitter and receiver). Intuitively, this means to space each constellation point as far as possible from the other points, so that even when noise in the channel distorts the received constellation point placement, it can be most accurately inferred (since the overlap between points+noise is minimized). The following constraints are explored, and the respective expert designed constellation diagram for each constraint is shown.

#### Design Constraints:
Given that ![x](https://latex.codecogs.com/png.image?\dpi{110}%20\textbf{x}) is a signal vector with ![i](https://latex.codecogs.com/png.image?\dpi{110}%20i) components, ![xi](https://latex.codecogs.com/png.image?\dpi{110}%20x_{i}), the following are constraints for constellation diagrams.  

1. Amplitude Constraint -  
<p align="center">
  <img src="https://latex.codecogs.com/png.image?\dpi{110}%20\left|x_{i}%20\right|\leq%201\forall%20i"/>
</p>  
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/153101185-7a3ad3cc-1704-4494-b1d7-673874cb6683.png"/>
</p>  
<p align="center"> 
  16-QAM diagram, which follows the amplitude constraint <br><em>https://commons.wikimedia.org/w/index.php?curid=1322082</em></p>  

2. Energy Constraint - 
<p align="center">
  <img src="https://latex.codecogs.com/png.image?\dpi{110}%20\left\|\mathbf{x}%20\right\|_{2}^{2}\leq%20n"/>
</p>  
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/153102451-bdfe2754-a708-4f18-818e-45c868dc1be9.png"/>
</p>  
<p align="center"> 
  16-PSK diagram, which follows the energy constraint <br><em>https://www.researchgate.net/figure/Gray-mapped-16-PSK-constellation-with-radius-c_fig3_3162047</em></p>  

3. Average Power Constraint -  
There is no representative constellation diagram in the industry for this constraint. From personal intuition, I believe it can be attributed to its lack of use. There aren't many real world scenarios that strictly require over other constraints, and there is not a well established theoretically optimized mapping for itk. 
<p align="center">
  <img src="https://latex.codecogs.com/png.image?\dpi{110}%20\mathbb{E}\left%20[%20\left|%20x_{i}^{2}%20\right|%20\right%20]%20\leq%201%20%20%20\forall%20i"/>
</p>  



### Part 2: Hamming Code 

The Hamming Code is a type of error correcting code, where a 4 bit message is sent with 3 extra "parity" bits that can correct for an error of 1 bit. This means that if only 6 bits are communicated correctly, the receiver can deduce the message with only those bits. The Hamming code is commonly used for accurate communication over noisy channels, and is proven to be optimal for the amount of total bits used (7). The parity bits are determined by using XOR logic, each parity bit performing a XOR calculation on a unique combination of 3 of the 4 message bits.
For example, for parity bit 1 and message bits 1,2,4, ![p1](https://latex.codecogs.com/png.image?\dpi{110}%20p_{1}=d_{1}%20\oplus%20%20d_{2}%20\oplus%20d_{4}). The general relationship can be summarized in the following figure
<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/b/b0/Hamming%287%2C4%29.svg"/>
</p>  
<p align="center"> 
  Hamming code (7,4) diagram, with message bits d, and parity bits p<br><em>https://commons.wikimedia.org/w/index.php?curid=1511411</em></p>  


## Method

Using the method described in Tim O Shea's work (as seen in the figure below), the neural network architecture of the autoencoder was built. 
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/153123477-4fcb90c3-2deb-4581-b675-2a4265250fbb.png"/>
</p>  
<p align="center"> 
  Autoencoder neural network architecture<br><em>https://arxiv.org/pdf/1702.00832.pdf</em></p>  
  
As described in the figure, our network was made such that...  
  
  
1. A 4 bit message was transformed into a 16 dimension one-hot vector and sent to the transmitter (encoder).
2. The message was processed through multiple dense layers in the encoder, and then normalized.
3. Our transmitter (encoder) portion of the autoencoder was to output a signal given a specific constraint.
4. The signal is corrupted by channel noise (modeled as additive white Gaussian noise [AWGN]) 
5. The signal + noise is received by the receiver.
6. The signal + noise is processed through multiple dense layers, and then activated via a softmax activation to predict the original message.  

In part 1, our input vector was 4 bits, and our signal was two dimensional, corresponding to the I channel amplitude and the Q channel amplitude. The amplitudes were also given specific constraints depending on the design constraints (average power, amplitude, and energy). The AWGN noise level that we used for corresponded to a SNR of 7dB, which indicates a fairly clean channel.

In part 2, our input vector was also 4 bits, but our output vector was 7 bits, which corresponds to 7 different messages being sent on the I channel serially, as a Hamming code does. The noise level was varied from very high to very low (dB ~ dB) to test the BER (bit error rate) performance of the deep learning based system against that of the Hamming code. 

In both cases, the networks were trained end-to-end. This means that after setting up the network, data just had to be put into the encoder, read from the decoder output, and then trained based on error between them. And in this case, the the input data was also the desired output, so all data could be made in-house using a random number generator. For training the network used a batch size of 1024 for 30 epochs, trained with backpropagation using the ADAM optimizer set to a learning rate of 0.003. 

## Solution

### Part 1:

1. Amplitude Constraint -  
The amplitude constraint was enforced at the encoder's final layer, limiting both the I channel and Q channel values to be a maximum value of 1. This was done through an activation function that ensured plotting within the acceptable range, and achieved a constellation diagram very similar to the 16-QAM diagram.
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/153977023-4fa89d4f-d76c-490d-80e2-9abd77b1f19f.png"/>
</p>  

2. Energy Constraint -
The amplitude constraint was enforced at the encoder's final layer, limiting both the I channel and Q channel values to be have a combined energy 1 (the square root of the addition of the two values, squared). This helped the system to achieve a constellation diagram very similar to the 16-PSK diagram but with an arbitrary rotation.
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/153695738-cb597e52-a48b-4f35-9bdd-ecef98cbc2a8.png"/>
</p>  

3. Average Power Constraint - 
The average constraint was enforced at the autoencoder's loss function, where it was heavily penalized if the energy of the signal exceeded 1. This encouraged the system to learn to keep everything within a radius of 1 from the origin, and created a constellation diagram that seems to achieve maximum distance between the points through a stacked pentagon-like shape.  
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/153976952-f69ab792-69a2-46a8-a615-d083394ef844.png"/>
</p>  

### Part 2:

Using the method mentioned in the previous section, the performance of the autoencoder is shown in comparison to the performance of the Hamming code performance for various signal to noise (SNR) levels. The results were identical, indicating that the autoencoder learned a form of error correcting code with the same performance as the Hamming code.
