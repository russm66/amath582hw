% Matt Russell
% AMATH 582 hw3_1.m
% test 1 Ideal case

clear all; close all; clc;

%% Load camera RGB values
load('cam1_1.mat');
load('cam2_1.mat');
load('cam3_1.mat');
load('cam1_2.mat');
load('cam2_2.mat');
load('cam3_2.mat');
load('cam1_3.mat');
load('cam2_3.mat');
load('cam3_3.mat');
load('cam1_4.mat');
load('cam2_4.mat');
load('cam3_4.mat');
%% Create grayscale matrices for PCA
s11 = size(vidFrames1_1); % [y x RGB numframes]
s21 = size(vidFrames2_1);
s31 = size(vidFrames3_1);

s12 = size(vidFrames1_2);
s22 = size(vidFrames2_2);
s32 = size(vidFrames3_2);

s13 = size(vidFrames1_3);
s23 = size(vidFrames2_3);
s33 = size(vidFrames3_3);

s14 = size(vidFrames1_4);
s24 = size(vidFrames2_4);
s34 = size(vidFrames3_4);

numFrames = min([s11(4) s12(4) s13(4) s14(4) s21(4) s22(4) s23(4) s24(4)...
    s31(4) s32(4) s33(4) s34(4)]);

% dimensions are the same for all datasets
sy = s11(1); 
sx = s11(2);

% Declare greyscale matrices and decision threshold on intensity
alpha = [240 250 225]; % decision thresholds all turned out to be the same
g11 = zeros(s11(1),s11(2),numFrames); % GS inside so use 3rd dim for frames
g12 = zeros(s12(1),s12(2),numFrames);
g13 = zeros(s13(1),s13(2),numFrames);
g14 = zeros(s14(1),s14(2),numFrames);

g21 = zeros(s21(1),s21(2),numFrames);
g22 = zeros(s22(1),s22(2),numFrames);
g23 = zeros(s23(1),s23(2),numFrames);
g24 = zeros(s24(1),s24(2),numFrames);

g31 = zeros(s31(1),s31(2),numFrames);
g32 = zeros(s32(1),s32(2),numFrames);
g33 = zeros(s33(1),s33(2),numFrames);
g34 = zeros(s34(1),s34(2),numFrames);

% rgb2gray spits out doubles
for k=1:numFrames
    g11(:,:,k) = rgb2gray(vidFrames1_1(:,:,:,k));
    g21(:,:,k) = rgb2gray(vidFrames2_1(:,:,:,k));
    g31(:,:,k) = rgb2gray(vidFrames3_1(:,:,:,k));
    % decision threshold to clean up data
    for j=1:sy
        for i=1:sx
            if(g11(j,i,k) < alpha(1))
                g11(j,i,k) = 0;
            end
            if(g12(j,i,k) < alpha(1))
                g12(j,i,k) = 0;
            end
            if(g13(j,i,k) < alpha(1))
                g13(j,i,k) = 0;
            end
            if(g14(j,i,k) < alpha(1))
                g14(j,i,k) = 0;
            end
            if(g21(j,i,k) < alpha(2))
                g21(j,i,k) = 0;
            end
            if(g22(j,i,k) < alpha(2))
                g22(j,i,k) = 0;
            end
            if(g23(j,i,k) < alpha(2))
                g23(j,i,k) = 0;
            end
            if(g24(j,i,k) < alpha(2))
                g24(j,i,k) = 0;
            end
            if(g31(j,i,k) < alpha(3))
                g31(j,i,k) = 0;
            end
            if(g32(j,i,k) < alpha(3))
                g32(j,i,k) = 0;
            end
            if(g33(j,i,k) < alpha(3))
                g33(j,i,k) = 0;
            end
            if(g34(j,i,k) < alpha(3))
                g34(j,i,k) = 0;
            end
        end
    end
end
% don't need these anymore
clear vidFrames1_1 vidFrames1_2 vidFrames1_3 vidFrames1_4 ...
vidFrames2_1 vidFrames2_2 vidFrames2_3 vidFrames2_4 ... 
vidFrames3_1 vidFrames3_2 vidFrames3_3 vidFrames3_4 ...
vidFrames4_1 vidFrames4_2 vidFrames4_3 vidFrames4_4

% Create measurement matrix X