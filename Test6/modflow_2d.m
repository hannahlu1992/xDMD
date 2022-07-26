clear all;
load('C_training.mat');
load('loc_x.mat');
load('loc_y.mat');
s_x = double(s_x)+1;
s_y = double(s_y)+1;

load('C_test1.mat');
load('C_test2.mat');

x = 1:128;
y = 1:64;
M = 2000;
C0_training = zeros(64,128,M);

X1 = zeros(64*128,M);
X2 = zeros(64*128,M);
for m = 1:M
    for i = 1:64
        for j = 1:128
            C0_training(i,j,m)= 100*exp(-(j-s_x(m))^2-(i-s_y(m))^2);
        end
    end
    X1(:,m) = vec(C0_training(:,:,m));
    X2(:,m) = vec(C_training(:,:,m));
end

% noise1 = randn(size(X1));
% noise2 = randn(size(X2));
% noisyX1 = X1+0.001*X1.*noise1;
% noisyX2 = X2+0.001*X2.*noise2;
% 
% %% DMD
% A_dmd = noisyX2*pinv(noisyX1);
% 
% %% mDMD
% noisyX1_tilde = [noisyX1;ones(1,M)];
% Am = (noisyX2-noisyX1)*pinv(noisyX1_tilde);

%% DMD
% A_dmd = X2*pinv(X1);
[U,Sigma,V] = svd(X1);
index = find(diag(Sigma)<= sum(diag(Sigma))*1e-9);
k = min(index)
% k = rank(Sigma);
U_k = U(:,1:k); Sigma_k = Sigma(1:k,1:k); V_k = V(:,1:k);
A_dmd = X2*(V_k/Sigma_k*U_k');

%% mDMD
X1_tilde = [X1;ones(1,M)];
% Am = (X2-X1)*pinv(X1_tilde);
[U,Sigma,V] = svd(X1_tilde);
index = find(diag(Sigma)<= sum(diag(Sigma))*1e-9);
k = min(index)
% k = rank(Sigma);
U_k = U(:,1:k); Sigma_k = Sigma(1:k,1:k); V_k = V(:,1:k);
Am = (X2-X1)*(V_k/Sigma_k*U_k');

%% Test1
C0_test1 = zeros(64,128);
for i = 1:64
    for j = 1:128
        C0_test1(i,j)= 50*exp(-(j-10)^2-(i-40)^2)+80*exp(-(j-20)^2-(i-20)^2);
    end
end

% X_dmd = A_dmd*vec(C0_test1);
% X_mdmd = vec(C0_test1)+Am*[vec(C0_test1);1];
% 
% C_dmd = pic(X_dmd,64,128);
% C_mdmd = pic(X_mdmd,64,128);
% 
% 
pos1 = [0.08 0.2 0.34 0.7];
pos2 = [0.56 0.2 0.34 0.7];
c1_pos = [0.44 0.2 0.01 0.7];
c2_pos = [0.92 0.2 0.01 0.7];
% 
% figure
% width = 6.6;     % Width in inches
% height = 2;    % Height in inches
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');
% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);
% 
% subplot('Position',pos1)
% imagesc(x,y,C0_test1);
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$u$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'Test Concentration $t = 0$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,C_test1);
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$u$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'Test Concentration $t = 80$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% lim = caxis;
% %print(gcf,'c0_cT_1.png','-dpng','-r300');  
% 
% figure
% width = 6.6;     % Width in inches
% height = 2;    % Height in inches
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');
% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);
% 
% subplot('Position',pos1)
% imagesc(x,y,C_dmd,lim);
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$u$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'Concentration $t = 80$ DMD'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,C_mdmd,lim);
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$u$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'Concentration $t = 80$ xDMD'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% %print(gcf,'DMD_gDMD_1.png','-dpng','-r300');  
% 
% figure
% width = 6.6;     % Width in inches
% height = 2;    % Height in inches
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');
% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);
% 
% subplot('Position',pos1)
% imagesc(x,y,abs(C_test1-C_dmd));
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$u$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'Error $t = 80$ DMD'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,abs(C_test1-C_mdmd));
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$u$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'Error $t = 80$ xDMD'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% %print(gcf,'error_1.png','-dpng','-r300'); 


%% Test2
C0_test2 = zeros(64,128);
C0_test2(20:40,10) = 80;


X_dmd = A_dmd*vec(C0_test2);
X_mdmd = vec(C0_test2)+Am*[vec(C0_test2);1];

C_dmd = pic(X_dmd,64,128);
C_mdmd = pic(X_mdmd,64,128);

figure
width = 6.6;     % Width in inches
height = 2;    % Height in inches
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);

subplot('Position',pos1)
imagesc(x,y,C0_test2);
colormap jet;
colorbar
c1 = colorbar;
set(c1,'Position',c1_pos)
title(c1,{'$u$'},'FontUnits','points','interpreter','latex',...
    'FontSize',8);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ({'Test Concentration $t = 0$'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);

subplot('Position',pos2)
imagesc(x,y,C_test2);
colormap jet;
colorbar
c2 = colorbar;
set(c2,'Position',c2_pos)
title(c2,{'$u$'},'FontUnits','points','interpreter','latex',...
    'FontSize',8);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ({'Test Concentration $t = 80$'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);
lim = caxis;
%print(gcf,'c0_cT_2.png','-dpng','-r300');  

figure
width = 6.6;     % Width in inches
height = 2;    % Height in inches
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);

subplot('Position',pos1)
imagesc(x,y,C_dmd,lim);
colormap jet;
colorbar
c1 = colorbar;
set(c1,'Position',c1_pos)
title(c1,{'$u$'},'FontUnits','points','interpreter','latex',...
    'FontSize',8);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ({'Concentration $t = 80$ DMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);

subplot('Position',pos2)
imagesc(x,y,C_mdmd,lim);
colormap jet;
colorbar
c2 = colorbar;
set(c2,'Position',c2_pos)
title(c2,{'$u$'},'FontUnits','points','interpreter','latex',...
    'FontSize',8);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ({'Concentration $t = 80$ xDMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);
print(gcf,'DMD_gDMD_2_noise.png','-dpng','-r300');  

figure
width = 6.6;     % Width in inches
height = 2;    % Height in inches
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);

subplot('Position',pos1)
imagesc(x,y,abs(C_test2-C_dmd));
colormap jet;
colorbar
c1 = colorbar;
set(c1,'Position',c1_pos)
title(c1,{'$u$'},'FontUnits','points','interpreter','latex',...
    'FontSize',8);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ({'Error $t = 80$ DMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);

subplot('Position',pos2)
imagesc(x,y,abs(C_test2-C_mdmd));
colormap jet;
colorbar
c2 = colorbar;
set(c2,'Position',c2_pos)
title(c2,{'$u$'},'FontUnits','points','interpreter','latex',...
    'FontSize',8);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ({'Error $t = 80$ xDMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);
print(gcf,'error_2_noise.png','-dpng','-r300'); 


% load('perm.mat');
% figure
% width = 3.3;     % Width in inches
% height = 2;    % Height in inches
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');
% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);
% 
% subplot('Position',[0.12 0.2 0.7 0.7])
% imagesc(x,y,perm);
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',[0.86 0.2 0.02 0.7])
% title(c2,{'$K$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'Hydraulic Conductivity'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% print(gcf,'perm.png','-dpng','-r300'); 




