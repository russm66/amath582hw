% Matt Russell
% 3/16/20
% amath582 hw3_svd.m
% Script to perform Reduced SVD
% preprocessing script (hw3_preproc.m) needs to be run before this
 

%% SVD
% Xm = [ya;xa;yb;xb;yc;xc]
% m and n are the same for all X
% 'econ' for reduced SVD
[m, n] = size(X1);
mn1 = mean(X1,2);
mn2 = mean(X2,2);
mn3 = mean(X3,2);   
mn4 = mean(X4,2);

X1 = X1 - repmat(mn1,1,n);
X2 = X2 - repmat(mn2,1,n);
X3 = X3 - repmat(mn3,1,n);
X4 = X4 - repmat(mn4,1,n);

% transposing so it's overdetermined
X1 = X1';
X2 = X2';
X3 = X3';
X4 = X4';

% Ideal Case
[u1,s1,v1] = svd(X1/(m-1),'econ');
% lambda1 = diag(s1).^2;
% Y1 = u1'*X1;
covY1 = (1/(m-1))*s1.^2;

% Noisy Case
[u2,s2,v2] = svd(X2/(m-1),'econ');
% lambda2 = diag(s2).^2;
% Y2 = u2'*X2;
covY2 = (1/(m-1))*s2.^2;

% Horizontal Displacement
[u3,s3,v3] = svd(X3/(m-1),'econ');
% lambda3 = diag(s3).^2;
% Y3 = u3'*X3;
covY3 = (1/(m-1))*s3.^2;

% Horizontal Displacement + Rotation
[u4,s4,v4] = svd(X4/(m-1),'econ');
% lambda4 = diag(s4).^2;
% Y4 = u4'*X4;
covY4 = (1/(m-1))*s4.^2;

% don't need this anymore
clear n mn1 mn2 mn3 mn4
