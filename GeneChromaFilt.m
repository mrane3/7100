function [H] = GeneChromaFilt (iFftLength, f_s)

    % initialization at C4
    f_mid           = 261.63;
    iNumOctaves     = 4;
    
    %sanity check
    while (f_mid*2^iNumOctaves > f_s/2 )
        iNumOctaves = iNumOctaves - 1;
    end
    
    H               = zeros (12, iFftLength);
    
    for (i = 1:12)
        afBounds  = [2^(-1/24) 2^(1/24)] * f_mid * 2* iFftLength/f_s;
        for (j = 1:iNumOctaves)
           iBounds                      = [ceil(2^(j-1)*afBounds(1)) floor(2^(j-1)*afBounds(2))];
           H(i,iBounds(1):iBounds(2))   = 1/(iBounds(2)+1-iBounds(1));
        end
        % increment to next semi-tone
        f_mid   = f_mid*2^(1/12);
    end   
