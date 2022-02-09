# Deep Learning Based Signal Constellation Design Using an Autoencoder

## Abstract
In this work, the results of Tim O'Shea's "An Introduction to Deep Learning for the Physical Layer" was replicated in Python using Keras with tensorflow backend. Wireless communication systems utilize complex algorithms based on mathematical intricate theorems and proofs to send and receive signals efficiently. The last layer for sending and the first layer for receiving signals in devices is the physical layer, where a lot of the physical formation of the signals take place. Such physical attributes include what energy level (amplitude) you use to transmit wirelessly on a cosine wave (the in-phase channel), and a sine wave (shifted 90 degrees from the in-phase channel), to represent the bit data being sent. The possible messages that can be sent is known as its constellation diagram, mapping on a 2-D plot of the amplitude in the in-phase channel, and the 90 degrees shifted channel. Up until this point, the every part of the physical layer, including the constellation diagram design, has been designed using heavy mathematics and theorems, but Tim O'Shea approached it from a whole new method, using data driven deep learning to see how wireless systems can be trained end-to-end, without any expert information. The results showed that an autoencoder can model a transmitter as the encoder, and a receiver as the decoder, and learn constellation diagrams nearly identical to expert designs, and even outperform expert designs. Furthermore, Hamming code, which is an XOR based error correcting code for ensuring accurate message delivery despite noisy channels, could also be replicated using end-to-end deep learning method for an autoencoder. 

## Method

### Part 1: Constellation Diagram for 4 Bit Messages (16 Total Possibilities)

The goal of a constellation diagram for 4 bit messages is to stay within a specific design constraint, while maximizing successful communication over noisy channels (the space between the transmitter and receiver). Intuitively, this means to space each constellation point as far as possible from the other points, so that even when noise in the channel distorts the received constellation point placement, it can be most accurately inferred (since the overlap between points+noise is minimized). The following constraints are explored, and the respective expert designed constellation diagram for each constraint is shown.

#### Design Constraints:
Given that ![x](https://latex.codecogs.com/png.image?\dpi{110}%20\textbf{x}) is a signal vector with ![i](https://latex.codecogs.com/png.image?\dpi{110}%20i) components, ![xi](https://latex.codecogs.com/png.image?\dpi{110}%20x_{i}), the following are constraints for constellation diagrams.

1. Average Power Constraint -  
For this constraint, there is no industry representative constellation diagram from the field, due to its unpopularity (there aren't many real world scenarios that strictly require it), as well as lack of a theoretically optimized mapping. 
<p align="center">
  <img src="https://latex.codecogs.com/png.image?\dpi{110}%20\mathbb{E}\left%20[%20\left|%20x_{i}^{2}%20\right|%20\right%20]%20\leq%201%20%20%20\forall%20i"/>
</p>  

2. Amplitude Constraint -  
<p align="center">
  <img src="https://latex.codecogs.com/png.image?\dpi{110}%20\left|x_{i}%20\right|\leq%201\forall%20i"/>
</p>  
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/153101185-7a3ad3cc-1704-4494-b1d7-673874cb6683.png"/>
</p>  
<p align="center"> 
  16-QAM diagram, which follows the amplitude constraint <br><em>https://commons.wikimedia.org/w/index.php?curid=1322082</em></p>  

3. Energy Constraint - 
<p align="center">
  <img src="https://latex.codecogs.com/png.image?\dpi{110}%20\left\|\mathbf{x}%20\right\|_{2}^{2}\leq%20n"/>
</p>  
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/153102451-bdfe2754-a708-4f18-818e-45c868dc1be9.png"/>
</p>  
<p align="center"> 
  16-PSK diagram, which follows the energy constraint <br><em>https://www.researchgate.net/figure/Gray-mapped-16-PSK-constellation-with-radius-c_fig3_3162047</em></p>  



### Part 2: Hamming Code 

## Solution:

