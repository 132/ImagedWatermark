clc
close all
clear all
% originalImage = imread('barbara.pgm');
% originalImage = rgb2gray(imread('lena.tiff'));
% originalImage = rgb2gray(imread('jet.tiff'));
% originalImage = rgb2gray(imread('baboon512.tif'));
% originalImage = rgb2gray(imread('peppers.tiff'));
% originalImage = rgb2gray(imread('sailboat.tiff'));
% originalImage = imread('boat.tiff');
% originalImage = rgb2gray(imread('Tiffany.tiff'));
originalImage = imread('Man.tiff');
% originalImage = imread('man.tif');
% originalImage=imresize(imread('Man.tiff'), [512 512]);
% originalImage = imread('elaine.512.tiff');
% originalImage = rgb2gray(imread('kodim15.png'));
% originalImage = rgb2gray(imread('kodim09.png'));

bpp=0.05:0.05:0.95;

figure(1)
imshow(originalImage)% show anh goc


figure(2)
hist(originalImage(:),0:255) % show histogram


TpTnpsnr = sachnev(double(originalImage),bpp); % function chinh


figure(3) % PSNR va BPP
plot(TpTnpsnr(:,1),TpTnpsnr(:,2),'ko-','MarkerSize',4.5,'MarkerFaceColor','k');hold on;grid on
xlabel('Embedding Rate (BPP)','FontSize',11)
ylabel('PSNR(dB)','FontSize',11)

figure(4) % BPP va location map
plot(TpTnpsnr(:,1),TpTnpsnr(:,5),'ko-','MarkerSize',4.5,'MarkerFaceColor','k');hold on;grid on
xlabel('Embedding Rate (BPP)','FontSize',11)
ylabel('Location map (bits)','FontSize',11)










