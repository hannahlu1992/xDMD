% clear all;
% % 
% % A = imread('stanford.png');
% % figure
% % imshow(A)
% % 
% 
% % % B = imread('stanford_tree.png');
% % % figure
% % % image(B)
% % % 
% % % C = imread('stanford_tree_green.png');
% % % figure
% 
% 
% % BW_A = im2bw(A);BW_A = 1-BW_A;
% % figure
% % imshow(BW_A)
% % 
% % BW_filled = imfill(BW_A,'holes');
% % boundaries = bwboundaries(BW_filled);
% % 
% % b = boundaries{1};
% % b(:,2) = 850-b(:,2);
% % figure
% % hold on
% % plot(b(:,2),b(:,1),'g','LineWidth',3);

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

subplot('Position',pos1);
pdegplot(thermalmodel);
hold on;
plot(zeros(800),1:800,'g-','LineWidth',1.5);
plot(800*ones(800),1:800,'b-','LineWidth',1.5);
plot([x,x(1)],[y,y(1)],'r-','LineWidth',1.5);
% plot([x(20),x(21)],[y(20),y(21)],'k-','LineWidth',2);
xlim([0 800]);
ylim([0 800]);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ('Geometry','FontUnits','points','interpreter','latex',...
    'FontSize',10);
text(10,400,'$\partial D_L$','FontUnits','points','interpreter','latex',...
    'FontSize',7,'Color','g');
text(400,400,'$\partial S$','FontUnits','points','interpreter','latex',...
    'FontSize',7,'Color','r');
text(667,400,'$\partial D_R$','FontUnits','points','interpreter','latex',...
    'FontSize',7,'Color','b');
text(655,40,'$\partial S_0$','FontUnits','points','interpreter','latex',...
    'FontSize',7,'Color','k');
text(599,88,'$\}$','Rotation',315,'FontUnits','points','interpreter','latex',...
    'FontSize',18,'Color','k');

subplot('Position',pos2);
pdemesh(thermalmodel); 
xlim([0 800]);
ylim([0 800]);
xlabel('$x$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('$y$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title ('Computational Mesh','FontUnits','points','interpreter','latex',...
    'FontSize',10);
print(gcf,'domain1.png','-dpng','-r1500');  
% 
% 
% 
% nframes = 2000;
% tlist = linspace(0,10000,nframes);
% 
% thermalmodel.SolverOptions.ReportStatistics ='on';
% result = solve(thermalmodel,tlist);
% T = result.Temperature;
% 
% 
% % % Plot the solution.
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
% pdeplot(thermalmodel,'XYData',T(:,400),'ColorMap','jet')
% xlim([0,800]);
% ylim([0,800]);
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
% pdeplot(thermalmodel,'XYData',T(:,2000),'ColorMap','jet')
% xlim([0,800]);
% ylim([0,800]);
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
% % print(gcf,'soln.png','-dpng','-r1500');  
% 
% 

% 
% eps = 1e-6;
% %%DMD use psedo inverse
% X1 = T(:,1:1200);
% X2 = T(:,2:1201);
% 
% % A_dmd = X2*pinv(X1,eps);
% [U,Sigma,V] = svd(X1);
% index = find(diag(Sigma)<= sum(diag(Sigma))*1e-10);
% k = min(index)
% % k = rank(Sigma);
% U_k = U(:,1:k); Sigma_k = Sigma(1:k,1:k); V_k = V(:,1:k);
% A_dmd = X2*(V_k/Sigma_k*U_k');
% 
% 
% T_dmd = 0*T;
% T_dmd(:,1) = T(:,1);
% for n = 1:nframes-1
%     T_dmd(:,n+1) = A_dmd*T_dmd(:,n);
% end
% 
% %% mDMD
% X1_tilde = [X1;ones(1,1200)];
% % Am = (X2-X1)*pinv(X1_tilde,eps);
% [U,Sigma,V] = svd(X1_tilde);
% index = find(diag(Sigma)<= sum(diag(Sigma))*1e-10);
% k = min(index)
% % k = rank(Sigma);
% U_k = U(:,1:k); Sigma_k = Sigma(1:k,1:k); V_k = V(:,1:k);
% Am = (X2-X1)*(V_k/Sigma_k*U_k');
% 
% T_mdmd = 0*T;
% T_mdmd(:,1) = T(:,1);
% 
% for n = 1:nframes-1
%     T_mdmd(:,n+1) = T_mdmd(:,n)+ Am*[T_mdmd(:,n);1];
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
% plot(tlist, log10(sum((T-T_dmd).^2,1)./sum(T.^2,1)),'k-','LineWidth',1);
% hold on;
% plot(tlist, log10(sum((T-T_mdmd).^2,1)./sum(T.^2,1)),'r-.','LineWidth',1);
% %set(gca,'YScale','log');
% xlabel('$t$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('log relative error','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title('Interpolation','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% legend({'DMD','gDMD'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10,'Location','Best');
% legend('boxoff') 
% % ylim([-10,0])
% % print(gcf,'error.png','-dpng','-r1500');  
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % 
% % 
% % 
% % 
% % s = 12;
% % rng(s);
% % index1 = randperm(1798,598);
% % index1 = sort(index1)+1;
% % index2 = index1+1;
% % 
% % eps = 1e-8;
% % %%DMD use psedo inverse
% % X1 = [T(:,1),T(:,index1)];
% % X2 = [T(:,2),T(:,index2)];
% % A_dmd = X2*pinv(X1,eps);
% % T_dmd = 0*T;
% % T_dmd(:,1) = T(:,1);
% % for n = 1:nframes-1
% %     T_dmd(:,n+1) = A_dmd*T_dmd(:,n);
% % end
% % 
% % %% mDMD
% % X1_tilde = [X1;ones(1,length(index1)+1)];
% % Am = (X2-X1)*pinv(X1_tilde,eps);
% % 
% % T_mdmd = 0*T;
% % T_mdmd(:,1) = T(:,1);
% % 
% % for n = 1:nframes-1
% %     T_mdmd(:,n+1) = T_mdmd(:,n)+ Am*[T_mdmd(:,n);1];
% % end
% % 
% % %%
% % % % Plot the solution.
% % figure
% % width = 6.6;     % Width in inches
% % height = 2;    % Height in inches
% % set(gcf,'InvertHardcopy','on');
% % set(gcf,'PaperUnits', 'inches');
% % papersize = get(gcf, 'PaperSize');
% % left = (papersize(1)- width)/2;
% % bottom = (papersize(2)- height)/2;
% % myfiguresize = [left, bottom, width, height];
% % set(gcf,'PaperPosition', myfiguresize);
% % 
% % subplot('Position',pos1);
% % pdeplot(thermalmodel,'XYData',T(:,360),'ColorMap','jet')
% % xlim([0,800]);
% % ylim([0,800]);
% % xlabel('$x$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % ylabel('$y$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % title('Reference $T = 2000$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % lim = caxis;
% % hcb = colorbar;
% % title(hcb,{'$u$'},'FontUnits','points','interpreter','latex',...
% %     'FontSize',8);
% % set(hcb,'Position',c1_pos)
% % 
% % subplot('Position',pos2)
% % pdeplot(thermalmodel,'XYData',T_dmd(:,360),'ColorMap','jet')
% % xlim([0,800]);
% % ylim([0,800]);
% % xlabel('$x$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % ylabel('$y$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % title('DMD $T = 2000$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % caxis(lim);
% % hcb = colorbar;
% % title(hcb,{'$u$'},'FontUnits','points','interpreter','latex',...
% %     'FontSize',8);
% % set(hcb,'Position',c2_pos)
% % 
% % subplot('Position',pos3)
% % pdeplot(thermalmodel,'XYData',T_mdmd(:,360),'ColorMap','jet')
% % xlim([0,800]);
% % ylim([0,800]);
% % c3 = colorbar;
% % set(c3,'Position',c3_pos)
% % xlabel('$x$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % ylabel('$y$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % title('gDMD $T = 2000$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % caxis(lim);
% % hcb = colorbar
% % title(hcb,{'$u$'},'FontUnits','points','interpreter','latex',...
% %     'FontSize',8);
% % set(hcb,'Position',c3_pos)
% % 
% % % print(gcf,'soln1.png','-dpng','-r1500'); 
% % 
% % 
% % figure
% % width = 6.6;     % Width in inches
% % height = 2;    % Height in inches
% % set(gcf,'InvertHardcopy','on');
% % set(gcf,'PaperUnits', 'inches');
% % papersize = get(gcf, 'PaperSize');
% % left = (papersize(1)- width)/2;
% % bottom = (papersize(2)- height)/2;
% % myfiguresize = [left, bottom, width, height];
% % set(gcf,'PaperPosition', myfiguresize);
% % 
% % subplot('Position',pos1);
% % pdeplot(thermalmodel,'XYData',T(:,end),'ColorMap','jet')
% % xlim([0,800]);
% % ylim([0,800]);
% % xlabel('$x$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % ylabel('$y$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % title('Reference $T = 10000$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % lim = caxis;
% % hcb = colorbar;
% % title(hcb,{'$u$'},'FontUnits','points','interpreter','latex',...
% %     'FontSize',8);
% % set(hcb,'Position',c1_pos)
% % 
% % subplot('Position',pos2)
% % pdeplot(thermalmodel,'XYData',T_dmd(:,end),'ColorMap','jet')
% % xlim([0,800]);
% % ylim([0,800]);
% % xlabel('$x$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % ylabel('$y$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % title('DMD $T = 10000$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % caxis(lim);
% % hcb = colorbar;
% % title(hcb,{'$u$'},'FontUnits','points','interpreter','latex',...
% %     'FontSize',8);
% % set(hcb,'Position',c2_pos)
% % 
% % subplot('Position',pos3)
% % pdeplot(thermalmodel,'XYData',T_mdmd(:,end),'ColorMap','jet')
% % xlim([0,800]);
% % ylim([0,800]);
% % c3 = colorbar;
% % set(c3,'Position',c3_pos)
% % xlabel('$x$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % ylabel('$y$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % title('gDMD $T = 10000$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % caxis(lim);
% % hcb = colorbar;
% % title(hcb,{'$u$'},'FontUnits','points','interpreter','latex',...
% %     'FontSize',8);
% % set(hcb,'Position',c3_pos)
% % 
% % % print(gcf,'soln2.png','-dpng','-r1500'); 
% % 
% % figure
% % width = 3.3;     % Width in inches
% % height = 2;    % Height in inches
% % set(gcf,'InvertHardcopy','on');
% % set(gcf,'PaperUnits', 'inches');
% % papersize = get(gcf, 'PaperSize');
% % left = (papersize(1)- width)/2;
% % bottom = (papersize(2)- height)/2;
% % myfiguresize = [left, bottom, width, height];
% % set(gcf,'PaperPosition', myfiguresize);
% % plot(tlist, log10(sum((T-T_dmd).^2,1)./sum(T.^2,1)),'k-','LineWidth',1);
% % hold on;
% % plot(tlist, log10(sum((T-T_mdmd).^2,1)./sum(T.^2,1)),'r-.','LineWidth',1);
% % % set(gca,'YScale','log');
% % xlabel('$t$','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % ylabel('log relative error','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % title('Interpolation','FontUnits','points','interpreter','latex',...
% %     'FontSize',10);
% % legend({'DMD','gDMD'},'FontUnits','points','interpreter','latex',...
% %     'FontSize',10,'Location','Best');
% % legend('boxoff') 
% % ylim([-10,0])
% % % print(gcf,'error.png','-dpng','-r1500');  
% % 
% % 
% % 
% % 
% % 
% % 
