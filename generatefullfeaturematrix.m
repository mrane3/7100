function [featmat] = generatefullfeaturematrix
windowSize=1028;
hopSize=512;
featmat=[];
for filecount=1:20
    cd('/Users/milaprane/Documents/7100/Dataset/Artist 2');
   [x fs]=audioread(strcat(num2str(filecount),'.wav'));
    cd('/Users/milaprane/Documents/7100/');
    featmat=[featmat;aggregatefeaturespertrack(x,windowSize,hopSize,fs)];
end

