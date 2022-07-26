function [D,Z_k,k] = DMD1(X1,X2,eps)
[U,Sigma,V] = svd(X1,'econ');
%index = find(diag(Sigma)<=sum(diag(Sigma))*eps);
k = 20;% min(index);
U_k = U(:,1:k); Sigma_k = Sigma(1:k,1:k); V_k = V(:,1:k);
Atilde = U_k'*X2*V_k/Sigma_k;
[W,D] = eig(Atilde);
Z_k = U_k*W;
end