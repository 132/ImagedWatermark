function bitStream = convertInt8ToBitStream( dataToBeInsertedAsBits_inDec )
%CONVERTINT8TOBITSTREAM 
numberOfTextChar = length(dataToBeInsertedAsBits_inDec);

    bitStream = '';
    for i = 1:numberOfTextChar
        bits = dec2bin(dataToBeInsertedAsBits_inDec(i));
            while(length(bits) < 8)     % keep appending '0' to reach 8-bit length
                bits = strcat('0', bits); 
            end          
        bitStream = strcat(bitStream, bits);
    end

end
