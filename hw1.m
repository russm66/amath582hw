% Matt Russell
% AMATH 582 hw1.m
% 20 is how many sets of data we have

clear all; close all; clc;
load('Testdata.mat') % Undata is f: R^1->C^2 {(Re_k,Im_k),...}
L=15; % spatial domain [-L,L]
n=64; % Fourier modes
x2=linspace(-L,L,n+1); x=x2(1:n); y=x; z=x;
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; ks=fftshift(k); 
[X,Y,Z]=meshgrid(x,y,z);
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);

% create data cubes 2^6x2^6x2^6
Uf = zeros(n,n,n);
for j=1:20
    Utn(j,:,:,:) = reshape(Undata(j,:),n,n,n);
    Uf = Uf + fftshift(fftn(Utn(j,:,:,:)));
end

% Uf matches to Kx,Ky,Kz 

% average spectrum




%% Original Code
% Un(:,:,:)=reshape(Undata(1,:),n,n,n);
% isosurface(X,Y,Z,abs(Un),0.4);
% axis([-20 20 -20 20 -20 20]), grid on, drawnow

% for j=1:20
% Un(:,:,:)=reshape(Undata(j,:),n,n,n);
% close all, isosurface(X,Y,Z,abs(Un),0.4)
% axis([-20 20 -20 20 -20 20]), grid on, drawnow
% pause(.01)
% end
