clc
close all
clear all
originalImage1 = imread('barbara.pgm');
originalImage1 = rgb2gray(imread('lena.tiff'));
% originalImage1 = rgb2gray(imread('jet.tiff'));
% originalImage1 = rgb2gray(imread('baboon512.tif'));
% originalImage1 = rgb2gray(imread('peppers.tiff'));
% originalImage1 = rgb2gray(imread('sailboat.tiff'));
% originalImage1 = imread('boat.tiff');
% originalImage1 = rgb2gray(imread('Tiffany.tiff'));
% originalImage1 = imread('Man.tiff');
% originalImage1 = imread('man.tif');
% originalImage1=imresize(imread('Man.tiff'), [512 512]);
% originalImage1 = imread('elaine.512.tiff');
% originalImage1 = rgb2gray(imread('kodim15.png'));
% originalImage1 = rgb2gray(imread('kodim09.png'));

data1 = imread('doraemon.tiff');


figure(1)
imshow(originalImage1)

figure(2)
imshow(data1)


embeded_image = sachnev_encoding(double(originalImage1),data1(:));

figure(3)
imshow(embeded_image)


[originalImage2  data2] = sachnev_decoding(embeded_image);
figure(4)
imshow(originalImage2)

figure(5)
imshow(data2)

















