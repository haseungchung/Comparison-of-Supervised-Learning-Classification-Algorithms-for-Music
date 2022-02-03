# Comparison of Supervised Learning Classification Algorithms for Music - Q1 2018

## Abstract
Supervised learning is a type of machine learning that uses trained datasets with expected results and classification classes to make predictions on new data of a similar dataset. In this work, the accuracies of various classification algorithms from supervised learning are investigated and explored for different sets of music, one from three different artists of different genres, one from three different artists from the same genre, and one from various songs from three different genres. For each set, using three, five-second clips from each of 20 songs for each of the three different groups, the data is created and then preprocessed through spectrogram and through singular value decomposition (SVD). The data is then trained separately in Naïve Bayes method (NB), support vector machine method (SVM), and classification trees method (CART). These models are then tested against five second clips of five songs of each group to test the classification accuracy. The results show that for songs that are processed as spectrograms with SVD, CART was most accurate, followed by SVM, and then by Naïve Bayes, which was no better than a random guess. All analysis was carried out with MATLAB and its programming language and computational algorithms.

## Introduction and Overview
Machine learning is the science of pattern recognition and computational learning that aims to teach an algorithm with data to make predictions from new data. In machine learning, there is a field of supervised learning and unsupervised learning, where supervised learning has user influence on the input variables and expected output variables to “supervise” an algorithm as it learns to predict output variables. Unsupervised learning is for when there is data, but expectations of the data are unknown, so the algorithm learns features without the supervision of a programmer. Supervised learning is considered in this work. Within supervised learning, the two main problems can be said to be classification problems, where the output variable is a category, and regression problems, where the output variable is a tangible amount or value. This technology is very important in many applications, such as image recognition, pose estimation, systems biology, and disease detection.  
  
In this work, supervised classification algorithms are explored for the application of three different supervised classification algorithms, Naïve Bayes (NB), support vector machine (SVM), and classification trees (CART). These three algorithms which work under different assumptions and methods were applied to classifying songs in three different parts. In the first part, three artists of different genres were classified, in the second part, three artists of the same genre were classified, and in the third part, songs from three different genres were classified. In each part, 20 songs were chosen from each classification group, and from each song, two, 5 second clips were taken. Each 5 second clip was then transformed into the frequency domain via spectrogram, and the data from the spectrogram was stacked into a single vector. For the 120 samples, a matrix was built with the 120 corresponding vectors, and SVD was performed to break down the data into its most descriptive components. From the SVD, the V matrix was taken as training data in this new principal component space and applied for each trained classification algorithm. The test data of five second clips from five songs of each group was similarly processed by spectrogram and then projected onto the principal component directions. This data was then input into each trained algorithm to test the accuracy of the classification models and cross validated.

## Theoretical Background
The are five concepts to elaborate on is the SVD, short time Fourier transform, NB, SVM, and CART.
Singular value decomposition method is a type of principal component analysis that essentially takes an inputted matrix A, and decomposes it into 3 matrices, U, Σ, and V such that
<h4 align="center">A=UΣV*</h4>

where * denotes a complex conjugate transpose. In one sense, the SVD takes in data, and in three sequences, first rotating the matrix (U), then stretching the matrix (Σ), and finally rotating the matrix, obtains a coordinate system that describes the inputted data in the most efficient and accurate way in L2 norm, the least squares approximation. In another sense, the SVD rewrites a data matrix so that it is described with orthonormal directions/components, preventing redundancies between data in the matrix, and thus making it computationally easy and efficient to work with.  

When organized in columns, the UΣ returns vectors of weighted principal components that shows directions in this new basis, and how important each direction is in capturing the data in the given matrix. The V matrix describes how each individual row vector (equivalent to the column vectors in V*) of the original matrix projects onto the weighted principal component directions. Essentially in this work, the data matrix of spectrogram data for each song is analyzed by SVD to describe it in a coordinate system that best maps the data, so that the mapping of V row vectors onto this space is descriptive and efficient for both the training data, and the test data.  

The short time Fourier transform is a way of taking time data into frequency data, so that the useful frequency data from the data can be taken out of it, and the unique higher and lower frequencies with overtones and such could be extracted. Getting rid of the time dependency makes the data more refined since one of its features (the time) is not considered as heavily.  

The NB method is a classification method that uses the probability of different features to robustly determine and classify test data. The method uses the probability of a feature being present given that it belongs in a group, and then mirrors it to the probability of it belonging to a group when given a feature. These probabilities are multiplied in such a way that determines the best classification for a given data.  

The SVM uses the mapped training data with their labels to draw boundaries between the classes with the widest dividing line possible, meaning that the data along the boundaries plays the biggest roles. The test data then maps onto this space, and whichever classification side of the boundaries it is closest to is what the test is classified to be. This method can separate only two classes at a time.  

The CART method uses a basic decision tree to map out the training data and determine borders to make nonlinear, efficient boundaries for the different classes that best separates them. The mapped test data then is classified according to where it is on this map.  

## Algorithm Implementation and Development
MATLAB programming language and software was used for this work, and the algorithm is built with several MATLAB commands for spectrogram, SVD, NB, CART, and SVM.  

The code starts by loading a structure with 25 songs from each of the three different artists in the first part of the work. The structure’s elements are then randomized in their respective groups, meaning that the 25 ACDC songs are randomized in the first 25 rows, followed by randomized 25 John Mayer songs, and then randomized Yiruma songs. This is so that this code can cross validate every time that it is run to have different training data, and different testing data. Then a separate structure picks out 20 songs from each group to use as training data, while another structure picks out the remaining 5 songs from each group for testing data.  

From the training data set, the audio file is read for each song, and three clips of five seconds are taken from the song starting at different points. Since each clip is in stereo form, meaning two data columns for the left and right ear, the data was processed and put into mono form, to have a single column of data. This was done by going through each row in the column, and then averaging the two signals unless one of the signals were 0, in which case the other signal’s value was automatically taken. The three separate clips were then put into short Fourier Transform through the spectrogram() command, and then reshaped into 3 column vectors and added to the training data matrix. This process was repeated for all 60 songs in the training set and added to the training data matrix. The test data songs were processed in the exact same way, except only one five second clip was taken for each song.  

With the training data complete, the SVD was performed on the absolute value of the matrix, since there were some imaginary parts, with the ‘econ’ mode to save memory and computation time. In this new basis, the training data was identified to be the rows of the V matrix and was labeled as such. The training data was also labeled by their group in a separate vector (1, 2, or 3 symbolizing the three groups), and was first trained for NB method using the fitcnb() command. The test data was projected onto the same basis as the V matrix, and then classified through the predict() command with the build NB algorithm. The training data was then similarly trained for the CART method, but instead of fitcnb(), the fitctree() command was used.  

In the case of SVM, because SVM can only compare two groups at a time, the training data was split such that the first group, ACDC (in part 1) was given a classification as 1, and the rest of the two groups classified as 2 in one model. Then, another model was trained to have the last group with the label of 3, which was Yiruma (in part 1), and the other two groups with a label of 2. Then after testing the data (after projecting it onto the same basis as the V matrix), the results were combined to get the true predictions using a for loop. This process is repeated five times to cross validate the model.  

This entire processed was repeated for the other two parts of this work, once for the case of three artists in the same genre, and then once for songs from three different genres.

## Computational Results
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152390307-364015ee-64d9-49da-a813-602defb0dc39.png" />
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152390718-edb782a6-0a0c-41a1-a138-013eb1d342aa.png" />
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152390856-4a683eb5-b796-46b0-b9af-8800a8666c22.png" />
</p>

<p align="center"> 
Figures 1, 2, 3 respectively: Applying the training data to the (1) NB model, (2) SVM model, (3) CART model, all of which were trained on this same data for part 1.
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152393715-ba18df9a-fe0a-41f3-9b86-02770d8c4701.png" />
</p>
<p align="center"> 
Figure 4: Accuracy of Classification Methods in classifying songs from different artists of different genres.
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152393790-ff825e7c-99ff-4238-bb70-3b3f85975951.png" />
</p>
<p align="center"> 
Figure 5: Accuracy of classification models in classifying songs from different artists of the same genre.
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152393849-a828ac48-423b-4a94-92ec-f0c85c74367a.png" />
</p>
<p align="center"> 
Figure 6: Accuracy of classification models in classifying various songs from three different genres.
</p>  

## Summary and Conclusions

In this work, classification models were built for songs to differentiate between 1) three artists from different genres in part 1, 2) three artists from the same genre in part 2, and 3) songs from three genres in part 3. For each part, 20 songs were taken from each group, and then two five second clips were extracted from each song. The clips were then transformed into the frequency domain, stacked into a training data matrix by columns, and then SVD was performed on the matrix. The V matrix’s rows were then used to train three different classification algorithms, NB, SVM, and CART. Then using five second clips from 5 test songs of each group, it was put into the SVD domain of the training data matrix, and then classified using the algorithms. The accuracies of each algorithm were then compared. The CART method was consistently shown in this case to have the most accurate classifications, followed by SVM, and then by NB, which was no more accurate than assigning a random variable.  

Figures 1, 2, and 3 are examples of how the algorithms perform when plugged in the training data as test data. The results show that the algorithms were properly built, because when the training data is input into the model, the classification is very accurate, with few misclassified elements (which are apparent through the spikes and dips in the data). However, such great results on training data alludes to overfitting tendencies, which is evident in the test results. The NB model still had the most misclassifications, but still built a proper model to predict new data. In practice, however, the NB model was actually very lacking, and almost always classified all test data as one type except one or two elements, leading to a consistent 33% accuracy, as shown in figures 4, 5, and 6. There could be a few reasons for such a low accuracy, although the exact reason could not be determined from the theory learned in this course. Naïve Bayes algorithm is built on probabilities of what class a feature being present would infer and assumes total independency between each feature. In this case, the music may actually have features that are very related with one another, and combinations of such features that could have helped in classification. Another potential reason for the lack of accuracy in the model is possible overfitting in the model, as it takes into account much smaller, less dominant features in the later columns of the V matrix. The reasons for the ambiguity is because the other models also consistently have signs of overfit and overdetermination in data (also apparent in figures 1, 2 and 3), but still perform considerably well.  
  
The CART model has consistently proven to be the most accurate predictor and classifying algorithm with the given data and all the parts. This may be due to its ability to easily maneuver in a nonlinear fashion to separate data in classification. The SVM method has also proven to be effective, at least more than a random chance, but the algorithm did not classify as swiftly and accurately as the CART model. More data would definitely help maneuver the space of validation the models and preventing overfitting.

In the first part of the work, the features between the different artists from different genres were very apparent, with little overlap in other spaces, which gave high accuracy for the SVM and CART models. The CART models had an average of 82.67% accuracy over 5 cross validation trials, and the SVM models had an average of 61.3% accuracy over 5 cross validation trials.  

In the second part of the work, the features between the different artists from the same genre had much more overlap, and therefore had less accurate classifications. The CART models had an average 62.67% accuracy over 5 cross validation trials, and the SVM models had an accuracy of 52% over 5 cross validation trials.  

In the third and final part of the work, the features of three different genres had less overlap than the second part, but more than the first part, leading the CART models to have an average of 72% accuracy over 5 cross validation trials, and the SVM models to have an average of 38.67% accuracy over 5 cross validation trials.  

It is worth noting that the average accuracies are not completely representative of the actual accuracy of each model, since the cross validation trials were only done 5 times for each part for each algorithm due to computational limitations. 
