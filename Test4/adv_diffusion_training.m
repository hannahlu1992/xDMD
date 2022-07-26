clear all;
%% learning advection-diffusion operator
%% input different IC, output prediction.


dx = 4/100; x = -4:dx:4; x= x'; NX = length(x);
dt = dx; T = 4 ; t = 0:dt:T; NT = length(t);

u = zeros(NX,NT);
u(:,1)= exp(-(x+2).^2*10);

A_true = diag((1-dt/dx)*ones(NX,1))+diag(dt/dx*ones(NX-1,1),-1);

D = 0.1;
B_true = diag((1+2*D*dt/dx^2)*ones(NX,1))-diag(D*dt/dx^2*ones(NX-1,1),1)-diag(D*dt/dx^2*ones(NX-1,1),-1);

loc_known = 0;
source = exp(-(x-loc_known).^2*20);

for n = 1:NT-1
    u(:,n+1) = B_true\(A_true*u(:,n))+dt*source; 
    u(1,n+1) = u(2,n+1);
    u(end,n+1) = u(end-1,n+1);
end

X = u;

X1 = X(:,1:end-1);
X2 = X(:,2:end);
A = X2*pinv(X1);
X_dmd = 0*X;
X_dmd(:,1) = X(:,1);
udmd = 0*u;
udmd(:,1) = X(:,1);
for n = 1:NT-1
    X_dmd(:,n+1) = A*X_dmd(:,n);
    udmd(:,n+1) = real(X_dmd(:,n+1));
end

%% mDMD
X1 = X(:,1:end-1);
X1_tilde = [X1;ones(1,length(t)-1)];
X2 = X(:,2:end);
Am = (X2-X1)*pinv(X1_tilde);
X_mdmd = 0*X;
X_mdmd(:,1) = X(:,1);
umdmd = 0*u;
umdmd(:,1) = X(:,1);
for n = 1:NT-1
    X_mdmd(:,n+1) = X_mdmd(:,n)+Am*[X_mdmd(:,n);1];
    umdmd(:,n+1) = real(X_mdmd(:,n+1));
end

% figure
% width = 4;     % Width in inches
% height = 2;    % Height in inches
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');
% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);
% hold on;
% plot(x,u(:,1),'k-','LineWidth',1);
% plot(x(1:5:end),udmd(1:5:end,1),'ko','Markersize',3);
% plot(x(1:5:end),umdmd(1:5:end,1),'kx','Markersize',3);
% plot(x,u(:,floor((NT+1)/2)),'b-','LineWidth',1);
% plot(x(1:5:end),udmd(1:5:end,floor((NT+1)/2)),'bo','Markersize',3);
% plot(x(1:5:end),umdmd(1:5:end,floor((NT+1)/2)),'bx','Markersize',3);
% plot(x,u(:,end),'r-','LineWidth',1);
% plot(x(1:5:end),udmd(1:5:end,end),'ro','Markersize',3);
% plot(x(1:5:end),umdmd(1:5:end,end),'rx','Markersize',3);
% legend({'t = 0 reference','t = 0 DMD','t = 0 xDMD','t = 2 reference','t = 2 DMD','t = 2 xDMD','t = 4 reference','t = 4 DMD','t = 4 xDMD'},...
%      'FontUnits','points','interpreter','latex','FontSize',10,'Location','Bestoutside');
% legend('boxoff') 
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$u$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title('Training','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylim([0,1]);
% print(gcf,'training.eps','-depsc');  
% 
% 
% figure
% width = 2.2;     % Width in inches
% height = 2;    % Height in inches
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');
% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);
% hold on;
% plot(t,log10(sum((u-udmd).^2,1)./sum(u.^2,1)),'k-','LineWidth',1);
% plot(t,log10(sum((u-umdmd).^2,1)./sum(u.^2,1)),'r-.','LineWidth',1);
% xlabel('$t$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('log relative error','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% legend({'DMD','xDMD'},'FontUnits','points','interpreter','latex','FontSize',10,'Location','Best');
% legend('boxoff') 
% title('Training error','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% print(gcf,'training_error.eps','-depsc');  


u_test = zeros(NX,NT);
strength = 1+10*rand(1);
sigma = 10+5*rand(1);
loc = -2+3*rand(1);
u_test(:,1) = strength*exp(-(x-loc).^2*sigma);

% strength2 = 1+10*rand(1);
% sigma2 = 10+5*rand(1);
% loc2 = -2+2*rand(1);
% u_test(:,1) = u_test(:,1)+strength2*exp(-(x-loc2).^2*sigma2);


for n = 1:NT-1
    u_test(:,n+1) = B_true\(A_true*u_test(:,n))+dt*source; 
    u_test(1,n+1) = u_test(2,n+1);
    u_test(end,n+1) = u_test(end-1,n+1);
end



X_dmd_test = 0*u_test;
udmd_test = 0*u_test;
X_dmd_test(:,1) = u_test(:,1);
udmd_test(:,1) = u_test(:,1);
for n = 1:NT-1
    X_dmd_test(:,n+1) = A*X_dmd_test(:,n);
    udmd_test(:,n+1) = real(X_dmd_test(:,n+1));
end

%% mDMD

X_mdmd_test = 0*u_test;
umdmd_test = 0*u_test;
X_mdmd_test(:,1) = u_test(:,1);
umdmd_test(:,1) = u_test(:,1);
for n = 1:NT-1
    X_mdmd_test(:,n+1) = X_mdmd_test(:,n)+Am*[X_mdmd_test(:,n);1];
    umdmd_test(:,n+1) = real(X_mdmd_test(:,n+1));
end

figure
width = 4;     % Width in inches
height = 2;    % Height in inches
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);
hold on;
plot(x,u_test(:,1),'k-','LineWidth',1);
plot(x(1:5:end),udmd_test(1:5:end,1),'ko','Markersize',3);
plot(x(1:5:end),umdmd_test(1:5:end,1),'kx','Markersize',3);
plot(x,u_test(:,floor((NT+1)/2)),'b-','LineWidth',1);
plot(x(1:5:end),udmd_test(1:5:end,floor((NT+1)/2)),'bo','Markersize',3);
plot(x(1:5:end),umdmd_test(1:5:end,floor((NT+1)/2)),'bx','Markersize',3);
plot(x,u_test(:,end),'r-','LineWidth',1);
plot(x(1:5:end),udmd_test(1:5:end,end),'ro','Markersize',3);
plot(x(1:5:end),umdmd_test(1:5:end,end),'rx','Markersize',3);
legend({'t = 0 reference','t = 0 DMD','t = 0 xDMD','t = 2 reference','t = 2 DMD','t = 2 xDMD','t = 4 reference','t = 4 DMD','t = 4 xDMD'},...
     'interpreter','latex','FontSize',10,'Location','Bestoutside');
legend('boxoff') 
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$u$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title('Test1','FontUnits','points','interpreter','latex',...
    'FontSize',10);
print(gcf,'test1.eps','-depsc');  

figure
width = 2;     % Width in inches
height = 2;    % Height in inches
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);
hold on;
plot(t,log10(sum((u_test-udmd_test).^2,1)./sum(u.^2,1)),'k-','LineWidth',1);
plot(t,log10(sum((u_test-umdmd_test).^2,1)./sum(u.^2,1)),'r-.','LineWidth',1);
xlabel('$t$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('log relative error','FontUnits','points','interpreter','latex',...
    'FontSize',10);
legend({'DMD','xDMD'},'interpreter','latex','FontSize',10,'Location','East');
legend('boxoff') 
title('Test1 Error','FontUnits','points','interpreter','latex',...
    'FontSize',10);
print(gcf,'test1_error.eps','-depsc');  


