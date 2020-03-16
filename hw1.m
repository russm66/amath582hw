% Matt Russell
% AMATH 582 hw1.m
% 20 is how many datasets we have

clear all; close all; clc;
load('Testdata.mat') % Undata is time-series data concerning the spatial 
                     % variations of fluffy's intestines
L = 15; % spatial domain [-L,L]
n=64; % fourier modes
x2 = linspace(-L,L,n+1); x=x2(1:n); y=x; z=x; nummeas = 20;
k = (2*pi)/(2*L)*[0:(n/2-1) -n/2:-1]; ks=fftshift(k);
[X,Y,Z] = meshgrid(x,y,z);
[Kx,Ky,Kz] = meshgrid(ks,ks,ks);

%% Average spectra
% Create data cubes 2^6x2^6x2^6
ufave = zeros(n,n,n);
un = zeros(nummeas,n,n,n);
utf = un;

% Reshape individual datalines into datacubes and also sum the individual
% cubes at the same time to produce the average
for j = 1:nummeas
    un(j,:,:,:) = reshape(Undata(j,:),n,n,n);
    utn(:,:,:) = un(j,:,:,:);
    ufave = ufave + abs(fftshift(fftn(utn(:,:,:)))); %add the amplitudes
end

ufave = ufave/nummeas; % average
[ufavemax,index] = max(ufave,[],'all','linear');

wx = Kx(index);
wy = Ky(index);
wz = Kz(index);

%% Gaussian filter around center frequencies
window = 1;
utff = zeros(nummeas,n,n,n);
utffifft = zeros(n,n,n);
filter = exp(-window*((Kx - wx).^2 + (Ky - wy).^2 + (Kz - wz).^2));

figure(1);
for j = 1:nummeas
    utn(:,:,:) = un(j,:,:,:);
    Utf(:,:,:) = filter.*fftshift(fftn(utn));
    utffifft = ifftn(ifftshift(Utf));
    [utffifftmax,uindex] = max(utffifft,[],'all','linear');
    isosurface(X,Y,Z,abs(utffifft)/abs(utffifftmax),0.5)
    drawnow
    pause(1)
end
title('marble trajectory');
xlabel('x');
ylabel('y');
zlabel('z');

mx = X(uindex);
my = Y(uindex);
mz = Z(uindex);