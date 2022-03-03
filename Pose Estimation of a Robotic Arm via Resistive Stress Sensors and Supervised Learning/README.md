# Pose Estimation of a Robotic Arm via Resistive Stress Sensors and Supervised Learning - 2018

## Abstract

Pose estimation in humans does not require vision to be successful, however all state-of-the-art pose estimation techniques for humans and robots utilize computer vision in some capacity. Furthermore, it is difficult to perform pose estimation by traditional means in a soft-bodied robot. This paper aims to explore a possible method of pose estimation that is both biomimetic and compatible with soft-body robotics. For an example case, we have affixed a robotic arm with segments of carbon-impregnated silicone cords, serving as resistive stretch sensors. By employing various machine learning algorithms in the form of least squares regression (LSR) and random forest regression (RFR) we have developed a method for resistance readings through the stretch sensors to joint angles of the robotic arm. RFR the best of the two methods, yielding average errors for the two explored angles of 0.43% and 0.58%. These results suggest that these silicone sensors would be suitable for implementation in a soft-bodied robot.

## Introduction

Biologically-inspired control systems have many applications, including powered prosthetics [1], robot design [2][11], and rehabilitative devices [1]. Control and sensorization that are bio-inspired allow for much more complex and nuanced systems than is allowed by classical control theory, and have far-reaching applications. We choose to focus on pose estimation and bio-inspired observation techniques as the subject of our study.  

Here we study possible computational mechanisms by which the brain makes sense of a large amount of sensor readings, namely pressure values, and translates that into useful information regarding body state and pose estimation [10], [12]. While visualization of ones own body certainly aids in pose estimation, it doesnt directly require it. Closing
ones eyes doesnt render them unable to know the relative positions of their body segments in space [13]. We anticipate that the brain applies something akin to a machine learning algorithm to estimate pose given sensory feedback from a vast array of mechanoreceptors. Young children are often clumsy and unaware of their bodies in space, suggesting that the brain hasnt yet been given enough training examples to make accurate pose estimations [14]. While we dont research specifically how the human brain makes sense of this data, we are interested in trying to recapture the end result by applying modern control theory.  

Modern pose estimation techniques are not biomimetic and almost invariably utilize vision (monocular [15][19] and multi-view [20][24]), sometimes accompanied by depth sensors
[25][27] or inertial sensors [6][25][28][31]. While accurate and well-researched, biological pose estimation does not require vision. We choose to pivot away from established techniques and explore possible ways of recreating these biologically-inspired methods of pose estimation. Our interests lie in using non-intuitive and randomly-placed sensors to accurately determine pose. For our test case, we affix a robotic arm with randomly placed, carbon-impregnated, silicone rubber cords. These are chosen because of their compatibility with soft robotics, which this project will segue into for future work. The electrical resistance in these cords changes as a function of length and
thus they serve as stretch sensors. The cords are affixed to span joints in such a way that flexion and extension will elongate and shrink antagonist cords. By logging the resistances in all the cords as the robotic arm articulates, we accumulate data that is seemingly unrelated to pose information, mirroring the body's collection of pressure data. Simultaneously, we use motion capture techniques to record the actual joint angles and segment positions in space for use as ground-truth measurements. The resistance and joint angle data, synced in time, serves as a training set.  

We apply two regression methods to the resistance data to map arrays of resistances to specific poses as observed from the motion capture data. After using a sufficient number of training poses, we are able to predict pose solely given resistance values from the stretch sensors. We present the framework for feeding live resistance data to the computer, which renders the robot’s estimated position in real time. Global average and maximum local error for each of the two methods is also determined.  

## Methods

For our pose estimation problem, we affixed a robotic arm with various stretch sensors whose resistance is a function of their length. The goal was to determine joint angles from resistance measurements of the stress sensors. To do so, training data was gathered in the form of resistances paired with joint angles. The resistances were logged by an Arduino voltage divider set-up and the robot was videotaped as it articulated. The footage was then processed in Kinovea to determine joint angles. The joint angle information was then synced in time with the resistance data and stored in a large matrix to serve as a training set. Regression analysis was then performed to produce a fit on the data to correlate the resistance measurements to the angle measurements. The two regression methods applied to fit the data were least squares fit (LSR) and random forest regression (RFR). The best-fit lines produced by each regression method were also compared. The average maximum error, average percent error, and root mean squared error was determined for each fit.

### A. Robot
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156491366-8bf42801-f9ab-40f9-91ac-b9b8c7846bc9.png" />
</p>
<p align="center"> 
<em>Figure 1: Robotic arm used for pose estimation. Colored lines represent pathing for the five stretch sensors. Note the purple paint at various points on the robot to aid with position tracking in Kinovea.</em>
</p>  

The robot used in this study was a robotic arm (Fig. 1). We limited the robots motion to a single 2D plane and removed the grasping mechanism for simplicity. There were three segments including the bottom, which was locked in the vertical direction. The two upper joints could be articulated via DC motors. This system thus had two degrees of freedom.
The upper segment with the grippers will be referred to as the top segment, the segment below as the lower segment, and the immobile base as the base segment.  

### B. Stretch Sensors

To provide sensory information for eventual translation into robotic pose, we employed 2mm carbon-impregnated rubber cord (Adafruit) randomly spanning the robots joints. The electrical resistance of the cord changes as a function of the cord length, giving 350 - 400 ohms of resistance per inch. The cords were alligator clipped at either end to copper eye bolts that were screwed into the robots plastic frame. Wire was soldered to the eye bolts that was then routed to the Arduino for resistance measurements. Movement of the robot elongated or shortened the various stretch sensors.  

### C. Resistance Data Collection
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156491662-004b57ca-caa3-45ab-9642-202142673df6.png" />
</p>
<p align="center"> 
<em>Figure 2: Circuit diagram for arm where the colored resistors correspond to the silicon wires connected along the arm (Fig 1).</em>
</p>  


Resistance through the stretch sensors was measured by creating a voltage divider (Fig. 2) to determine the unknown resistance. A known voltage (Vin) was passed through the
unknown (R1) and known (R2) resistors in series. Voltage across R1 was measured (Vout) with an Arduino Uno and used to determine the value of R1 via the following equation,
derived from Ohms law.  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156492352-5d38c4f9-0678-4e8c-a877-d760c361ed4b.png" />
</p>

All resistances were logged in real-time through a Python script (Appendix C) that monitored the serial output from the Arduino, logging resistance to a CSV spreadsheet. The sample rate was 5 Hz and data collection lasted almost three minutes in total.

### D. Vision Data Collection
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156493359-1d98cba2-9926-4c03-acc8-75acf5496836.png" />
</p>
<p align="center"> 
<em>Figure 3: Screenshot of the Kinovea software tracking the purple markers painted onto the arm. This was used to determine joint angles.</em>
</p>  

To acquire training poses, we videotaped the robotic arm articulating during resistance data acquisition at 30 frames-persecond. An LED attached to the circuit lit up indicating when the logging started and turned off indicating when the logging ended. Because the framerate was divisible by the sample rate of the Arduino, we synced the sample rates of both the camera and the Arduino to match the recorded data at each instance in time. The video file was imported into Kinovea for position tracking of the purple markers (Fig. 3). Each arm marker was given a tracking marker through Kinovea that followed the position throughout the video. From the position information, joint angles were calculated via a Python script (Appendix B).

### E. Computational Analysis via Machine Learning  
After the joint angles were determined and synced with the resistance measurements, a fit could be made. The regression was attempting to solve (2), where the <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494634-0f04e16f-5d0a-475a-9072-29d137c77ed2.png"> matrix represents the resistance data, the <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494898-3c3845c9-6070-44cc-8a3e-192c90d2ed44.png"> matrix represents the transformation matrix, and <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494730-49b6550d-4596-4870-8b8f-eb8898459710.png"> represents the angle measurments.  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156492557-fe0d90e9-c0e7-4347-ac3d-d1b09dfa76d8.png" />
</p>

While the equation is rather straightforward, determining <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494898-3c3845c9-6070-44cc-8a3e-192c90d2ed44.png"> can be nontrivial depending on the data. The analysis for the regression was conducted using sklearn, a Python package.  

#### 1) Least Squares Regression
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156493781-6c9cf163-87de-4e55-bed4-490984b944e0.png" />
</p>  
<p align="center"> 
<em> Figure 4: Figure illustrating how the angles  <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493936-07c75fdc-8ac8-42a3-b311-c7287e32397e.png">  and  <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493957-fa7be2a0-b576-4335-a9bd-eaf954394483.png"> are defined.</em>
</p> 

The first, and most basic, regression attempt was to find a best fit line using least square regression.  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156493020-8ba93a3c-5598-4339-bb84-926c86aed427.png" />
</p>  

Plugging in the data obtained to the matrices <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494634-0f04e16f-5d0a-475a-9072-29d137c77ed2.png"> and <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494730-49b6550d-4596-4870-8b8f-eb8898459710.png"> from (2) resulted in (3) where each entry in <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494634-0f04e16f-5d0a-475a-9072-29d137c77ed2.png"> and <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494730-49b6550d-4596-4870-8b8f-eb8898459710.png"> were vectors of <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156496544-f4ce0ba1-df73-4809-b149-3ebdb8a5c518.png">. Each vector had 5 Hz times t second entries. With five resistance measurements this meant that <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494634-0f04e16f-5d0a-475a-9072-29d137c77ed2.png"> is <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156496651-eef5ec9c-7888-4557-8db8-867c4bf49626.png">. The matrix <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494730-49b6550d-4596-4870-8b8f-eb8898459710.png">, containing the angle measurements, was sampled over the same time period, so it was <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156496823-5ee17257-56a1-4691-85dc-d12e98294e34.png">. This meant that the transformation matrix <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494898-3c3845c9-6070-44cc-8a3e-192c90d2ed44.png"> was <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156496936-e32be1b8-bc71-4fb1-a40a-8a9999142020.png">.  

Using Python’s sklearn package, LSR was applied to <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494634-0f04e16f-5d0a-475a-9072-29d137c77ed2.png"> and <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494730-49b6550d-4596-4870-8b8f-eb8898459710.png"> to generate the <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494898-3c3845c9-6070-44cc-8a3e-192c90d2ed44.png"> matrix. With this <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494898-3c3845c9-6070-44cc-8a3e-192c90d2ed44.png"> matrix a prediction could be made, <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156495457-d1288220-2853-44e1-ab4b-f8a13e5287d8.png">, as to the position of the arm at any point in time and could then be compared to the actual position of the arm, <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494730-49b6550d-4596-4870-8b8f-eb8898459710.png">.

#### 2) Random Forest Regression
The second, and more advanced, regression attempt was to use RFR to determine the transformation between <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494634-0f04e16f-5d0a-475a-9072-29d137c77ed2.png"> and <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494730-49b6550d-4596-4870-8b8f-eb8898459710.png"> . Sklearn’s RFR fit decision trees to subsamples of the input dataset and employed averaging to improve accuracy and prevent over-fitting [32].  

The angle and resistance data were split into two parts, the training set and the test set. The training set consisted of a random sampling of 75% of the data and the test set consisted of the remaining 25%. The training data was fed into the RFR object to generate the transformation. The test data was then fed into a regressor object to determine the closeness of the fit. The process was repeated several times to cross validate the fit (Appendix B).

### F. Error Metrics

The closeness of each regression fit was determined to understand how well the regression fit the data. To measure the accuracy of each fit and to compare the results of LSF to that of RFR, three error metrics were calculated. The average angle error, average maximum angle error, and the root mean squared error were all used to determine how well the regression fit the data.  

#### 1) Average Angle Error
Average angle error was calculated to determine how close, on average, the predicted position was to the real position at any given time. The difference between the predicted angle, <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156495457-d1288220-2853-44e1-ab4b-f8a13e5287d8.png">, and the actual angle, <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494730-49b6550d-4596-4870-8b8f-eb8898459710.png">, was taken at each instance in time and divided by the total number of angle measurements.  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156497889-5ba3e035-3cf1-4985-b516-b9406b55af94.png" />
</p>  

#### 2) Average Maximum Angle Error
The second error metric measured was the average maximum error. After a regression fit was made with LSF and RFR the maximum angle deviation was obtained. This process was repeated for 20 fits, with RFR sampling a different set of data with each trial. This was the averaged to obtain the maximum angle deviation after crossvalidation. Worth noting is that the cross validation for RFR was necessary, but LSF used the entire time series of <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494634-0f04e16f-5d0a-475a-9072-29d137c77ed2.png"> and <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156494730-49b6550d-4596-4870-8b8f-eb8898459710.png">. Therefore, the maximum angle deviations for <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493936-07c75fdc-8ac8-42a3-b311-c7287e32397e.png"> and <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493957-fa7be2a0-b576-4335-a9bd-eaf954394483.png"> were the same over all 20 trials.  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156499601-6c088b5f-11ff-429a-8316-9d90c04b39a9.png" />
</p>  

#### 3) Root Mean Squared Error
The final error metric measured was the root mean squared. This was calculated to obtain the standard deviation between the regression fit and the actual data.  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156499807-0af5aece-5e9b-415c-bdee-d2d01784ca8c.png" />
</p>  

## Results
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156498208-d7f7d532-19b8-4a14-ad90-e5441eaabbde.png" />
</p>  
<p align="center"> 
<em> Figure 5: Worst case poses for <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493936-07c75fdc-8ac8-42a3-b311-c7287e32397e.png"> error (left), <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493957-fa7be2a0-b576-4335-a9bd-eaf954394483.png"> error (middle), and <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156498552-8212edd9-94b7-4531-842c-2205eaac2b59.png"> error (right) corresponding to maximum error for LSF.</em>
</p> 

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156499153-b46ddd4a-83b7-4449-9ec0-c91bac67af11.png" />
</p>  
<p align="center"> 
<em> Figure 6: Worst case poses for <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493936-07c75fdc-8ac8-42a3-b311-c7287e32397e.png"> error (left), <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493957-fa7be2a0-b576-4335-a9bd-eaf954394483.png"> error (middle), and <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156498552-8212edd9-94b7-4531-842c-2205eaac2b59.png"> error (right) corresponding to maximum error for RFR.</em>
</p>  

Here we present various error metrics for pose estimation via both explored methods, LSR and RFR. Average total error, average maximum error, and root mean squares error is reported for each method. Plots are included depicting max error poses for <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493936-07c75fdc-8ac8-42a3-b311-c7287e32397e.png">, <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493957-fa7be2a0-b576-4335-a9bd-eaf954394483.png">, and <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156497438-92eda889-f1ab-4fbe-97bc-4038ccaa9774.png">. Additionally, RFR yields feature importance, reported as percent importance for each color-coded stretch sensor (Fig. 1). Angles <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493936-07c75fdc-8ac8-42a3-b311-c7287e32397e.png"> and <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493957-fa7be2a0-b576-4335-a9bd-eaf954394483.png"> are measured as depicted (Fig. 4).  

RFR gives less error in terms of average and maximum for both angles. For both RFR and LSR, error for <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493957-fa7be2a0-b576-4335-a9bd-eaf954394483.png"> was roughly two-times greater than that of <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493936-07c75fdc-8ac8-42a3-b311-c7287e32397e.png">. This large error is an artifact of our angle definitions. Because we aren't measuring to a standard reference frame but rather the segments themselves, the <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493936-07c75fdc-8ac8-42a3-b311-c7287e32397e.png"> error includes <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493957-fa7be2a0-b576-4335-a9bd-eaf954394483.png"> error.  

## Discussion
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156500280-7d640834-ebaa-4162-9fde-cd3e950465ce.png" />
</p>  
<p align="center"> 
<em> Table 1: Average angle error, average maximum angle error, and root mean squared error for both joint angles yielded by LSR.
Note that due to how <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493936-07c75fdc-8ac8-42a3-b311-c7287e32397e.png"> is defined, its error includes the error <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493957-fa7be2a0-b576-4335-a9bd-eaf954394483.png">. </em>
</p>  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156500643-800fbc04-112a-43ae-8ebf-75efe97ea09d.png" />
</p>  
<p align="center"> 
<em> Table 2: Average angle error, average maximum angle error, and root mean squared error for both joint angles yielded by RFR. Just like with LSR, note that due to how <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493936-07c75fdc-8ac8-42a3-b311-c7287e32397e.png"> is defined, its error includes the error <img style="display: inline;" src="https://user-images.githubusercontent.com/89391443/156493957-fa7be2a0-b576-4335-a9bd-eaf954394483.png">. </em>
</p>  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/156501019-0ec30a37-1d24-4dc5-9d4a-870f2d625b4b.png" />
</p>  
<p align="center"> 
<em> Table 3: Feature importance as calculated by the RFR regression. The "yellow" and "black" cords are considered most important. These are also two of the three sensors that span only a single joint. </em>
</p>  

We were initially surprised at how well LSR worked, with average error under 10% (Table 1), as this would imply that our resistance to pose mapping is mostly linear. Upon further consideration, this does make sense, as the stretch sensors linearly increase their resistance with strain, and the mapping from linear to rotational translation is linear if radius is constant. Considering the high linearity, we conjecture that more exotic methods such as neural networks are unnecessary as the improved accuracy they provide would be marginal at best.  

Additionally, we predict that the reason RFR performed better is that in reality this mapping isnt 100% linear, most like due to hysteresis in the stretch sensors that develops from straining them. For example, if a pose is determined in terms of resistance and the robot articulates, when returning to the same pose the resistances in the stretch sensors will actually be slightly higher. This is an effect of the high damping and hysteresis; the manufacturer cited that the cords could take up to two minutes to return to their original lengths.  

RFR yielded sensor importance as percent recruitment in its regression algorithm. The "black" and "yellow" sensors were recruited the most at 43% and 30% respectively, and the "red" and "green" with the least at 5% and 4%. We anticipate the reason that "red" and "green" were used the least is twofold. First and most importantly, because they span the entire arm, they experienced the most hysteresis of the five stretch sensors. Secondly, the cords that span the entire arm are less desirable features to use than the cords that span a single joint.  

As the arm moved the "red" and the "green" cords were under larger amounts of tension. This means that as the arm maneuvers through space and returns to previous poses, if the tension on the cord is lowered the cord develops slack, yielding a different resistance when measured. This difference in resistance measurement when at the same position leads to non-uniqueness making it difficult to fit a linear regression.  

The second reason the "red" and "green" cords ranked lower on the feature importance is due to the fact that they span the entire arm. There are three sensors that span a single joint meaning they directly measure the joint angle they span. The "red" and ”green” cords measure two joint angles at the same time, leading to further non-uniqueness and making these cords even less desirable to use in the angle prediction. For the remaining three cords the differences in "yellow", "black", and "blue" percent recruitment is likely due to random chance in RFRs recruitment decisions.  

When considering the maximum error of the RFR in comparison to both the average error and the root mean squared error, there are some points of interest. While the average maximum error is significantly lower for RFR in comparison to LSF, its still high relative to the average angle error and root mean squared error. When plotting the predicted angles vs. the actual angles in time, the predicted angles generally match nearly perfectly to the actual angles. However, there are instances where the tracking failed, but this occured only momentarily. The arm would then jump back to the proper position. This lapse in tracking lead to the larger than expected average maximum angle error.

## Conclusions and Future Work
Its clear that the use of resistive stretch sensors in a soft robotics set-up for pose estimation is not only a viable solution, but an ideal one. Furthermore, using RFR to learn the proper resistance to pose mapping is the better method (as compared to LSR), with average error on the order of 0.5% (Table 2). The regression toolbox we used had limited support for continuous multi-output regression so we were limited in the regression methods that could be applied. However, as discussed, our system is mostly linear so other methods weren't deemed to be necessary.  

Because of the nature of how RFR operates, it also gave us feature importance as percent recruitment in its mapping algorithm, with the single joint spanning "black" and "yellow" cords providing a majority of the feature importance (Table 3). For future work, it would be interesting to try cutting out certain sensors to see how well the pose estimation performs. For example, cutting out black and observing the resulting importance distribution and error metrics would be of interest. Additionally, we plan to apply this sensing method to a softbody robotic octopus tentacle.

## References
[1] Y.-L. Park et al., Design and control of a bio-inspired soft wearable robotic device for ankle-foot rehabilitation., Bioinspir. Biomim., vol. 9, no. 1, p. 16007, 2014.  
[2] A. Wang, H. Yu, and S. Cang, Bio-inspired robust control of a robot arm-and-hand system based on human viscoelastic properties, J. Franklin Inst., vol. 354, no. 4, pp. 17591783, 2016.  
[3] E. Mattar, A survey of bio-inspired robotics hands implementation: New directions in dexterous manipulation, Rob. Auton. Syst., vol. 61, no. 5, pp. 517544, 2013.  
[4] R. Pfeifer, M. Lungarella, and F. Iida, The challenges ahead for bioinspired soft robotics, Commun. ACM, vol. 55, no. 11, p. 76, 2012.  
[5] C. Majidi, Soft Robotics: A Perspective Current Trends and Prospects for the Future, vol. 1, no. 1, 2014.  
[6] P. Lin, D. E. Koditschek, and H. Komsuo, Sensor Data Fusion for Body State Estimation in a Hexapod Robot With Dynamical Gaits Sensor Data Fusion for Body State Estimation in a Hexapod Robot With Dynamical Gaits, vol. 22, no. 5, pp. 932943, 2006.  
[7] M. Cianchetti, M. Calisti, L. Margheri, M. Kuba, and C. Laschi, Bioinspired locomotion and grasping in water: the soft eight-arm OCTOPUS robot, Bioinspir. Biomim., vol. 10, no. 3, p. 35003, 2015.  
[8] S. Kim, C. Laschi, and B. Trimmer, Soft robotics: A bioinspired evolution in robotics, Trends Biotechnol., vol. 31, no. 5, pp. 287294, 2013.  
[9] D. Rus and M. T. Tolley, Design, fabrication and control of soft robots, Nature, vol. 521, no. 7553, pp. 467475, 2015.  
[10] E. Chinellato, B. J. Grzyb, and A. P. Del Pobil, Brain mechanisms for robotic object pose estimation, Proc. Int. Jt. Conf. Neural Networks, pp. 32683275, 2008.  
[11] M. Cianchetti, A. Licofonte, M. Follador, F. Rogai, and C. Laschi, Bioinspired Soft Actuation System Using Shape Memory Alloys, Actuators, vol. 3, no. 3, pp. 226244, 2014.  
[12] E. Azan, M. R. Longo, S. Soto-Faraco, and P. Haggard, The posterior parietal cortex remaps touch into external space, Curr. Biol., vol. 20, no. 14, pp. 13041309, 2010.  
[13] M. Avillac, S. Denve, E. Olivier, A. Pouget, and J.-R. Duhamel, Reference frames for representing visual and tactile locations in parietal cortex, Nat. Neurosci., vol. 8, no. 7, pp. 941949, 2005.  
[14] S. Schaal, A. Ijspeert, and A. Billard, Computational approaches to motor learning by imitation, Philos. Trans. R. Soc. B Biol. Sci., vol. 358, no. 1431, pp. 537547, 2003.  
[15] Y. Yang and D. Ramanan, Articulated pose estimation with exible mixtures-of-parts, Comput. Vis. Pattern , 2011.  
[16] I. Kostrikov, Depth Sweep Regression Forests for Estimating 3D Human Pose from Images, Bmvc, pp. 113, 2014.  
[17] S. Li, A. B. Chan, and A. B. C. Sijin Li, 3D Human Pose Estimation from Monocular Images with Deep Convolutional Neural Network, Accv, pp. 332347, 2014.  
[18] C. Wang, Y. Wang, Z. Lin, A. L. Yuille, and W. Gao, Robust Estimation of 3D Human Poses from a Single Image, Comput. Vis. Pattern Recognit. (CVPR), 2014 IEEE Conf., pp. 23692376, 2014.  
[19] I. Radwan, A. Dhall, and R. Goecke, Monocular Image 3D Human Pose Estimation under Self-Occlusion, Iccv, pp. 18881895, 2013.  
[20] M. Burenius, J. Sullivan, and S. Carlsson, 3D Pictorial Structures for Multiple View Articulated Pose Estimation, Cvpr, pp. 36183625, 2013.  
[21] S. Z. Li, Q. Fu, L. Gu, B. Scholkopf, Y. Cheng, and H. Zhang, Kernel machine based learning for multi-view face detection and pose estimation, Comput. Vision, 2001. ICCV 2001. Proceedings. Eighth IEEE Int. Conf., vol. 2, pp. 674679 vol.2, 2001.  
[22] H. Zhang and Z. Jiang, Multi-view space object recognition and pose estimation based on kernel regression, Chinese J. Aeronaut., vol. 27, no. 5, pp. 12331241, 2014.  
[23] A. Assa and F. J. Sharifi, Decentralized multi-camera fusion for robust and accurate pose estimation, 2013 IEEE/ASME Int. Conf. Adv. Intell. Mechatronics Mechatronics Hum. Wellbeing, AIM 2013, pp. 16961701, 2013.  
[24] N. A. Azis, Y.-S. Jeong, H.-J. Choi, and Y. Iraqi, Weighted averaging fusion for multi-view skeletal data and its application in action recognition, IET Comput. Vis., vol. 10, no. 2, pp. 134142, 2016.  
[25] J. S. Supancic III, G. Rogez, Y. Yang, J. Shotton, and D. Ramanan, Depth-based hand pose estimation: methods, data, and challenges, arXiv Prepr. arXiv1504.06378, pp. 18681876, 2015.  
[26] P. Zhang and C. K. Liu, Leveraging Depth Cameras and Wearable Pressure Sensors for Full-body Kinematics and Dynamics Capture, vol. 33, no. 6, pp. 114, 2014.  
[27] J. Han, L. Shao, D. Xu, and J. Shotton, Enhanced computer vision with Microsoft Kinect sensor: A review, IEEE Trans. Cybern., vol. 43, no. 5, pp. 13181334, 2013.  
[28] M. Kok, J. D. Hol, and T. B. Sch, An optimization-based approach to human body motion capture using inertial sensors, vol. 19, pp. 7985, 2014.  
[29] P. D. Duong and Y. S. Suh, Foot pose estimation using an inertial sensor unit and two distance sensors, Sensors (Switzerland), vol. 15, no. 7, pp. 1588815902, 2015.  
[30] G. Welch, Motion Tracking: No Silver Bullet , but a Respectable, IEEE Comput. Graph. Appl., vol. 22, no. December, pp. 2438, 2002.  
[31] Y. Zhang, K. Chen, J. Yi, T. Liu, and Q. Pan, Whole-Body Pose Estimation in Human Bicycle Riding Using a Small Set of Wearable Sensors, IEEE/ASME Trans. Mechatronics, vol. 21, no. 1, pp. 163174, 2016.  
[32] Scikit-learn: Machine Learning in Python, Pedregosa et al., JMLR 12, pp. 2825-2830, 2011  
