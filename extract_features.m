function [featvector] = extract_features(x, fs)
 %UNTITLED2 Summary of this function goes here
  %   Detailed explanation goes here 
  
x = x(:);
H = hamming(length(x));
x = x.*H;

% Pre-emphasis Filter {H(z) = 1 – 0.98z-1}
x = filter([1, -0.98], 1, x);

len = length(x);
X = abs(fft(x));


% Spectral Centroid
f = [1:length(X)]';
spectral_centroid = sum((X.^2).*f) / sum(X.^2) ;
if sum(X.^2)==0
    spectral_centroid=0;
end

 
%Max Envelope
 max_env= max(x);
 
%rms
rms_env= rms(x);
 
%Cepstral formants
cepstrum=ifft(log(X));
[pks locs]=findpeaks(abs(fft(cepstrum(1:10),8000)));
formant= locs(1);

%MFCCS
Mfcc=FeatureSpectralMfccs(X,fs)';




% Feature Vector
featvector=[spectral_centroid,formant,max_env,rms_env,Mfcc] ;






