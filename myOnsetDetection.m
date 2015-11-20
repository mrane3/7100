function [onsetTimeInSec] = myOnsetDetection(nvt, fs, windowSize, hopSize) 
[thres] = myMedianThres(nvt,100, 0.3);
[peaks locs]= findpeaks(nvt);
newlocs=[];
for count=1:length(peaks)
    if peaks(count)> thres(locs(count))
       newlocs=[newlocs locs(count)];
    end
end
onsetTimeInSec= ((newlocs-1)*(hopSize+1)/fs);
