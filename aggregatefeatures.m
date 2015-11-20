function [ newfeatvector ] = aggregatefeaturespertrack(featvector,x,windowSize,hopSize,fs)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[nvt] = myWPD(x, windowSize, hopSize);
onsetTimeInSec= ((newlocs-1)*(hopSize+1)/fs);
IOI=(diff(onsetTimeInSec));
IOIFlatness= geomean(IOI)/mean(IOI);

end

