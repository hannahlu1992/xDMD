clear all;
x = [167,167,349,349,462,462,260,167,167,258,561,652,652,455,455,341,341,562,652,652,547,269];
y = [146,295,295,226,226,327,327,417,691,782,782,690,542,542,603,603,508,508,418,146,42,42];
y = y-10;

thermalmodel = createpde('thermal','transient');
R1 =  [3;4;0;800;800;0;0;0;800;800];
n = length(x);
P1 = [2;n;x';y'];
R1 = [R1;zeros(length(P1)-length(R1),1)];
gd = [R1,P1]; 
sf = 'R1-P1';
ns = char('R1','P1');
ns = ns';
g = decsg(gd,sf,ns);
geometryFromEdges(thermalmodel,g);
thermalProperties(thermalmodel,'ThermalConductivity',1,...
                               'MassDensity',1,...
                               'SpecificHeat',1);
internalHeatSource(thermalmodel,0);

%% BC
thermalBC(thermalmodel,'Edge',1,'Temperature',1);
thermalBC(thermalmodel,'Edge',23,'Temperature',2);
thermalBC(thermalmodel,'Edge',3:22,'Temperature',3);
thermalBC(thermalmodel,'Edge',25:26,'Temperature',3);

%% IC
thermalIC(thermalmodel,0);

msh = generateMesh(thermalmodel,'Hmax',20);

pos1 = [0.08 0.2 0.19 0.7];
pos2 = [0.41 0.2 0.19 0.7];
pos3 = [0.74 0.2 0.19 0.7];
c1_pos = [0.29 0.2 0.01 0.7];
c2_pos = [0.62 0.2 0.01 0.7];
c3_pos = [0.95 0.2 0.01 0.7];

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
% subplot('Position',pos1);
% pdegplot(thermalmodel);
% hold on;
% plot(zeros(800),1:800,'g-','LineWidth',1.5);
% plot(800*ones(800),1:800,'b-','LineWidth',1.5);
% plot([x,x(1)],[y,y(1)],'r-','LineWidth',1.5);
% xlim([0 800]);
% ylim([0 800]);
% set(gca,'FontSize',7);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ('Geometry','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% text(10,400,'$\partial D_L$','FontUnits','points','interpreter','latex',...
%     'FontSize',7,'Color','g');
% text(400,400,'$\partial S$','FontUnits','points','interpreter','latex',...
%     'FontSize',7,'Color','r');
% text(667,400,'$\partial D_R$','FontUnits','points','interpreter','latex',...
%     'FontSize',7,'Color','b');
% 
% subplot('Position',pos2);
% pdemesh(thermalmodel); 
% xlim([0 800]);
% ylim([0 800]);
% set(gca,'FontSize',7);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ('Computational Mesh','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% print(gcf,'domain.png','-dpng','-r1500');  





nframes = 2000;
tlist = linspace(0,16000,nframes);

thermalmodel.SolverOptions.ReportStatistics ='on';
result = solve(thermalmodel,tlist);
T = result.Temperature;
noise = 1e-3*T.*randn(size(T));
noisyT = T+noise;

s = 12;
rng(s);
index1 = randperm(1198,1198);
index1 = sort(index1)+1;
index2 = index1+1;

eps = 1e-7;
%%DMD use psedo inverse
X1 = [noisyT(:,1),noisyT(:,index1)];
X2 = [noisyT(:,2),noisyT(:,index2)];
A_dmd = X2*pinv(X1,eps);
T_dmd = 0*noisyT;
T_dmd(:,1) = noisyT(:,1);
for n = 1:nframes-1
    T_dmd(:,n+1) = A_dmd*T_dmd(:,n);
end

%% mDMD
X1_tilde = [X1;ones(1,length(index1)+1)];
Am = (X2-X1)*pinv(X1_tilde,eps);

T_mdmd = 0*noisyT;
T_mdmd(:,1) = noisyT(:,1);

for n = 1:nframes-1
    T_mdmd(:,n+1) = T_mdmd(:,n)+ Am*[T_mdmd(:,n);1];
end

%
% % Plot the solution.
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
% subplot('Position',pos1);
% pdeplot(thermalmodel,'XYData',T(:,500),'ColorMap','jet')
% xlim([0,800]);
% ylim([0,800]);
% set(gca,'FontSize',7);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title('Reference $t = 2000$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% lim = caxis;
% hcb = colorbar;
% title(hcb,{'$u$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% set(hcb,'Position',c1_pos)
% 
% subplot('Position',pos2)
% pdeplot(thermalmodel,'XYData',T(:,1000),'ColorMap','jet')
% xlim([0,800]);
% ylim([0,800]);
% set(gca,'FontSize',7);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title('Reference $t = 5000$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% caxis(lim);
% hcb = colorbar;
% title(hcb,{'$u$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% set(hcb,'Position',c2_pos)
% 
% subplot('Position',pos3)
% pdeplot(thermalmodel,'XYData',T(:,end),'ColorMap','jet')
% xlim([0,800]);
% ylim([0,800]);
% set(gca,'FontSize',7);
% c3 = colorbar;
% set(c3,'Position',c3_pos)
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title('Reference $t = 10000$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% caxis(lim);
% hcb = colorbar
% title(hcb,{'$u$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% set(hcb,'Position',c3_pos)
% 
% print(gcf,'soln.png','-dpng','-r1500'); 


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

subplot(1,3,1)
plot(tlist, log10(sum((T-T_dmd).^2,1)./sum(T.^2,1)),'k-','LineWidth',1);
hold on;
plot(tlist, log10(sum((T-T_mdmd).^2,1)./sum(T.^2,1)),'r-.','LineWidth',1);
% set(gca,'YScale','log');
set(gca,'FontSize',7);
xlabel('$t$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('log relative error','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title('Representation','FontUnits','points','interpreter','latex',...
    'FontSize',10);
legend({'DMD','xDMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10,'Location','Best');
legend('boxoff') 
xlim([0,tlist(1200)])


subplot(1,3,2)
plot(tlist, log10(sum((T-T_dmd).^2,1)./sum(T.^2,1)),'k-','LineWidth',1);
hold on;
plot(tlist, log10(sum((T-T_mdmd).^2,1)./sum(T.^2,1)),'r-.','LineWidth',1);
% set(gca,'YScale','log');
set(gca,'FontSize',7);
xlabel('$t$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('log relative error','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title('Extrapolation','FontUnits','points','interpreter','latex',...
    'FontSize',10);
legend({'DMD','xDMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10,'Location','Best');
legend('boxoff') 

s = 12;
rng(s);
index1 = randperm(1198,598);
index1 = sort(index1)+1;
index2 = index1+1;

eps = 1e-7;
%DMD use psedo inverse
X1 = [noisyT(:,1),noisyT(:,index1)];
X2 = [noisyT(:,2),noisyT(:,index2)];
A_dmd = X2*pinv(X1,eps);
T_dmd = 0*noisyT;
T_dmd(:,1) = noisyT(:,1);
for n = 1:nframes-1
    T_dmd(:,n+1) = A_dmd*T_dmd(:,n);
end

% mDMD
X1_tilde = [X1;ones(1,length(index1)+1)];
Am = (X2-X1)*pinv(X1_tilde,eps);

T_mdmd = 0*noisyT;
T_mdmd(:,1) = noisyT(:,1);

for n = 1:nframes-1
    T_mdmd(:,n+1) = T_mdmd(:,n)+ Am*[T_mdmd(:,n);1];
end

subplot(1,3,3)
plot(tlist, log10(sum((T-T_dmd).^2,1)./sum(T.^2,1)),'k-','LineWidth',1);
hold on;
plot(tlist, log10(sum((T-T_mdmd).^2,1)./sum(T.^2,1)),'r-.','LineWidth',1);
% set(gca,'YScale','log');
set(gca,'FontSize',7);
xlabel('$t$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('log relative error','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title('Interpolation','FontUnits','points','interpreter','latex',...
    'FontSize',10);
legend({'DMD','xDMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10,'Location','Best');
legend('boxoff') 
xlim([0,tlist(1000)])
% print(gcf,'error_noise.png','-dpng','-r1500');  






