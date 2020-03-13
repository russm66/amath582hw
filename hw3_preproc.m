% Matt Russell
% AMATH 582 hw3
% dataset preprocessing script

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
alpha = [240 250 225];

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
    g12(:,:,k) = rgb2gray(vidFrames1_2(:,:,:,k));
    g13(:,:,k) = rgb2gray(vidFrames1_3(:,:,:,k));
    g14(:,:,k) = rgb2gray(vidFrames1_4(:,:,:,k));
    g21(:,:,k) = rgb2gray(vidFrames2_1(:,:,:,k));
    g22(:,:,k) = rgb2gray(vidFrames2_2(:,:,:,k));
    g23(:,:,k) = rgb2gray(vidFrames2_3(:,:,:,k));
    g24(:,:,k) = rgb2gray(vidFrames2_4(:,:,:,k));
    g31(:,:,k) = rgb2gray(vidFrames3_1(:,:,:,k));
    g32(:,:,k) = rgb2gray(vidFrames3_2(:,:,:,k));
    g33(:,:,k) = rgb2gray(vidFrames3_3(:,:,:,k));
    g34(:,:,k) = rgb2gray(vidFrames3_4(:,:,:,k));
    
% pixel intensity decision threshold 
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

clear s11 s12 s13 s14 s21 s22 s23 s24 s31 s32 s33 s34

% Spatial decision threshold
for k=1:numFrames
    for j=1:sy
        for i=1:sx
            if(j < 200)
                g11(j,i,k) = 0;
                g13(j,i,k) = 0;
            end
            if(i < 200)
                g31(j,i,k) = 0;
            end
            if(i < 250)
                g32(j,i,k) = 0;
                g33(j,i,k) = 0;
                g34(j,i,k) = 0;
            end
            if(i < 300)
                g12(j,i,k) = 0;
            end
            if(i < 300 && j < 200)
                g14(j,i,k) = 0;
            end
        end
    end 
end

%% Create measurement matrices X1 - X4, [ya;xa;yb;xb;yc;xc]
X1 = zeros(6,numFrames); 
X2 = X1;
X3 = X1; 
X4 = X1;


% index = zeros(12,numFrames);

% track the point and store the (y,x) [row col] in Xm
for k=1:numFrames    
    % Case 1
    [~, index] = max(g11(:,:,k),[],'all','linear');
    [X1(1,k), X1(2,k)] = ind2sub([sy sx],index);
    [~, index] = max(g21(:,:,k),[],'all','linear');
    [X1(3,k), X1(4,k)] = ind2sub([sy sx],index);
    [~, index] = max(g31(:,:,k),[],'all','linear');
    [X1(5,k), X1(6,k)] = ind2sub([sy sx],index);
    
    % Case 2
    [~, index] = max(g12(:,:,k),[],'all','linear');
    [X2(1,k), X2(2,k)] = ind2sub([sy sx],index);
    [~, index] = max(g22(:,:,k),[],'all','linear');
    [X2(3,k), X2(4,k)] = ind2sub([sy sx],index);
    [~, index] = max(g32(:,:,k),[],'all','linear');
    [X2(5,k), X2(6,k)] = ind2sub([sy sx],index);
    
    % Case 3
    [~, index] = max(g13(:,:,k),[],'all','linear');
    [X3(1,k), X3(2,k)] = ind2sub([sy sx],index);
    [~, index] = max(g23(:,:,k),[],'all','linear');
    [X3(3,k), X3(4,k)] = ind2sub([sy sx],index);
    [~, index] = max(g33(:,:,k),[],'all','linear');
    [X3(5,k), X3(6,k)] = ind2sub([sy sx],index);
    
    % Case 4
    [~, index] = max(g14(:,:,k),[],'all','linear');
    [X4(1,k), X4(2,k)] = ind2sub([sy sx],index);
    [~, index] = max(g24(:,:,k),[],'all','linear');
    [X4(3,k), X1(4,k)] = ind2sub([sy sx],index);
    [~, index] = max(g34(:,:,k),[],'all','linear');
    [X4(5,k), X4(6,k)] = ind2sub([sy sx],index);
end