%%variable declarations
clear all
nx = 41;
ny = 41;
nt = 2000;
c=1;
dx = 2.0/(nx-1);
dy = 2.0/(ny-1);
sigma = .002;
nu=.005;
dt = sigma*dx*dy/nu;
t = linspace(0,dt*nt,nt);

x = linspace(0,2,nx);
y = linspace(0,2,ny);

u = zeros(ny,nx,nt); %%create a 1xn vector of 1's
v = zeros(ny,nx,nt);

%%%Assign initial conditions

% u(1:.5/dy+1,1:.5/dx+1,1)=1;
% v(1:.5/dy+1,1:.5/dx+1,1)=1; 

u(.5/dy+1:1/dy+1,.5/dx+1:1/dx+1,1)=1; %%set hat function I.C. : u(.5<=x<=1 && .5<=y<=1 ) is 2
v(.5/dy+1:1/dy+1,.5/dx+1:1/dx+1,1)=1; %%set hat function I.C. : u(.5<=x<=1 && .5<=y<=1 ) is 2



%%%Plot Initial Condition
 %%the figsize parameter can be used to produce different sized images
                  
[X, Y] = meshgrid(x,y);                            


for n=1:nt-1
    for i=2:(ny-1)
        for j=2:(nx-1)
        u(i,j,n+1)=u(i,j,n)- (dt/dx) * u(i,j,n)*(u(i,j,n) -u(i-1,j,n)) - (dt/dy) * v(i,j,n)*(u(i,j,n)-u(i,j-1,n)) + (nu*dt/dx^2) *(u(i-1,j,n)-2*u(i,j,n)+u(i-1,j,n)) + (nu*dt/dy^2) * (u(i,j+1,n)-2*u(i,j,n)+u(i,j-1,n));
        v(i,j,n+1)=v(i,j,n)- (dt/dx) * u(i,j,n)*(v(i,j,n) -v(i-1,j,n)) - (dt/dy) * v(i,j,n)*(v(i,j,n)-v(i,j-1,n)) + (nu*dt/dx^2) *( v(i-1,j,n)-2*v(i,j,n)+v(i-1,j,n)) + (nu*dt/dy^2) * (v(i,j+1,n)-2*v(i,j,n)+v(i,j-1,n));


            u(ny,1:nx,n+1)=u(ny-1,1:nx,n+1);
            u(1:nx,ny,n+1)=u(1:nx,ny-1,n+1);
            u(1,1:nx,n+1)=u(2,1:nx,n+1);
            u(1:ny,1,n+1)=u(1:ny,2,n+1);
            v(ny,1:nx,n+1)=v(ny-1,1:nx,n+1);
            v(1:nx,ny,n+1)=v(1:nx,ny-1,n+1);
            v(1:ny,1,n+1)=v(1:ny,2,n+1);
            v(1,1:nx,n+1)=v(2,1:nx,n+1);
%             u(1:.5/dy+1,1,n+1) = 1;
%             u(1,1:.5/dy+1,n+1) = 1;
%             v(1:.5/dy+1,1,n+1) = 1;
%             v(1,1:.5/dy+1,n+1) = 1;
        end
    end
end

pos1 = [0.08 0.2 0.19 0.7];
pos2 = [0.41 0.2 0.19 0.7];
pos3 = [0.74 0.2 0.19 0.7];
c1_pos = [0.29 0.2 0.01 0.7];
c2_pos = [0.62 0.2 0.01 0.7];
c3_pos = [0.95 0.2 0.01 0.7];



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
imagesc(x,y,v(:,:,1))
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
title ({'$t = 0$'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);

subplot('Position',pos2)
imagesc(x,y,v(:,:,nt/2))
% colormap jet;
colorbar
c2 = colorbar;
set(c2,'Position',c2_pos)
title(c2,{'$u$'},'FontUnits','points','interpreter','latex',...
    'FontSize',8);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ({'$t = 1$'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);

subplot('Position',pos3)
imagesc(x,y,v(:,:,end))
% colormap jet;
colorbar
c3 = colorbar;
set(c3,'Position',c3_pos)
title(c3,{'$u$'},'FontUnits','points','interpreter','latex',...
    'FontSize',8);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ({'$t = 2$'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);

% print(gcf,'soln.png','-dpng','-r1500');  

% 
% u = reshape(u,[nx*ny,nt]);
% v = reshape(v,[nx*ny,nt]);
% 
% % X = [u;v];
% X = u;
% s = 9;
% rng(s);
% index1 = randperm(1998,498);
% index1 = sort(index1)+1;
% index2 = index1+1;
% 
% %% DMD use psedo inverse
% X1 = [X(:,1),X(:,index1)];
% X2 = [X(:,2),X(:,index2)];
% A_dmd = X2*pinv(X1,1e-8);
% X_dmd = 0*X;
% X_dmd(:,1) = X(:,1);
% for n = 1:nt-1
%     X_dmd(:,n+1) = A_dmd*X_dmd(:,n);
% end
% %%
% A_dmd2 = (X2-X1)*pinv(X1,1e-8);
% X_dmd2 = 0*X;
% X_dmd2(:,1) = X(:,1);
% for n = 1:nt-1
%     X_dmd2(:,n+1) = X_dmd2(:,n)+A_dmd2*X_dmd2(:,n);
% end
% 
% 
% %% mDMD
% X1_tilde = [X1;ones(1,length(index1)+1)];
% Am = X2*pinv(X1_tilde,1e-8);
% 
% X_mdmd = 0*X;
% X_mdmd(:,1) = X(:,1);
% 
% for n = 1:nt-1
%     X_mdmd(:,n+1) = Am*[X_mdmd(:,n);1];
% end
% 
% %%
% Am2 = (X2-X1)*pinv(X1_tilde,1e-8);
% 
% X_mdmd2 = 0*X;
% X_mdmd2(:,1) = X(:,1);
% 
% for n = 1:nt-1
%     X_mdmd2(:,n+1) = X_mdmd2(:,n)+Am2*[X_mdmd2(:,n);1];
% end
% 
% u_dmd = X_dmd(1:nx*ny,:);
% u_mdmd = X_mdmd2(1:nx*ny,:);
% 
% udmd = zeros(nx,ny,nt);
% umdmd = zeros(nx,ny,nt);
% for n = 1:nt
%     udmd(:,:,n) = pic(u_dmd(:,n),nx,ny);
%     umdmd(:,:,n) = pic(u_mdmd(:,n),nx,ny);
% end
% 
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
% plot(t,log10(sum((X-X_dmd).^2,1)./sum(X.^2,1)),'k-','LineWidth',1);
% hold on;
% plot(t,log10(sum((X-X_mdmd2).^2,1)./sum(X.^2,1)),'r-.','LineWidth',1);
% xlabel('$t$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('log relative error','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% legend({'DMD','xDMD'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10,'Location','Best');
% legend('boxoff') 
% title('Interpolation','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylim([-16,-10]);
% print(gcf,'error.png','-dpng','-r1500');  