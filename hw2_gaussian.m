% Matt Russell
% AMATH 582 hw2.m
% Gabor filter with a Gaussian window and produce spectrograms
% Explore how changing the variance of the gaussian changes the spectrogram
% g(x) = exp(-(1/2sigma^2)*x^2) 
% Trying to produce 4 spectrograms in the same script while streaming nba
% fried the wifi adapter of my ubuntu-running macbook air so I split the
% different parts of the assignment into their own scripts

clear all; close all; clc;
%% Load handel and define constants
load handel
v = y'/2;
nL = 2^(floor(log2(length(v)))); % want power of 2 number of fourier modes
v = v(1:nL);
L = length(v)/Fs; % length of signal
t2 = linspace(0,L,nL+1); t = t2(1:nL);
k = (2*pi/L)*[0:nL/2-1 -nL/2:-1]; ks=fftshift(k);

%% Produce a spectrogram using a gaussian filter
vgf_spec = [];
tslide = 0:0.1:L;

% sigma = 1
sigma = 1;
% Convolve and create spectrogram matrix 
for j=1:length(tslide)
    g1 = (1/(sqrt(2*pi)*sigma))*exp((1/(2*sigma^2))*(t-tslide(j)).^2);
    vg1 = g1.*v;
    vgf1 = fft(vg1);

    vgf_spec = [vgf_spec; abs(fftshift(vgf1))];

%     figure(2);
%     subplot(3,1,1), plot(t,v,'k',t,g,'r')
%     subplot(3,1,2), plot(t,vg,'k')
%     axis([0 L -0.5 0.5])
%     subplot(3,1,3), plot(ks,abs(fftshift(vgf))/max(abs(vgf)),'k');
%     axis([-25000 25000 0 1])
%     drawnow
end
%     pause(0.05)

figure(2);
pcolor(vgf_spec.'), shading interp
title('handel spectrogram, Gaussian window, nominal sampling');

% sigma = 0.1

% sigma = 2