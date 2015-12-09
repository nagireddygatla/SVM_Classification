function [finalData]=PCA_DimensionReduction(input,rowtemp,coltemp,kval)

meanNormalize=zeros(rowtemp,coltemp);

%Just perform mean normalization such that the mean of each column is zero
for i=1:coltemp
  colsum=sum(input(1:rowtemp,i));
  colAvg=colsum/rowtemp;
  for j=1:rowtemp
    meanNormalize(j,i)=input(j,i)-colAvg;
  end;
end;

%Calculate covariance matric from mean normalized vector
CovarMatrix=cov(meanNormalize);
%Perform eigs or svd function to get the eigen vector, to be precise eigen
%plane
[eigvec,eigval]=eigs(CovarMatrix,kval);
%if we perform product of eigen vector and mean normalized vector we get di
finalData=meanNormalize * eigvec;