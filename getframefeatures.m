function [newfeatvector] = getframefeatures( x,windowSize,hopSize,fs )
%UNTITLED2 Summary of this function goes here
%   This function extracts features which are to be extracted framewise,and
%   generates a framewise feature vector that is later aggregated.
%   featvector=[spectral_centroid, zcr, spectral_crest,spectral_flux,max_env] ;

windowStart = 1 ;
windowEnd = windowSize ;
numSamples= length(x);
featvector=[];
while(windowEnd < numSamples-windowSize)
    currFrame =x(windowStart:windowEnd);
    featvector = vertcat(abs(extract_features(currFrame, fs)),featvector);
    windowStart = windowStart+hopSize;
    windowEnd = windowEnd+hopSize;
end
pitch_track=myPitchTrack_ACF(x,windowSize,hopSize,fs);
pitch_track=pitch_track(1:length(featvector));


count=1;
jitter=zeros(1,length(featvector));
while count<length(featvector)
    if count==1
    jitter(count)=0;
    else
    jitter(count)=(pitch_track(count)-pitch_track(count-1))/pitch_track(count);
        if isnan(jitter(count))==1
            jitter(count)=0;
        elseif pitch_track(count)==0;
            jitter(count)=0;
        end         
    end
    count=count+1;
end
jitter =(jitter-min(jitter))/range(jitter);
jitter=abs(jitter)';

newfeatvector=[featvector jitter]';



