% Matt Russell
% AMATH 582 hw2.m
% Part 1
clear all; close all; clc;

load handel
v = y'/2;
n = 2^(floor(log2(length(v)))); % behave well with FFT
v = v(1:n);
L = length(v)/Fs; % length of signal
t2 = linspace(0,L,n+1); t = t2(1:n);
k = (2*pi/L)*[0:n/2-1 -n/2:-1];


%% Plot fft
% Originally FFT does not work well with this signal because the number of 
% samples is not a power of 2: log2(length(v)) !E Z+ so what I did was take
% a slice of the signal that contains the largest number of samples that is
% still a power of 2 (2^16 = 65536)

vf = fft(v);
ks=fftshift(k);

figure(1);
subplot(2,1,1), plot(ks,abs(fftshift(vf))/max(abs(vf)));
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('abs(fftshift(fft(v))) = "handel" in frequency');

% Narrow signal to include only range of human hearing
ks2 = ks;
vf2 = fftshift(vf);
for i=1:length(ks2)
    if ks2(i) <= -2e4 %20 kHz, upper limit
        vf2(i) = 0;
    elseif ks2(i) >= -20 && ks2(i) <= 20 % 20 Hz, lower limit
        vf2(i) = 0;
    elseif ks2(i) >= 2e4 % 20 kHz, upper limit
        vf2(i) = 0;
    end
end 

subplot(2,1,2), plot(ks2,abs(vf2));
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('"handel" in human hearing');

v2 = ifft(ifftshift(vf2));

figure(2);
subplot(2,1,1), plot(t,v);
xlabel('Time [sec]');
ylabel('Amplitude');
title('handel in time');
subplot(2,1,2), plot(t,v2);
xlabel('Time [sec]');
ylabel('Amplitude');
title('human hearing handel in time');

%pv = audioplayer(v,Fs);
%playblocking(pv);
%pv2 = audioplayer(v2,Fs);
%playblocking(pv2);

% One thing I notice is that one of the instruments appears to have their
% fundamental located outside of human hearing. I think this is something
% nonphysical and due to the aforementioned limitation of the fft algorithm
% applied to our data. It was actually due to my own fault and the way I
% was handling the narrowing.

% I should note that if I was to take the first 65536 samples from handel
% then the resultant signal would be appropriately sized for the FFT. I
% believe that I shall do this

%% Produce a spectrogram using a gaussian filter
vgf_spec = [];
tslide = 0:0.1:L;

for j=1:length(tslide)
    g = exp(-(t-tslide(j)).^2);
    vg = g.*v;
    vgf = fft(vg);

    vgf_spec = [vgf_spec; abs(fftshift(vgf))];

    figure(3);
    subplot(3,1,1), plot(t,v,'k',t,g,'r')
    subplot(3,1,2), plot(t,vg,'k')
    axis([-0.5 0.5 0 L])
    subplot(3,1,3), plot(ks,abs(fftshift(vgf))/max(abs(vgf)),'k');
    axis([-25000 25000 0 1])
    drawnow
    pause(0.05)
end

figure(4);
pcolor(vgf_spec.'), shading interp