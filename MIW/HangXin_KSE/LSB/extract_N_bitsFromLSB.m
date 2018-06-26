function bitStream = extract_N_bitsFromLSB( dataInDec_WithInsertedBits, N, givenLengthOfTextBits)
%EXTRACT_N_BITSFROMLSB
% 0 < N <= 8
ON = 1;
OFF = 0;
stopFlag = OFF;

residueBitsLength = mod (givenLengthOfTextBits, N);
givenLengthOfTextBits = givenLengthOfTextBits-residueBitsLength; % deal with the residueBits later

bitStream = '';
    rowSize = size(dataInDec_WithInsertedBits, 1);
    colSize = size(dataInDec_WithInsertedBits, 2);
   
    for i = 1:rowSize
        for j = 1:colSize
            bits = dec2bin(dataInDec_WithInsertedBits(i,j));
           
            while(length(bits) < 8)     % keep appending '0' to reach 8-bit length
                bits = strcat('0', bits);
            end          

            bitStream = strcat(bitStream, bits((end-N+1):end));
           
            if (length(bitStream) >= givenLengthOfTextBits)
                stopFlag = ON;

        if (residueBitsLength > 0)         % collect the residual bits
            if ((j+1)<= colSize)
                        bits = dec2bin(dataInDec_WithInsertedBits(i,j+1));
            else
                        bits = dec2bin(dataInDec_WithInsertedBits(i+1,1));
            end
           
                    while(length(bits) < 8)     % keep appending '0' to reach 8-bit length
                        bits = strcat('0', bits);
                    end          

                    bitStream = strcat(bitStream, bits((end-residueBitsLength+1):end));
        end
                break
            end
        end
            if (stopFlag == ON)
                break;
            end       
    end

end


%{
N = 3;
dataInDec_WithInsertedBits = [2 3];
bitStream = extract_N_bitsFromLSB( dataInDec_WithInsertedBits, N )

% ans: 010011
%} 