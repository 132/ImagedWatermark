clc
close all
clear all

originalImage = rgb2gray(imread('lena.tiff'));
% originalImage = rgb2gray(imread('jet.tiff'));
% originalImage = rgb2gray(imread('baboon512.tif'));
% originalImage = rgb2gray(imread('peppers.tiff'));
% originalImage = rgb2gray(imread('sailboat.tiff'));
% originalImage = imread('boat.tiff');
% originalImage = rgb2gray(imread('Tiffany.tiff'));
% originalImage=imresize(imread('Man.tiff'), [512 512]);
% originalImage=imread('Man.tiff');
% originalImage=imread('sand.tiff');
% originalImage=imread('Grass (D9).tiff');
% originalImage = imread('barbara.pgm');



bpp=0.1:0.1:0.9;

figure(1)
imshow(originalImage)
figure(2)
hist(originalImage(:),0:255) 

tic
TpTnpsnr = xiaolong2013(originalImage,'xiaolong',bpp);
toc


figure(3)
plot(TpTnpsnr(:,1),TpTnpsnr(:,2),'ko-','MarkerSize',6,'MarkerFaceColor','k');hold on;grid on
xlabel('Embedding Rate (BPP)','FontSize',12,'fontweight','b')
ylabel('PSNR(dB)','FontSize',12,'fontweight','b')

figure(4)
plot(TpTnpsnr(:,1),TpTnpsnr(:,3),'ko-','MarkerSize',6,'MarkerFaceColor','k');hold on;grid on
xlabel('Embedding Rate (BPP)','FontSize',12,'fontweight','b')
ylabel('Location map (bits)','FontSize',12,'fontweight','b')




