% Matt Russell
% amath 582 hw2
% Script to look at all the different waveforms so my workflow is expedited


clear all; close all; clc;
%% Load handel and define constants
load handel
v = y'/2;
nL = 2^(floor(log2(length(v)))); % original length not behave well with FFT
v = v(1:nL);
L = length(v)/Fs; % length of signal
t2 = linspace(0,L,nL+1); t = t2(1:nL);
k = (2*pi/L)*[0:nL/2-1 -nL/2:-1]; ks=fftshift(k);
dt = 0.1; % nominal sampling
tslide = 0:dt:L;
%% Plot FFT
vf = fft(v);

figure(1);
plot(ks,abs(fftshift(vf))/max(abs(vf)));
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('abs(fftshift(fft(v))) = "handel" in frequency');

%% Plot Gaussian windows (and movies)
% sigma = 1
sigma = 1; 
for j = 1:length(tslide)
    g1 = (1/(sqrt(2*pi)*sigma))*exp(-(1/(2*sigma^2))*(t-tslide(j)).^2);
    vg1 = g1.*v;
    vgf1 = fft(vg1);
    
    figure(2);
    subplot(3,1,1), plot(t,v/max(v),'k',t,g1/max(g1),'r')
    title('handel and sliding gaussian, sigma = 1');
    subplot(3,1,2), plot(t,vg1/max(vg1),'k')
    title('windowed handel');
    axis([0 L -1 1])
    subplot(3,1,3), plot(ks,abs(fftshift(vgf1))/max(abs(vgf1)),'k');
    title('windowed spectrum');
    axis([-25000 25000 0 1])
    drawnow
    pause(0.01)
end
% sigma = 0.1
sigma = 0.1; 
for j = 1:length(tslide)
    g2 = (1/(sqrt(2*pi)*sigma))*exp(-(1/(2*sigma^2))*(t-tslide(j)).^2);
    vg2 = g2.*v;
    vgf2 = fft(vg2);
    
    figure(3);
    subplot(3,1,1), plot(t,v/max(v),'k',t,g2/max(g2),'r')
    title('handel and sliding gaussian, sigma = 0.1');
    subplot(3,1,2), plot(t,vg2/max(vg2),'k')
    title('windowed handel');
    axis([0 L -1 1])
    subplot(3,1,3), plot(ks,abs(fftshift(vgf2))/max(abs(vgf2)),'k');
    title('windowed spectrum')
    axis([-25000 25000 0 1])
    drawnow
    pause(0.01)
end
% sigma = 2
sigma = 2; 
for j = 1:length(tslide)
    g3 = (1/(sqrt(2*pi)*sigma))*exp(-(1/(2*sigma^2))*(t-tslide(j)).^2);
    vg3 = g3.*v;
    vgf3 = fft(vg3);
    
    figure(4);
    subplot(3,1,1), plot(t,v/max(v),'k',t,g3/max(g3),'r')
    title('handel and sliding gaussian, sigma = 2');
    subplot(3,1,2), plot(t,vg3/max(vg3),'k')
    title('windowed handel');
    axis([0 L -1 1])
    subplot(3,1,3), plot(ks,abs(fftshift(vgf3))/max(abs(vgf3)),'k');
    title('windowed spectrum');
    axis([-25000 25000 0 1])
    drawnow
    pause(0.01)
end