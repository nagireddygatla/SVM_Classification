function [testlabels]=startup_classification(trndata,trnlabel,tstsdata,k)
Traindata = load(trndata);
[rowval,colval] = size(Traindata);

%Get the PCA dimension reduced train data
[trainfinalData] = PCA_DimensionReduction(Traindata,rowval,colval,k);
trainlabel = load(trnlabel);

Testdata = load(tstsdata);
[tstrows,tstcols] = size(Testdata);
%Get the PCA dimension reduced test data
[testfinalData] = PCA_DimensionReduction(Testdata,tstrows,tstcols,k);
uniqClsLbl=unique(trainlabel);

ClsLblCount=length(uniqClsLbl);

[tstrw tstcol]=size(testfinalData);
testlabels = zeros(tstrw,1);

%Get training model for all the labels by performing one vs all type
%operation
for i=1:ClsLblCount

    onevsall=(trainlabel==uniqClsLbl(i));
    trainmodel(i) = svmtrain(trainfinalData,onevsall);
end

%use train model and pass testing data to classify, i.e. assign labels to
%test label matrix
for i=1:tstrw
    for j=1:ClsLblCount
        if(svmclassify(trainmodel(j),testfinalData(i,:))) 
            break;
        end
    end
    testlabels(i) = j;
end
