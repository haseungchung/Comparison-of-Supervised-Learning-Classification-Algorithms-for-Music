# Prediction of H1B Visa Approval Using Machine Learning Algorithms

## Abstract
Supervised learning is a type of machine learning that uses trained datasets with known labels and classification classes to make predictions on new data of a similar dataset. In this work, the accuracies of various supervised learning classification algorithms under different preprocessing methods are investigated for H1B Employment Applications. 27932 cases of H1B applications with their case statuses (labels) are used, with 25000 of these being used for training, and 2932 of these being used for testing. The data is first imported into matrices, and then the categories of string types are converted to numerical categories. Following this, the data is either preprocessed through singular value decomposition (SVD) or kept in raw categorical data. The data is then trained separately using the Naïve Bayes method (NB), K nearest neighbors method (Knn), and classification trees method (CART). These models are then tested against the test data to test the classification accuracy. The results showed that all classification methods were more accurate when preprocessed with SVD except the CART method. CART was most accurate, followed by Knn with SVD, NB with SVD, Knn without SVD, and then finally NB without SVD. All analysis was carried out with MATLAB and its programming language and computational algorithms.

## Introduction and Overview
Machine learning is the science of pattern recognition and computational learning that aims to teach an algorithm with data to make predictions from new data. In machine learning, there is supervised learning and unsupervised learning, where supervised learning has the user’s influence on the input variables and expected output variables to “supervise” an algorithm as it learns to predict output variables, and where unsupervised learning, there is data, but expectations of the data are unknown so the algorithm learns features without the supervision of a programmer. Within supervised learning, the two main problems to solve are classification problems, where the output variable is a category, and regression problems, where the output variable is a tangible amount or value. This technology is very important in many applications, such as image recognition, pose estimation, systems biology, and disease detection. Supervised learning methods also apply different levels of pre-processing for better results, although the preprocessing is many times up to user discretion. One common method of pre-processing data is through principal component analysis, where data is rearranged into its most descriptive modes and directions.  

In this work, supervised classification algorithms are explored for the application of three different supervised classification algorithms, Naïve Bayes (NB), K nearest neighbors (Knn), and classification trees (CART). These three algorithms which work under different assumptions and methods applied with and without principal component analysis preprocessing through singular value decomposition to classify H1B employment applications. The H1B employment applications are applications for the United States to bring in foreign workers, and can have the cast status of certified, withdrawn (because the process is long), denied, or certified but withdrawn. In the first part, training data was taken to be random sample of 25000 applications (of 27932 applications) with their labels in their original format. All attributes of the applications (given by columns) with string type labels were first converted to numerical values to be able to be compatible with the classification algorithms. Then this entire matrix of training data and its labels were used to train each algorithm. The remaining 2932 H1B applications with known case status labels were then tested for each model to measure their accuracies. This process was repeated five times to cross validate the model and results.  

In the second part, the methods were repeated exactly as the first part, except the principal component analysis preprocessing was used through singular value decomposition (SVD). After changing string type labels to numerical values, principal component analysis was done on the matrix. In the new principal component space, the V matrix was taken as the training data, and then used to train the algorithms. The testing data was also converted to the principal component space before being applied to the models to measure the accuracies. This process was also repeated five times to cross validate the model and results.

##	Theoretical Background

The four concepts to elaborate on is the SVD, NB, Knn, and CART.  

Singular value decomposition method is a type of principal component analysis that essentially takes an inputted matrix A, and decomposes it into 3 matrices, U, Σ, and V such that
<h5 align=center> A=UΣV^* </h5>  

where * denotes a complex conjugate transpose. In one sense, the SVD takes in data, and in three sequences, first rotating the matrix (U), then stretching the matrix (Σ), and finally rotating the matrix, obtains a coordinate system that describes the inputted data in the most efficient and accurate way in L2 norm, the least squares approximation. In another sense, the SVD rewrites a data matrix so that it is described with orthonormal directions/components, preventing redundancies between data in the matrix, and thus making it computationally easy and efficient to work with.  

When organized in columns, the UΣ returns vectors of weighted principal components that shows directions in this new basis, and how important each direction is in capturing the data in the given matrix. The V matrix describes how each individual row vector (equivalent to the column vectors in V*) of the original matrix is projected onto the weighted principal component directions. Essentially in this work, the data matrix of the H1B applications is analyzed by SVD to describe it in a coordinate system that best maps the data, so that the mapping of V row vectors onto this space is descriptive and efficient for both the training data, and the test data. The models will be trained with and without SVD and compared to note any improvements in the models from preprocessing the data with SVD.  

There are three supervised learning algorithms being utilized in this work, namely the NB method, Knn method, and CART method. The NB method is a classification method that uses the probability of features in the data to robustly determine and classify test data. This method uses the probability of a feature being present given that it belongs in a group, and then mirrors it to the probability of when given a feature, considers the chances of it belonging to a group. These probabilities are multiplicatied in such a way that determines the best classification for a given data. The Naïve Bayes method assumes independency between the features, and all the attributes and labels of the data are considered on their own, and then brought together.  

The Knn method uses an intuitive style of classification, where training data is first mapped in space according to their attributes. The test data is then mapped separately onto this map, and based on which training “k” data points are closest to the test data, the test data is classified accordingly. The exact method on the weights of distance between the nearest neighbors and how many neighbors factor into the classification can be decided by the user. In this work, 1 nearest neighbor was used.  

The CART method uses a basic decision tree to map out the training data and determine borders to make nonlinear, efficient boundaries for the different classes that best separates them. The mapped test data then is classified according to where lies on this map.

## Algorithm Implementation and Development
MATLAB programming language and software was used for this work, for all parts including the import, preprocessing, model building, and model testing of the data.  

The code begins with importing a csv file into MATLAB using readtable. This command was used instead of the csvread command because of the string elements in the data. A separate data matrix for this work is created based on this original table, by taking in data labels with numerical values first. The table’s string attributes in column are identified, and then converted to numerical values using a combination of cell arrays and strcmp. The cell array is first declared by giving it the string value from the first row of the specific attribute. Then in a loop of all the rows, the string from the ith row of the same attribute/column is compared to the original cell array through strcmp. If the string matches any of the elements in the cell array, then the data matrix at that specific row and column (category) takes on the index location value of that specific string data from the cell array. If not, the cell array is modified to contain the new string, and the data matrix at that specific row and column takes on that new index location of the string in the cell array. This process is repeated for all numerical categories (in columns) and string categories except column 8, 10, 19, 20, 21, 22, and 26. These omitted attributes fall in four categories – all entries in the attribute are unique and therefore will not help in training the model, all entries in the attribute are the same, the information is incomplete and inconsistent, or the information is repeated from another column. This was also done because of the computation time to process these columns.  

After the entire data matrix is built, the data points were randomized for the cross validation trials. 25000 random points were chosen for the training data and 2932 were chosen for the testing data. These data sets were separated from the categories/attributes and the case status category, which act as the labels for the data. In the first case, the SVD portion is commented out, and the model is built for the knn model, tested, and recorded for error in each case status category and in total. This procedure is similarly done with the NB model, and CART model. This script is run five times to cross validate.  

In the second part of this work, the SVD preprocessing portion is uncommented out, and then applied to the training and testing data before building and testing the models. The rest of the script is kept the same.

## Computational Results
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152432105-47a347ef-651e-412f-a157-01fb782cc142.png" />
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152432142-7726f38e-cce8-4b33-b0c8-c11caf3219c6.png" />
</p>
<p align="center"> 
Figure 1, 2: Accuracy of Classification Tree Model 1) Without SVD, and 2) With SVD
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152432266-b785c203-995a-4343-b1d2-4738e60ca41e.png" />
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152432317-1c868a7e-22f6-48a5-a3d8-b50eed5a3b5e.png" />
</p>
<p align="center"> 
Figure 3, 4: Accuracy of Knn Classification Model 1) Without SVD, and 2) With SVD
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152432414-6c06d997-2704-4252-9f22-890f090d84b1.png" />
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152432447-3055f821-55bd-41e3-916b-19d8ab9f5e29.png" />
</p>
<p align="center"> 
Figure 5, 6: Accuracy of Naïve Bayes Classification Model 1) Without SVD, and 2) With SVD
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/89391443/152432548-eec86bb4-3f4b-4cf2-b58a-333d82bfca22.png" />
</p>
<p align="center"> 
Figure 7: Total Accuracy Comparison of Different Classification Methods with and without SVD
</p>

## Summary and Conclusions
In this work, classification models were built for H1B employment applications to differentiate and predict between four case statuses – certified, withdrawn, certified but withdrawn, and denied. In doing so, the raw data table was first processed into a data matrix by assigning numerical identification values in place of string values. This data matrix, in its raw numerical data state, was then used to train, test, and cross validate the accuracy of NB, CART, and Knn classification models. In a second part, the data had the SVD performed on it before training, testing, and cross validating NB, CART, and Knn classification models. There are several important findings in the results to be discussed.  

For overall results, the CART is shown to be more accurate in its model than the Knn model and NB model, with or without SVD preprocessing. The reason for this may be that the CART has both flexibility and accuracy to separate its clusters dynamically (in sharp and decisive turns) according to the highest accuracy. The Knn model is flexible and robust, but inherently may not have a higher accuracy than the CART model with just one neighbor. The NB model, which was significantly less accurate than the CART model all around and less accurate than the Knn model when preprocessed in the same ways, is very robust and simple in its modeling, but also assumes no relation between its “features”. For classification problems where the features and attributes are related with one another, this can be a bad assumption, and probably contributed to this method being the most inaccurate model of the three in this application.  

As evident in figures 1 through 6, the certified but withdrawn category of the case status was more accurately predicted, although not as extremely in the case of Knn without SVD preprocessing. This probably means that the data itself had very obvious signs and relations for applications that were categorized as certified but withdrawn that made it easy to separate and classify regardless of the model. Besides this pattern, each model had their own specific patterns.  

The CART models from figure 1 and 2 exhibit nearly identical results regardless of SVD processing, always with more than 50% accuracy across all categories. With the consistently high accuracy, the denied category was most often mislabeled in this method, while the certified and withdrawn categories were similar in accuracy and more accurate than the denied category. The SVD preprocessing in this case may not have helped the model to become more accurate, because the CART method was already detailed and dynamic enough to capture the differences between data points that may have sharp turns in its borders. Therefore, this method did not require mapping of the data to a more orthogonal principal component basis to be able to build its model.  

The Knn models in figure 3 and 4 show different results. The Knn model in figure 3 consistently shows results for all categories to be between 30%-50% accuracy, with ~50% accuracy only for the certified but withdrawn category. This method is consistent in its inaccuracy, and the big jump in its accuracy in figure 4 with the preprocessing with SVD for all field indicates that in its original representation, the data was clumped and hard to distinguish. This in turn means that when the Knn algorithm runs for a test point, the closest neighbor may not resemble it accurately. By mapping onto the SVD basis, the representation of the data attributes is guaranteed to be orthonormal, so that the algorithm can more accurately distinguish the characteristics and attributes of the training data and apply it to the test data. The improvements in figure 4 with SVD from figure 3 are consistently 20% or more in all of the four categories, proving the effectiveness of preprocessing for this data through SVD.  

In the case of the NB model, figure 7 shows that overall, the accuracy of the model has improved a great deal. Although this is true, figure 5 and 6 show more details that may point to the model being very imprecise through its cross validations. In figure 5, without the SVD processing, the model almost never guessed the certified category correctly, the withdrawn category was less than 40% in accuracy, the denied category was less than 20% accuracy, and somehow, the certified but withdrawn category was as accurate as the CART model’s. However, in figure 6, although there were improvements across the board for all categories, the data did become noisier with cross validations. This means that the specific data used to perform SVD and then train the models had a lot to do with the accuracy of the randomly selected data itself. The general improvement by doing preprocessing can most likely be attributed to the SVD being able to describe the data in orthogonal bases, where the features in this case might be less related to each other, so that the NB assumption of this idea can be more accurate. However, perhaps the noise in the data may be attributed to which data is chosen to build the orthogonal bases, so that the application to the test data might not be as accurate.  

Overall, the improvement in accuracy through SVD was significant for models that weren’t as dynamic and flexible as the CART method and should be done as good practice when appropriate. Otherwise, the CART model is best in predicting and classifying H1B Applications by the case status categories compared to the NB model, and the Knn model with one neighbor.
