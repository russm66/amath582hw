% Matt Russell
% AMATH582 hw3plot1.m
% Make movies out of all the case 2 data to see how effective the
% cleaning is

clear all; close all; clc;

%% Load camera RGB values
load('cam1_2.mat');
load('cam2_2.mat');
load('cam3_2.mat');

%% Create grayscale matrices for PCA
s1 = size(vidFrames1_2); % [y x RGB numframes]
s2 = size(vidFrames2_2);
s3 = size(vidFrames3_2);
numFrames = min([s1(4) s2(4) s3(4)]);
% dimensions are the same for all datasets
sy = s1(1); 
sx = s1(2);

g1 = zeros(s1(1),s1(2),numFrames); % GS inside so use 3rd dim for frames
g2 = zeros(s2(1),s2(2),numFrames);
g3 = zeros(s3(1),s3(2),numFrames);

%% (Cleaning and then) Movie Time!
%% decision threshold
alpha = [240 250 225]; % Declare decision threshold (pixel intensity lower bound)
for k=1:numFrames
    g1(:,:,k) = rgb2gray(vidFrames1_2(:,:,:,k));
    g2(:,:,k) = rgb2gray(vidFrames2_2(:,:,:,k));
    g3(:,:,k) = rgb2gray(vidFrames3_2(:,:,:,k));
% Cull the herd

% Decision threshold
    for j=1:sy
        for i=1:sx
            if(g1(j,i,k) < alpha(1))
                g1(j,i,k) = 0;
            end
            if(g2(j,i,k) < alpha(2))
                g2(j,i,k) = 0;
            end
            if(g3(j,i,k) < alpha(3))
                g3(j,i,k) = 0;
            end
        end
    end

% Raster elimination
%     if(k < 200) 
%         for j=1:sy
%             for i=1:sx
%                 if(g1(j,i,k+1) - g1(j,i,k) == 0)
%                     g1(j,i,k+1) = 0;
%                 end
%                 if(g2(j,i,k+1) - g2(j,i,k) == 0)
%                     g2(j,i,k+1) = 0;
%                 end
%                 if(g3(j,i,k+1) - g3(j,i,k) == 0)
%                     g3(j,i,k+1) = 0;
%                 end
%             end
%         end
%     end
end

figure();
str1 = sprintf('camera1_2, decision threshold = %d',alpha(1));
str2 = sprintf('camera2_2, decision threshold = %d',alpha(2));
str3 = sprintf('camera3_2, decision threshold = %d',alpha(3));
for k=1:numFrames
    subplot(3,1,1), imagesc(uint8(g1(:,:,k))), drawnow
    title(str1);
    subplot(3,1,2), imagesc(uint8(g2(:,:,k))), drawnow
    title(str2);
    subplot(3,1,3), imagesc(uint8(g3(:,:,k))), drawnow
    title(str3);
    pause(0.05)
end


%% 1-LAPI only movie
% n = 1;
% pai1 = zeros(sy,sx,numFrames);
% pai2 = pai1;
% pai3 = pai1;
% for k=1:numFrames
%     g1(:,:,k) = rgb2gray(vidFrames1_1(:,:,:,k));
%     g2(:,:,k) = rgb2gray(vidFrames2_1(:,:,:,k));
%     g3(:,:,k) = rgb2gray(vidFrames3_1(:,:,:,k));
%     1-LAPI 
%     for j=(n+1):(sy-n) % scan x dimension first
%         for i=(n+1):(sx-n) % calculate LAPI
%             pai1(j,i,k) = (1/(2*n^2+2*n+1))*(g1(j,i-1,k) + g1(j-1,i,k) ...
%                 + g1(j,i+1,k) + g1(j,i,k) + g1(j+1,i,k));
%             pai2(j,i,k) = (1/(2*n^2+2*n+1))*(g2(j,i-1,k) + g2(j-1,i,k) ...
%                 + g2(j,i+1,k) + g2(j,i,k) + g2(j+1,i,k));
%             pai3(j,i,k) = (1/(2*n^2+2*n+1))*(g3(j,i-1,k) + g3(j-1,i,k) ...
%                 + g3(j,i+1,k) + g3(j,i,k) + g3(j+1,i,k));
%         end
%     end
% end
% figure();
% str1 = 'camera1_1, 1-LAPI only';
% str2 = 'camera2_1, 1-LAPI only';
% str3 = 'camera3_1, 1-LAPI only';
% for k=1:numFrames
%     subplot(3,1,1), imagesc(uint8(pai1(:,:,k))), drawnow
%     title(str1);
%     subplot(3,1,2), imagesc(uint8(pai2(:,:,k))), drawnow
%     title(str2);
%     subplot(3,1,3), imagesc(uint8(pai3(:,:,k))), drawnow
%     title(str3);
%     pause(0.05)
% end
