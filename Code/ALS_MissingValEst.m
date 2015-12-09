
function [angleDifference]=ALS_MissingValEst(inputfile,outputfile,rowcount)
missingdata =load(inputfile);
[l, m] = size(missingdata);
temp = missingdata;

for p = 1:l
    for q = 1:m
if temp(p, q) == 0;
    temp(p, q) = -100;
end
    end
end

for i = 1:l
    for j = 1:m
if missingdata(i, j) == (1.00000000000000e+99);
    missingdata(i, j) = NaN;
end
    end
end

[coeff,score,latent,tsquared,explained] = pca(missingdata);

[coeff1,score1,latent,tsquared,explained,mu1] = pca(missingdata,'algorithm','als');
disp(size(mu1));
disp(size(score1*coeff1'));
t = score1*coeff1' + repmat(mu1,rowcount,1);
%xlswrite(t);

angleDifference = subspace(coeff,coeff1);


for r = 1:l
    for s = 1:m
if temp(r, s) == -100;
    t(r, s) = 0;
end
    end
end

xlswrite(outputfile,t);
end
