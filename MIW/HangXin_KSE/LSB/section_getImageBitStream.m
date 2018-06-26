targetImageFile = 'imageLowRes.jpg';
targetImageToBeHidden = imread(targetImageFile);
targetImageToBeHiddenInGray = rgb2gray(targetImageToBeHidden);

% imshow(targetImageInGray);
rowSize = size(targetImageToBeHiddenInGray, 1);
colSize = size(targetImageToBeHiddenInGray, 2);
% for demo, we use a small size image, converting to but stream may take
% around 100 secs
newRowSize = round(rowSize/2);
newColSize = round(colSize/2);
targetImageToBeHiddenInGray = imresize(targetImageToBeHiddenInGray, [newRowSize, newColSize]);
% tic
bitStreamOfImageToHide = convertInt8ToBitStream( targetImageToBeHiddenInGray(:) );
bitStreamLength = length(bitStreamOfImageToHide);

% intArray = bitStreamToIntArray( bitStreamOfImageToHide );
% 
% targetImageInGray_Reconstructed = reshape(intArray, newRowSize, newColSize);
% imshow(targetImageInGray_Reconstructed, []);
% toc