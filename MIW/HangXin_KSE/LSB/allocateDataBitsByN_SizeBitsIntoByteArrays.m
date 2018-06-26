function byteArraysWithInfoBits = allocateDataBitsByN_SizeBitsIntoByteArrays( bitStream, N )
%ALLOCATEDATABITSBYN_SIZEBITSINTOBYTEARRAYS     % eg. 1111, N = 3 => 0000 0111; 0000 0001
numberOfBits = length(bitStream);
numberOfBytesRequired = floor(numberOfBits/N);  % not considering residual bits (if there is)
numberOfResidualBits = mod(numberOfBits, N); % if there is, add 1 more byte later into the array

for i=1:numberOfBytesRequired
    bits = (bitStream((N*(i-1))+1:(N*(i-1))+N));
    while(length(bits) < 8)     % keep appending '0' to reach 8-bit length
        bits = strcat('0', bits); 
    end
    bitsInByte(i) = bin2dec(bits);
end

if (numberOfResidualBits > 0)
    bits = bitStream((end-numberOfResidualBits+1):end);
    while(length(bits) < 8)     % keep appending '0' to reach 8-bit length
        bits = strcat('0', bits);
    end
    
    bitsInByte(numberOfBytesRequired+1) = bin2dec(bits);
end

byteArraysWithInfoBits = bitsInByte;    % in dec

end

%{
bitStream = '1111';
N = 3;
byteArraysWithInfoBits = allocateDataBitsByN_SizeBitsIntoByteArrays( bitStream, N )
%}