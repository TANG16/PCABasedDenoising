%% MyMainScript
clear ; close all; clc
tic;
%% Create noisy image

im = im2double(imread('../data/barbara256-part.png'));
im1 = im + randn(size(im))*20/255;   % Add Gaussian noise of standard deviation 20

%% Part a
sigma = 20/255;
im2 = myPCADenoising1(im1,sigma);


figure(1);
imshow(im1);

figure(2);
imshow(im2);
%% Part b
im3 = myPCADenoising2(im1,sigma);
figure(3);
imshow(im3);
toc;
