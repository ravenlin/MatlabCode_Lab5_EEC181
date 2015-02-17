function output = sFunc(BiasL1, BiasL2, WeightL1, WeightL2, WeightFinal,x)

%load('NN.mat');
load('testSet.mat');
[photo,map] = imread('http://eec181.ucdavis.edu:8081/photo.jpg, 'jpg')
data = testData(:,x);
% for i = 1:number of digits
temp = check(BiasL1, BiasL2, WeightL1, WeightL2, WeightFinal,data);
output = output +(temp*10^i);

actual = testLabels(x)
end