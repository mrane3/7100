function [ newfeatvector ] = aggregatefeaturespertrack(x,windowSize,hopSize,fs)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
newfeatvector=[];
featvector= getframefeatures( x,windowSize,hopSize,fs );
[row col]=size(featvector)
[nvt] = myWPD(x, windowSize, hopSize);
[onsetTimeInSec] = myOnsetDetection(nvt, fs, windowSize, hopSize) ;

IOI=(diff(onsetTimeInSec));
IOIFlatness= geomean(IOI)/mean(IOI);


for featcount=1:row
     newfeatvector=[newfeatvector max(featvector(:,featcount)) mean(featvector(:,featcount)) var(featvector(:,featcount)) ];
end

newfeatvector=[newfeatvector IOIFlatness];
