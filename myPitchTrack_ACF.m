%% Blockwise Pitch Tracking based on ACF
% [f0, timeInSec] = myPitchTrack_ACF(x, windowSize, hopSize, fs)
% Input:
%   x = N*1 float vector, input signal
%   windowSize = int, window size of the blockwise process
%   hopSize = int, hop size of the blockwise process
%   fs = float, sample rate in Hz
% Output:
%   f0 = numBlocks*1 float vector, detected pitch (Hz) per block
%   timeInSec  = numBlocks*1 float vector, time stamp (sec) of each block
% CW @ GTCMT 2015

function [f0,A, timeInSec] = myPitchTrack_ACF(x, windowSize, hopSize, fs)

x = x(:) ;
    
windowStart = 1 ;
windowEnd = windowSize ;

numSamples = length(x) ;
f0 = [] ;
timeInSec = [] ;

x = [x; zeros(windowSize,1)] ;
while(windowEnd < numSamples)
    
    A = zeros(1,windowSize);
    for j = 1 : windowSize
        A(j) = x(windowStart:windowEnd-j+1)' * x(windowStart+j-1:windowEnd) ;
    end
    A = A / windowSize ;
    [pks, locs] = findpeaks(A) ;  % , 'MINPEAKHEIGHT', 0.7*A(1)) ;
    [pks, ind] = sort(pks(1:2), 'descend') ;
    
    %
   
    if (numel(pks) == 0)|(A(1)< 0.0025)
        f0 = [f0, 0] ;
    else
        period = locs(ind(1)) - 1 ;
        
        if fs/period>100 && fs/period<1000
           f0 = [f0, fs/period] ;
        else
            f0= [f0,0];
        end
    end
    
timeInSec = [timeInSec, (windowStart-1) / fs] ;
windowStart = windowStart + hopSize ;
windowEnd = windowEnd + hopSize ;

end
f0=medfilt1(f0);

