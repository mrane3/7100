function [nvt] = myWPD(x, windowSize, hopSize)
windowStart = 1 ;
windowEnd = windowSize ;

numSamples = length(x) ;
f0 = [] ;
timeInSec = [] ;

frame1 = x(windowStart:windowEnd) ;
prev2FFT = fft(frame1) ;
windowStart = windowStart + hopSize ;
windowEnd = windowEnd + hopSize ;

frame2 = x(windowStart:windowEnd) ;
prevFFT = fft(frame2) ;
windowStart = windowStart + hopSize ;
windowEnd = windowEnd + hopSize ;

index = [];
deviation = [] ;
while(windowEnd < numSamples-windowSize)
    currFrame = x(windowStart:windowEnd) ;
    currFFT = fft(currFrame) ;
    currPhase= angle(currFFT);
    currMag = abs(currFFT) ;
    prevMag = abs(prevFFT) ;
    prevPhase = angle(prevFFT) ;
    prev2Phase = angle(prev2FFT) ;
    
    
    phaseChange = prevPhase - prev2Phase ;
    phaseChange(phaseChange < 0) = phaseChange(phaseChange < 0) + 2*pi ;
    expectedPhase = mod(prevPhase + phaseChange, 2*pi) ; 
    expectedPhase = unwrap(expectedPhase);
    
    deviation = [deviation, sum(abs(currMag) .*abs(currPhase - expectedPhase))] ;
%   deviation = [deviation,  sum((currPhase - expectedPhase).^2)] ;
   % deviation = [deviation, sum((currMag - prevMag).^2)] ;
    
    index = [index, windowStart] ;
    windowStart = windowStart + hopSize ;
    windowEnd = windowEnd + hopSize ;
    prev2FFT = prevFFT ;
    prevFFT = currFFT ;
end
deviation = deviation / max(abs(deviation)) ;
nvt=abs(diff(deviation));
nvt=nvt/max(nvt);