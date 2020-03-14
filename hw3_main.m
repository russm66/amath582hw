% Matt Russell
% 3/16/20
% amath582 hw3_main.m
% main script

%% Preprocessing script to clean data
% preproc('cam1_1.mat',...,'camN_K.mat')
%             -----------      -------------      ------------
% raw data ->| GREYSCALE | -> |INTENSITY DT | -> | SPATIAL DT |- -
%             -----------      -------------      ------------   |
%            |----------------------------------------------------| 
%            |   -------------------------
%            |->| "POINT-TRACKER" ( max())| -> {X1,X2,X3,X4}
%                -------------------------

% run('hw3_preproc.m');

%% Script to perform svd

% run('hw3_svd.m');

%% Plotting
% numFrames is interval of observation so "1" = one period of observation!
t = linspace(0,1,numFrames);

% length is numFrames in order to fit the modes, aspect ratio of data (4:3) 
% is maintained with the length of x and y
x = linspace(0,4,numFrames);
y = linspace(0,3,numFrames);

% overdetermined (tall,skinny) so uK(:,k) give the spatial data for the
% different modes

% dominant spatial mode for each case 
figure(1);
plot3(x,y,u1(:,1),x,y,u2(:,1),x,y,u3(:,1),x,y,u4(:,1))