function dataInDecMasked = maskLast_N_bits(dataInDec, N )
%MASKLAST_N_BITS 
% 0 < N <= 8
bit8Mask = bin2dec('11111111');
bit8Mask_shifted = bitshift(bit8Mask, N); % left shift
bit8Mask = bitand(bit8Mask_shifted, bit8Mask);
dataInDecMasked = bitand(dataInDec, bit8Mask);

end
