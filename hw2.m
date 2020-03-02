% Matt Russell
% AMATH 582 hw2.m

clear all; close all; clc;
%% Part 1
load handel
v = y'/2;
n = 2^(floor(log2(length(v)))); % behave well with FFT
v = v(1:n);
L = length(v)/Fs; % length of signal
t2 = linspace(0,L,n+1); t = t2(1:n);
k = (2*pi/L)*[0:n/2-1 -n/2:-1]; ks=fftshift(k);

% Plot FFT

vf = fft(v);

figure(1);
plot(ks,abs(fftshift(vf))/max(abs(vf)));
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('abs(fftshift(fft(v))) = "handel" in frequency');

%% Produce a spectrogram using a gaussian filter
vgf_spec = [];
tslide = 0:0.1:L;

for j=1:length(tslide)
    g = exp(-(t-tslide(j)).^2);
    vg = g.*v;
    vgf = fft(vg);

    vgf_spec = [vgf_spec; abs(fftshift(vgf))];

%     figure(2);
%     subplot(3,1,1), plot(t,v,'k',t,g,'r')
%     subplot(3,1,2), plot(t,vg,'k')
%     axis([0 L -0.5 0.5])
%     subplot(3,1,3), plot(ks,abs(fftshift(vgf))/max(abs(vgf)),'k');
%     axis([-25000 25000 0 1])
%     drawnow
%     pause(0.05)
end

figure(3);
pcolor(vgf_spec.'), shading interp

%% Produce a spectrogram with a Shannon Filter
vsf_spec = [];
a = 1;
b = 2;

for j=1:length(tslide)
    s = heaviside(t - a - tslide(j)).^heaviside(tslide(j) + b - t);
    vs = s.*v;
    vsf = fft(vs);
    
    vsf_spec = [vsf_spec; abs(fftshift(vsf))];
end

figure(4);
pcolor(vsf_spec.'), shading interp