function intArray = bitStreamToIntArray( bitStream )
%BITSTREAMTOINTARRAY 
% assume byte stream
bitSize = 8;
numberOfBytes = floor(length(bitStream)/bitSize);

for i = 1:numberOfBytes
    startBit = (bitSize*(i-1))+1;
    endBit = (bitSize*(i-1))+bitSize;
    intArray(i) = bin2dec(bitStream(startBit:endBit));
end

end
