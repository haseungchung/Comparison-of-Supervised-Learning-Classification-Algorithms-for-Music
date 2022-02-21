%% Part 1
for p=1:5
clc;
 
cd ACDC
CY(1:25)=dir('**/*.mp3'); % building structure of songs
cd ..
cd JohnMayer
CY(26:50)=dir('**/*.mp3');
cd ..
cd Yiruma
CY(51:75)=dir('**/*.mp3');
cd ..
 
CY2(1:25,1)=datasample(CY(1:25),25,'Replace',false); % randomizing order
CY2(26:50,1)=datasample(CY(26:50),25,'Replace',false);
CY2(51:75,1)=datasample(CY(51:75),25,'Replace',false);
 
CY3(1:20,1)=CY2(1:20); % randomized training data songs
CY3(21:40,1)=CY2(26:45);
CY3(41:60,1)=CY2(51:70);
 
CY4(1:5,1)=CY2(21:25); % randomized test data songs
CY4(6:10,1)=CY2(46:50);
CY4(11:15,1)=CY2(71:75);
 
 
for i=1:size(CY3,1)
    [y,Fs]=audioread(CY3(i).name); % reads training data audio
    start=round(rand*0.9*size(y,1)); % picks random start point
    start2=round(rand*0.9*size(y,1));
    start3=round(rand*0.9*size(y,1));
    temp=y(start:5*Fs+start,:); % picks 5 second clip
    temp2=y(start2:5*Fs+start2,:);
    temp3=y(start3:5*Fs+start3,:);
    temp=temp';
    temp2=temp2';
    temp3=temp3';
    for ii=1:size(temp,2)
        if temp(1,ii)==0 || temp(2,ii)==0
            mono(ii)=max(temp(:,ii));
        else 
            mono(ii)=mean(temp(:,ii));
        end
    end
    for ii=1:size(temp2,2)
        if temp2(1,ii)==0 || temp2(2,ii)==0
            mono2(ii)=max(temp2(:,ii));
        else 
            mono2(ii)=mean(temp2(:,ii));
        end
    end
    for ii=1:size(temp3,2)
        if temp3(1,ii)==0 || temp3(2,ii)==0
            mono3(ii)=max(temp3(:,ii));
        else 
            mono3(ii)=mean(temp3(:,ii));
        end
    end
    spec=spectrogram(mono); % takes spectrogram
    spec2=spectrogram(mono2);
    spec3=spectrogram(mono3);
    A(:,3*i-2)=reshape(spec,[],1); % reshapes spectrogram into vector and stacks
    A(:,3*i-1)=reshape(spec2,[],1);
    A(:,3*i)=reshape(spec3,[],1);
 
end
 
for i=1:size(CY4,1)
    [y,Fs]=audioread(CY4(i).name); % reads test data audio
    startt=round(rand*0.9*size(y,1));
    tempt=y(startt:5*Fs+startt,:);
    tempt=tempt';
    for ii=1:size(tempt,2)
        if tempt(1,ii)==0 || tempt(2,ii)==0
            mono(ii)=max(tempt(:,ii));
        else 
            mono(ii)=mean(tempt(:,ii));
        end
    end
    spect=spectrogram(mono);
    B(:,i)=reshape(spect,[],1);
end
[u,s,v]=svd(abs(A),'econ'); % svd of training data matrix
 
train=v; % training data in vectors 
ctrain=[ones(60,1);2*ones(60,1);3*ones(60,1)]; % classification of training data
test=inv(s)*u'*abs(B); % test data in principal component space
test=test';
nb=fitcnb(train,ctrain); % builds NB model
prenb=predict(nb,test); % predicts using NB
 
tree2=fitctree(train,ctrain); % builds CART model
preca=predict(tree2,test); % predicts using cart
 
ctrainsvm1=[ones(60,1);2*ones(60,1);2*ones(60,1)];
svmmodel=fitcsvm(train,ctrainsvm1); %builds svm model
presvm1=predict(svmmodel,test);
ctrainsvm2=[2*ones(60,1);2*ones(60,1);3*ones(60,1)];
svmmodel2=fitcsvm(train,ctrainsvm2); %builds svm model
presvm2=predict(svmmodel2,test);
presvm=zeros(size(presvm1,1),1);
for i=1:size(presvm,1)
    if presvm1(i) == 1
        presvm(i)=1;
    elseif presvm2(i) == 3
            presvm(i)=3;
    else
        presvm(i)= 2;
    end
end
 
errorca=0;
for i=1:size(preca,1)
    if i<=5 && preca(i)~=1
        errorca=errorca+1;
    elseif i>5 && i<=10 && preca(i)~=2
        errorca=errorca+1;
    elseif i>10 && i<=15 && preca(i)~=3
        errorca=errorca+1;
    else
        errorca;
    end
end
accca(p)=1-errorca/size(preca,1); %calculates accuracy of CART model
 
errornb=0;
for i=1:size(prenb,1)
    if i<=5 && prenb(i)~=1
        errornb=errornb+1;
    elseif i>5 && i<=10 && prenb(i)~=2
        errornb=errornb+1;
    elseif i>10 && i<=15 && prenb(i)~=3
        errornb=errornb+1;
    else
        errornb;
    end
end
accnb(p)=1-errornb/size(prenb,1); % calculates accuracy of NB model
 
errorsvm=0;
for i=1:size(presvm,1)
    if i<=5 && presvm(i)~=1
        errorsvm=errorsvm+1;
    elseif i>5 && i<=10 && presvm(i)~=2
        errorsvm=errorsvm+1;
    elseif i>10 && i<=15 && presvm(i)~=3
        errorsvm=errorsvm+1;
    else
        errorsvm;
    end
end
accsvm(p)=1-errorsvm/size(presvm,1); % calculates accuracy of SVM model
clearvars -except accsvm accnb accca
end

%% Part 2
for p=6:10
close all;
clc;
 
cd ACDC
CY(1:25)=dir('**/*.mp3');
cd ..
cd BlackSabbath
CY(26:50)=dir('**/*.mp3');
cd ..
cd Metallica
CY(51:75)=dir('**/*.mp3');
cd ..
 
CY2(1:25,1)=datasample(CY(1:25),25,'Replace',false);
CY2(26:50,1)=datasample(CY(26:50),25,'Replace',false);
CY2(51:75,1)=datasample(CY(51:75),25,'Replace',false);
 
CY3(1:20,1)=CY2(1:20);
CY3(21:40,1)=CY2(26:45);
CY3(41:60,1)=CY2(51:70);
 
CY4(1:5,1)=CY2(21:25);
CY4(6:10,1)=CY2(46:50);
CY4(11:15,1)=CY2(71:75);
 
 
for i=1:size(CY3,1)
    [y,Fs]=audioread(CY3(i).name);
    start=round(rand*0.9*size(y,1));
    start2=round(rand*0.9*size(y,1));
    start3=round(rand*0.9*size(y,1));
    temp=y(start:5*Fs+start,:);
    temp2=y(start2:5*Fs+start2,:);
    temp3=y(start3:5*Fs+start3,:);
    temp=temp';
    temp2=temp2';
    temp3=temp3';
 
    for ii=1:size(temp,2)
        if temp(1,ii)==0 || temp(2,ii)==0
            mono(ii)=max(temp(:,ii));
        else 
            mono(ii)=mean(temp(:,ii));
        end
    end
    for ii=1:size(temp2,2)
        if temp2(1,ii)==0 || temp2(2,ii)==0
            mono2(ii)=max(temp2(:,ii));
        else 
            mono2(ii)=mean(temp2(:,ii));
        end
    end
    for ii=1:size(temp3,2)
        if temp3(1,ii)==0 || temp3(2,ii)==0
            mono3(ii)=max(temp3(:,ii));
        else 
            mono3(ii)=mean(temp3(:,ii));
        end
    end
    spec=spectrogram(mono);
    spec2=spectrogram(mono2);
    spec3=spectrogram(mono3);
    A(:,3*i-2)=reshape(spec,[],1);
    A(:,3*i-1)=reshape(spec2,[],1);
    A(:,3*i)=reshape(spec3,[],1);
 
end
 
for i=1:size(CY4,1)
    [y,Fs]=audioread(CY4(i).name);
    startt=round(rand*0.9*size(y,1));
    tempt=y(startt:5*Fs+startt,:);
    tempt=tempt';
    for ii=1:size(tempt,2)
        if tempt(1,ii)==0 || tempt(2,ii)==0
            mono(ii)=max(tempt(:,ii));
        else 
            mono(ii)=mean(tempt(:,ii));
        end
    end
    spect=spectrogram(mono);
    B(:,i)=reshape(spect,[],1);
end
[u,s,v]=svd(abs(A),'econ');
 
train=v;
ctrain=[ones(60,1);2*ones(60,1);3*ones(60,1)];
 
test=inv(s)*u'*abs(B);
test=test';
nb=fitcnb(train,ctrain);
prenb=predict(nb,test);
 
tree2=fitctree(train,ctrain);
preca=predict(tree2,test);
 
ctrainsvm1=[ones(60,1);2*ones(60,1);2*ones(60,1)];
svmmodel=fitcsvm(train,ctrainsvm1);
presvm1=predict(svmmodel,test);
ctrainsvm2=[2*ones(60,1);2*ones(60,1);3*ones(60,1)];
svmmodel2=fitcsvm(train,ctrainsvm2);
presvm2=predict(svmmodel2,test);
presvm=zeros(size(presvm1,1),1);
for i=1:size(presvm,1)
    if presvm1(i) == 1
        presvm(i)=1;
    elseif presvm2(i) == 3
            presvm(i)=3;
    else
        presvm(i)= 2;
    end
end
 
errorca=0;
for i=1:size(preca,1)
    if i<=5 && preca(i)~=1
        errorca=errorca+1;
    elseif i>5 && i<=10 && preca(i)~=2
        errorca=errorca+1;
    elseif i>10 && i<=15 && preca(i)~=3
        errorca=errorca+1;
    else
        errorca;
    end
end
accca(p)=1-errorca/size(preca,1);
 
errornb=0;
for i=1:size(prenb,1)
    if i<=5 && prenb(i)~=1
        errornb=errornb+1;
    elseif i>5 && i<=10 && prenb(i)~=2
        errornb=errornb+1;
    elseif i>10 && i<=15 && prenb(i)~=3
        errornb=errornb+1;
    else
        errornb;
    end
end
accnb(p)=1-errornb/size(prenb,1);
 
errorsvm=0;
for i=1:size(presvm,1)
    if i<=5 && presvm(i)~=1
        errorsvm=errorsvm+1;
    elseif i>5 && i<=10 && presvm(i)~=2
        errorsvm=errorsvm+1;
    elseif i>10 && i<=15 && presvm(i)~=3
        errorsvm=errorsvm+1;
    else
        errorsvm;
    end
end
accsvm(p)=1-errorsvm/size(presvm,1);
clearvars -except accca accnb accsvm
end
 

%% Part 3
for p=11:15
clc;
 
cd Classical
CY(1:25)=dir('**/*.mp3');
cd ..
cd LoFiHipHop
CY(26:50)=dir('**/*.mp3');
cd ..
cd PunkRock
CY(51:75)=dir('**/*.mp3');
cd ..
 
CY2(1:25,1)=datasample(CY(1:25),25,'Replace',false);
CY2(26:50,1)=datasample(CY(26:50),25,'Replace',false);
CY2(51:75,1)=datasample(CY(51:75),25,'Replace',false);
 
CY3(1:20,1)=CY2(1:20);
CY3(21:40,1)=CY2(26:45);
CY3(41:60,1)=CY2(51:70);
 
CY4(1:5,1)=CY2(21:25);
CY4(6:10,1)=CY2(46:50);
CY4(11:15,1)=CY2(71:75);
 
 
for i=1:size(CY3,1)
    [y,Fs]=audioread(CY3(i).name);
    start=round(rand*0.9*size(y,1));
    start2=round(rand*0.9*size(y,1));
    start3=round(rand*0.9*size(y,1));
    temp=y(start:5*Fs+start,:);
    temp2=y(start2:5*Fs+start2,:);
    temp3=y(start3:5*Fs+start3,:);
    temp=temp';
    temp2=temp2';
    temp3=temp3';
 
    for ii=1:size(temp,2)
        if temp(1,ii)==0 || temp(2,ii)==0
            mono(ii)=max(temp(:,ii));
        else 
            mono(ii)=mean(temp(:,ii));
        end
    end
    for ii=1:size(temp2,2)
        if temp2(1,ii)==0 || temp2(2,ii)==0
            mono2(ii)=max(temp2(:,ii));
        else 
            mono2(ii)=mean(temp2(:,ii));
        end
    end
    for ii=1:size(temp3,2)
        if temp3(1,ii)==0 || temp3(2,ii)==0
            mono3(ii)=max(temp3(:,ii));
        else 
            mono3(ii)=mean(temp3(:,ii));
        end
    end
    spec=spectrogram(mono);
    spec2=spectrogram(mono2);
    spec3=spectrogram(mono3);
    A(:,3*i-2)=reshape(spec,[],1);
    A(:,3*i-1)=reshape(spec2,[],1);
    A(:,3*i)=reshape(spec3,[],1);
 
end
 
for i=1:size(CY4,1)
    [y,Fs]=audioread(CY4(i).name);
    startt=round(rand*0.9*size(y,1));
    tempt=y(startt:5*Fs+startt,:);
    tempt=tempt';
    for ii=1:size(tempt,2)
        if tempt(1,ii)==0 || tempt(2,ii)==0
            mono(ii)=max(tempt(:,ii));
        else 
            mono(ii)=mean(tempt(:,ii));
        end
    end
    spect=spectrogram(mono);
    B(:,i)=reshape(spect,[],1);
end
[u,s,v]=svd(abs(A),'econ');
train=v;
ctrain=[ones(60,1);2*ones(60,1);3*ones(60,1)];
 
test=inv(s)*u'*abs(B);
test=test';
nb=fitcnb(train,ctrain);
prenb=predict(nb,test);
 
tree2=fitctree(train,ctrain);
preca=predict(tree2,test);
 
ctrainsvm1=[ones(60,1);2*ones(60,1);2*ones(60,1)];
svmmodel=fitcsvm(train,ctrainsvm1);
presvm1=predict(svmmodel,test);
ctrainsvm2=[2*ones(60,1);2*ones(60,1);3*ones(60,1)];
svmmodel2=fitcsvm(train,ctrainsvm2);
presvm2=predict(svmmodel2,test);
presvm=zeros(size(presvm1,1),1);
for i=1:size(presvm,1)
    if presvm1(i) == 1
        presvm(i)=1;
    elseif presvm2(i) == 3
            presvm(i)=3;
    else
        presvm(i)= 2;
    end
end
 
errorca=0;
for i=1:size(preca,1)
    if i<=5 && preca(i)~=1
        errorca=errorca+1;
    elseif i>5 && i<=10 && preca(i)~=2
        errorca=errorca+1;
    elseif i>10 && i<=15 && preca(i)~=3
        errorca=errorca+1;
    else
        errorca;
    end
end
accca(p)=1-errorca/size(preca,1);
 
errornb=0;
for i=1:size(prenb,1)
    if i<=5 && prenb(i)~=1
        errornb=errornb+1;
    elseif i>5 && i<=10 && prenb(i)~=2
        errornb=errornb+1;
    elseif i>10 && i<=15 && prenb(i)~=3
        errornb=errornb+1;
    else
        errornb;
    end
end
accnb(p)=1-errornb/size(prenb,1);
 
errorsvm=0;
for i=1:size(presvm,1)
    if i<=5 && presvm(i)~=1
        errorsvm=errorsvm+1;
    elseif i>5 && i<=10 && presvm(i)~=2
        errorsvm=errorsvm+1;
    elseif i>10 && i<=15 && presvm(i)~=3
        errorsvm=errorsvm+1;
    else
        errorsvm;
    end
end
accsvm(p)=1-errorsvm/size(presvm,1);
clearvars -except accca accnb accsvm
end
