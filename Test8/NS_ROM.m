clear all;
load('NS_4.mat');

dt = 0.0015;
t = 7.5+dt:dt:15;
t1 = 7.5+dt:dt:11.25;
t2 = 11.25+dt:dt:15;

dx = 0.02;
x = dx/2:dx:2-dx/2;
dy = dx;
y = dy/2:dy:1-dy/2;


M1 = M(1:2:100,1:2:200,1:2500);
M2 = M(1:2:100,1:2:200,2501:5000);
X = reshape(M(1:2:100,1:2:200,:),[50*100,5000]);


noise = 0*X.*randn(size(X));
X = X+noise;

s = 2;
rng(s);
index1 = randperm(2498,2498);
index1 = sort(index1)+1;
index2 = index1+1;

X1 = [X(:,1),X(:,index1)];
X2 = [X(:,2),X(:,index2)];
nt = 5000;

%%DMD use psedo inverse
eps = 1e-8;

% A_dmd = X2*pinv(X1,eps);
[U,Sigma,V] = svd(X1);
index = find(diag(Sigma)<= sum(diag(Sigma))*1e-5);
k = min(index)
% k = rank(Sigma);
U_k = U(:,1:k); Sigma_k = Sigma(1:k,1:k); V_k = V(:,1:k);
A_dmd = X2*(V_k/Sigma_k*U_k');

X_dmd = zeros(50*100,5000);
X_dmd(:,1) = X(:,1);
M_dmd = zeros(50,100,5000);
M_dmd(:,:,1) = M1(:,:,1);
for n = 1:nt-1
    X_dmd(:,n+1) = A_dmd*X_dmd(:,n);
    M_dmd(:,:,n+1) = reshape(X_dmd(:,n+1),[50,100]);
end

% mDMD
X1_tilde = [X1;ones(1,length(index1)+1)];
% Am = (X2-X1)*pinv(X1_tilde,eps);
[U,Sigma,V] = svd(X1_tilde);
index = find(diag(Sigma)<= sum(diag(Sigma))*1e-5);
k = min(index)
% k = rank(Sigma);
U_k = U(:,1:k); Sigma_k = Sigma(1:k,1:k); V_k = V(:,1:k);
Am = (X2-X1)*(V_k/Sigma_k*U_k');

X_mdmd = zeros(50*100,5000);
X_mdmd(:,1) = X(:,1);
M_mdmd = zeros(50,100,5000);
M_mdmd(:,:,1) = M1(:,:,1);
for n = 1:nt-1
    X_mdmd(:,n+1) = X_mdmd(:,n)+ Am*[X_mdmd(:,n);1];
     M_mdmd(:,:,n+1) = reshape(X_mdmd(:,n+1),[50,100]);
end


X_true = reshape(M(1:2:100,1:2:200,:),[50*100,5000]);

error_dmd = sum((X_true-X_dmd).^2,1)./sum(X_true.^2,1);
error_mdmd = sum((X_true-X_mdmd).^2,1)./sum(X_true.^2,1);

figure
hold on;
plot(t,error_dmd,'LineWidth',1);
plot(t,error_mdmd,'LineWidth',1);
legend('DMD','mDMD');
set(gca,'YScale','log');
xlabel('t');
ylabel('error');
xlim([t1(1),t1(end)]);
title('rep error vs time');

figure
hold on;
plot(t,error_dmd,'LineWidth',1);
plot(t,error_mdmd,'LineWidth',1);
legend('DMD','mDMD');
set(gca,'YScale','log');
xlabel('t');
ylabel('error');
xlim([t2(1),t2(end)]);
title('extrap error vs time');

figure
plot(t,sum(X_true.^2,1))

