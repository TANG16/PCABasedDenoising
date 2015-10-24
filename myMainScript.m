%% MyMainScript
clear ; close all; clc
tic;
%% Create noisy image

im = imread('../data/barbara256.png');
im1 = im + randn(size(im))*20;   % Add Gaussian noise of standard deviation 20

%% Part a
sigma = 20;
im2 = myPCADenoising1(im1,sigma);

%% Part b
im3 = myPCADenoising2(im1,sigma);

toc;
