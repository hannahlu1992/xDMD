clear all;
%% learning advection-diffusion operator 2d
%% input different IC, output prediction.
T = 4;%6.8;
dt = 0.002; t = 0:dt:T; NT = length(t);
dx = 0.25;x = dx/2:dx:20-dx/2;NX = length(x);
dy = 0.25;y = dy/2:dy:10-dy/2;NY = length(y);
v = [-2.5,0];
D = [0.5;0.5];

M = 4000;
xr = 10*rand(M);
yr = 10*rand(M);
sigma = sqrt(1/20);
strength = 100;
S = zeros(NX,NY);
for i = 1:NX
    for j = 1:NY
        S(i,j) = strength*exp(-0.5*((x(i)-5)^2/sigma^2+(y(j)-5)^2/sigma^2));
    end
end 

% % X1 = zeros(NX*NY,M);
% % X2 = zeros(NX*NY,M);
% % for m = 1:M
% %     Cinit = zeros(NX,NY);
% %     for i = 1:NX
% %         for j = 1:NY
% %             Cinit(i,j) = strength*exp(-0.5*((x(i)-xr(m))^2/sigma^2+(y(j)-yr(m))^2/sigma^2));
% %         end
% %     end 
% %     C = two_d_forward(Cinit,T,S);
% %     X1(:,m) = vec(Cinit);
% %     X2(:,m) = vec(C(:,:,end));
% %     m
% % end
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('data.mat');

%% DMD
A_dmd = X2*pinv(X1);

%% mDMD
X1_tilde = [X1;ones(1,M)];
Am = (X2-X1)*pinv(X1_tilde);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
% % TEST
% xr = 10*rand(1);
% yr = 10*rand(1);
% sigma = sqrt(1./(10+40*rand(1)));
% strength = 50+50*rand(1);
% Cinit = zeros(NX,NY);
% for i = 1:NX
%     for j = 1:NY
%         Cinit(i,j) = strength*exp(-0.5*((x(i)-xr)^2/sigma^2+(y(j)-yr)^2/sigma^2));
%     end
% end 
% 
% xr = 10*rand(2);
% yr = 10*rand(2);
% sigma = sqrt(1./(10+40*rand(2)));
% strength = 50+50*rand(2);
% Cinit = zeros(NX,NY);
% for i = 1:NX
%     for j = 1:NY
%         Cinit(i,j) = strength(1)*exp(-0.5*((x(i)-xr(1))^2/sigma(1)^2+(y(j)-yr(1))^2/sigma(1)^2))+...
%             strength(2)*exp(-0.5*((x(i)-xr(2))^2/sigma(2)^2+(y(j)-yr(2))^2/sigma(2)^2));
%     end
% end 

Cinit = zeros(NX,NY);
Cinit(11,13:25) = 75;

C = two_d_forward(Cinit,T,S);

pos1 = [0.08 0.2 0.34 0.7];
pos2 = [0.56 0.2 0.34 0.7];
c1_pos = [0.44 0.2 0.01 0.7];
c2_pos = [0.92 0.2 0.01 0.7];

clim = [0 11];

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
imagesc(x,y,Cinit');
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
imagesc(x,y,C(:,:,end)',clim);
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
title ({'Test Concentration $t = 4$'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);


print(gcf,'c0_cT_3.png','-dpng','-r300');  


%% test DMD
Xdmd = A_dmd*vec(Cinit);
Cdmd = pic(Xdmd,NX,NY);

%% test mDMD
Xmdmd = vec(Cinit)+Am*[vec(Cinit);1];
Cmdmd = pic(Xmdmd,NX,NY);

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
imagesc(x,y,Cdmd',clim);
colormap jet;
c1 = colorbar;
set(c1,'Position',c1_pos)
title(c1,{'$u$'},'FontUnits','points','interpreter','latex',...
    'FontSize',8);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ({'Concentration $t = 4$ DMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);


subplot('Position',pos2)
imagesc(x,y,Cmdmd',clim);
colormap jet;
c2 = colorbar;
set(c2,'Position',c2_pos)
title(c2,{'$u$'},'FontUnits','points','interpreter','latex',...
    'FontSize',8);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ({'Concentration $t = 4$ xDMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);

print(gcf,'DMD_gDMD_3.png','-dpng','-r300');  

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
imagesc(x,y,abs(C(:,:,end)'-Cdmd'));
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
title ({'Error $t = 4$ DMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);


subplot('Position',pos2)
imagesc(x,y,abs(C(:,:,end)'-Cmdmd'));
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
title ({'Error $t = 4$ xDMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);

print(gcf,'Error_3.png','-dpng','-r300');  

