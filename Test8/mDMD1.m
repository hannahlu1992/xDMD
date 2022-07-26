function [D,Z_k,k,bias] = mDMD1(X1,X2,eps)
X1_tilde = [X1;ones(1,size(X1,2))];
% X1_tilde(1,:) = 0; X1_tilde(end-1,:) = 0;
Am = X2*pinv(X1_tilde);
bias = Am(:,end);
for i = 1:size(X1,2)
    X1(:,i) = X1(:,i)-bias;
    X2(:,i) = X2(:,i)-bias;
end
[D,Z_k,k] = DMD1(X1,X2,eps);
end