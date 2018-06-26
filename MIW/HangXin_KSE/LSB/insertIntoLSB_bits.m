function dataInDec_WithInsertedBits = insertIntoLSB_bits(dataTarget_inDec, dataToBeInsertedInBits, N )
%INSERTINTOLSB_BITS 
% dataToBeInsertedAsBits_inDec assumed to be text string
% 0 < N <= 8
% dataTarget_inDec assumed masked of N bits in LSB

% use dataToBeInsertedInBits
numberOfBitsToBeInserted = length(dataToBeInsertedInBits);
totalSizeOfdataTargetBits = prod(size(dataTarget_inDec))*8;
totalSizeOfdataTargetBitSpaceInsertable = prod(size(dataTarget_inDec))*N;

if(numberOfBitsToBeInserted > totalSizeOfdataTargetBitSpaceInsertable)
    fprintf('numberOfBitsOfBitsToBeInserted exceeds totalSizeOfdataTargetBitSpaceInsertable\n');
else
    bitStream = dataToBeInsertedInBits;
    % eg. 1111, N = 3 => 0000 0111; 0000 0001
    byteArraysWithInfoBits = allocateDataBitsByN_SizeBitsIntoByteArrays(bitStream, N);
    numberOf_byteArraysWithInfoBits = length(byteArraysWithInfoBits);
    
    rowSize = size(dataTarget_inDec, 1);
    colSize = size(dataTarget_inDec, 2);
    rowIndex = 1;
    colIndex = 1;
    
    dataInDec_WithInsertedBits = dataTarget_inDec;
    
    for i=1:numberOf_byteArraysWithInfoBits
        if(colIndex > colSize)
           colIndex = 1;
           rowIndex = rowIndex + 1;            
        end
        dataInDec_WithInsertedBits(rowIndex, colIndex) = bitor(dataInDec_WithInsertedBits(rowIndex, colIndex), byteArraysWithInfoBits(i)); 
        colIndex = colIndex + 1;
    end
end

end
