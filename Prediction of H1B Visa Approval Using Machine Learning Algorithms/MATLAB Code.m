clear all;
close all;
clc;

% All data was downloaded from https://www.kaggle.com/trivedicharmi/h1b-disclosure-dataset.
Applications='H1B Dataset.csv';
data=readtable(Applications,'TextType','string');
Data=zeros(size(data,1),size(data,2));
for i=1:size(data,1) %clean up the data into classes we can use. 
    Data(i,1:6)=data{i,1:6};
    if i==1
        col7=data{1,7};
        col9=data{1,9};
        col10=data{1,10};
        col11=data{1,11};
        col14=data{1,14};
        col16=data{1,16};
        col17=data{1,17};
        col23=data{1,23};
        col24=data{1,24};
        col25=data{1,25};
        col27=data{1,27};
    elseif max(strcmp(col7,data{i,7}))==0
       col7=[col7 data{i,7}];
       Data(i,7)=(size(col7,2));
    else 
       Data(i,7)=find(strcmp(col7,data{i,7}),1);
    end
    
    if max(strcmp(col9,data{i,9}))==0
       col9=[col9 data{i,9}];
       Data(i,8)=(size(col9,2));
    else 
       Data(i,8)=find(strcmp(col9,data{i,9}),1);
    end
    
    if max(strcmp(col10,data{i,10}))==0
       col10=[col10 data{i,10}];
       Data(i,9)=(size(col10,2));
    else 
       Data(i,9)=find(strcmp(col10,data{i,10}),1);
    end
    
    if max(strcmp(col11,data{i,11}))==0
       col11=[col11 data{i,11}];
       Data(i,10)=(size(col11,2));
    else 
       Data(i,10)=find(strcmp(col11,data{i,11}),1);
    end
    
    Data(i,11:12)=data{i,12:13};
    
    if max(strcmp(col14,data{i,14}))==0
       col14=[col14 data{i,14}];
       Data(i,13)=(size(col14,2));
    else 
       Data(i,13)=find(strcmp(col14,data{i,14}),1);
    end
    
    Data(i,14)=data{i,15};
 
    if max(strcmp(col16,data{i,16}))==0
       col16=[col16 data{i,16}];
       Data(i,15)=(size(col16,2));
    else 
       Data(i,15)=find(strcmp(col16,data{i,16}),1);
    end
    
    if max(strcmp(col17,data{i,17}))==0
       col17=[col17 data{i,17}];
       Data(i,16)=(size(col17,2));
    else 
       Data(i,16)=find(strcmp(col17,data{i,17}),1);
    end
    
    Data(i,17)=data{i,18};
    
    if max(strcmp(col23,data{i,23}))==0
       col23=[col23 data{i,23}];
       Data(i,18)=(size(col23,2));
    else 
       Data(i,18)=find(strcmp(col23,data{i,23}),1);
    end
    
    if max(strcmp(col24,data{i,24}))==0
       col24=[col24 data{i,24}];
       Data(i,19)=(size(col24,2));
    else 
       Data(i,19)=find(strcmp(col24,data{i,24}),1);
    end
    
    if max(strcmp(col25,data{i,25}))==0
       col25=[col25 data{i,25}];
       Data(i,20)=(size(col25,2));
    else 
       Data(i,20)=find(strcmp(col25,data{i,25}),1);
    end
    
    if max(strcmp(col27,data{i,27}))==0
       col27=[col27 data{i,27}];
       Data(i,22)=(size(col27,2));
    else 
       Data(i,22)=find(strcmp(col27,data{i,27}),1);
    end
end
    
%%
Data(:,9)=[];
Data(:,17)=[];

%take random training data
randomizedtrain=datasample(Data(:,:),size(Data,1),'Replace',false);
TrainData=randomizedtrain(1:25000,:);
TestData=randomizedtrain(25001:end,1:end-1);
label=TrainData(:,end);
Data=TrainData(:,(1:end-1));
Data(isnan(Data))=0;
 
%preprocessing with SVD
[u,s,v]=svd(Data.','econ');
Data=v;
ctrain=[ones(60,1);2*ones(60,1);3*ones(60,1)];

%project test data onto SVD space
TestData=inv(s)*u'*TestData';
TestData=TestData';

%Build and Test KNN
knn=fitcknn(Data,label);
preknn=predict(knn,TestData);
 

errork=0;
Correctvaluesk=[0];
for i=1:size(preknn,1)
    if preknn(i)~= randomizedtrain(i+25000,end)
        errork=errork+1;
        Correctvaluesk=[Correctvaluesk randomizedtrain(i+25000,end)];
    end
end
Totalaccuracyk=1-errork/size(TestData,1);
PredictorAcck=[1-sum(Correctvaluesk(:) == 1)/sum(randomizedtrain(25001:end,end) == 1);
1-sum(Correctvaluesk(:) == 2)/sum(randomizedtrain(25001:end,end)==2); 
1-sum(Correctvaluesk(:) == 3)/sum(randomizedtrain(25001:end,end)==3);
1-sum(Correctvaluesk(:) == 4)/sum(randomizedtrain(25001:end,end)==4)];
%%

%Build and Test NB
nb=fitcnb(Data,label);
prenb=predict(nb,TestData);
 
errornb=0;
Correctvaluesnb=[0];
for i=1:size(prenb,1)
    if prenb(i)~= randomizedtrain(i+25000,end)
        errornb=errornb+1;
        Correctvaluesnb=[Correctvaluesnb randomizedtrain(i+25000,end)];
    end
end
Totalaccuracynb=1-errornb/size(TestData,1);
PredictorAccnb=[1-sum(Correctvaluesnb(:) == 1)/sum(randomizedtrain(25001:end,end) == 1);
1-sum(Correctvaluesnb(:) == 2)/sum(randomizedtrain(25001:end,end)==2); 
1-sum(Correctvaluesnb(:) == 3)/sum(randomizedtrain(25001:end,end)==3);
1-sum(Correctvaluesnb(:) == 4)/sum(randomizedtrain(25001:end,end)==4)];
 
%Build and Test CART 
tree=fitctree(Data,label);
preca=predict(tree,TestData);
 
errorca=0;
Correctvaluesca=[0];
for i=1:size(preca,1)
    if preca(i)~= randomizedtrain(i+25000,end)
        errorca=errorca+1;
        Correctvaluesca=[Correctvaluesca randomizedtrain(i+25000,end)];
    end
end
TotalaccuracyC=1-errorca/size(TestData,1);
PredictorACCca=[1-sum(Correctvaluesca(:) == 1)/sum(randomizedtrain(25001:end,end) == 1);
1-sum(Correctvaluesca(:) == 2)/sum(randomizedtrain(25001:end,end) == 2); 
1-sum(Correctvaluesca(:) == 3)/sum(randomizedtrain(25001:end,end) == 3);
1-sum(Correctvaluesca(:) == 4)/sum(randomizedtrain(25001:end,end) == 4)];

