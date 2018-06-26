            figureTitle = ['Description ', ...
                            'Images for GrayScale LSB Steganography']; 

            figure('Name', figureTitle,'NumberTitle','off'),

numberOfRowPlot = 1;
numberOfColPlot = 4;
plotIndex = 0;

plotIndex = plotIndex + 1;
subplot(numberOfRowPlot, numberOfColPlot, plotIndex);
imshow(targetImageInGray);
title('Original Image (target)');
hold on;

plotIndex = plotIndex + 1;
subplot(numberOfRowPlot, numberOfColPlot, plotIndex);
imshow(dataInDecMasked);
title(['Image with ' num2str(N) '-bit LSB masked']);

plotIndex = plotIndex + 1;
subplot(numberOfRowPlot, numberOfColPlot, plotIndex);
imshow(dataInDec_WithInsertedBits);
title('Image with hidden image');

plotIndex = plotIndex + 1;
subplot(numberOfRowPlot, numberOfColPlot, plotIndex);
imshow(targetImageInGray_Reconstructed, []);
title('Hidden Image');