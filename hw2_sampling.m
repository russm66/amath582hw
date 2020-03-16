% Matt Russell
% AMATH 582 hw2
% Explore over- and undersampling on gaussian and shannon filters
% Sampling is controlled by 'dt' parameter

clear all; close all; clc;
%% Load handel and define constants
load handel
v = y'/2;
nL = 2^(floor(log2(length(v)))); % original length not behave well with FFT
v = v(1:nL);
L = length(v)/Fs; % length of signal
t2 = linspace(0,L,nL+1); t = t2(1:nL);
k = (2*pi/L)*[0:nL/2-1 -nL/2:-1]; ks=fftshift(k);

% nominal sampling := dt = 0.1
dt = 0.1;

tslide = 0:dt:L;

% oversampling, dt = 0.01

% undersampling, dt = 1