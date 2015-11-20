function [ featurevect] = getmetadata 
featurevect=[];
 [x fs]= audioread('/Users/milaprane/Documents/7100/Dataset/Artist 1/1.m4a');
 featurevect=horzcat(featurevect,getframefeatures(x,2048,1024,fs ));
end



