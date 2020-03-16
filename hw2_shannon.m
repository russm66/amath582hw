% Matt Russell
% AMATH 582 hw2.m
% Gabor filter with a Shannon (step) window

clear all; close all; clc;
%% Load handel and define constants
load handel
v = y'/2;
nL = 2^(floor(log2(length(v)))); % want power of 2 number of fourier modes
v = v(1:nL);
L = length(v)/Fs; % length of signal
t2 = linspace(0,L,nL+1); t = t2(1:nL);
k = (2*pi/L)*[0:nL/2-1 -nL/2:-1]; ks=fftshift(k);
tslide = 0:0.1:L;

%% Produce a spectrogram with a Shannon (step) Filter
% Width = 1

vsf_spec = [];
a = 1;
b = 2;

% Convolve and create spectrogram matrix
for j=1:length(tslide)
    s = heaviside(t - a - tslide(j)).^heaviside(tslide(j) + b - t);
    vs = s.*v;
    vsf = fft(vs);
    
    vsf_spec = [vsf_spec; abs(fftshift(vsf))];
end

figure(1);
pcolor(vsf_spec.'), shading interp

% Width = .1

% Width = .01
