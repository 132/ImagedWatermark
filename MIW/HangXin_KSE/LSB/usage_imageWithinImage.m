close all;
clear all;
clc;

% Usage:
targetImageFile = 'Glaucus_atlanticus.jpg';
targetImage = imread(targetImageFile);
targetImageInGray = rgb2gray(targetImage);

N = 3;
dataInDec = targetImageInGray;
dataInDecMasked = maskLast_N_bits(dataInDec, N );

section_getImageBitStream;

givenLengthOfTextBits = bitStreamLength;
dataInDec_WithInsertedBits = insertIntoLSB_bits(dataInDecMasked, bitStreamOfImageToHide, N );

bitStream = extract_N_bitsFromLSB( dataInDec_WithInsertedBits, N, givenLengthOfTextBits );
bitStream = bitStream(1:givenLengthOfTextBits);

%intArray = bitStreamToIntArray( bitStreamOfImageToHide );
intArray = bitStreamToIntArray( bitStream );

% recover hidden image
targetImageInGray_Reconstructed = reshape(intArray, newRowSize, newColSize);

section_plotForGrayScale_ImageWithinImage;

numberOfBitsAvailableForInsertingBits = prod(size(targetImageInGray))*N;
numberOf_bytesHidden = newRowSize * newColSize;
fprintf('Number of Bytes Hidden: %d\n', numberOf_bytesHidden);

fprintf('Number of Bits Hidden: %d\n', givenLengthOfTextBits);
fprintf('Number of Bits Space Available for Hiding: %d\n', numberOfBitsAvailableForInsertingBits);
fprintf('Utility: %5.5f %%\n', (givenLengthOfTextBits/numberOfBitsAvailableForInsertingBits)*100);

