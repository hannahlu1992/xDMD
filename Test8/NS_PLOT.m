% clear all;
% load('data.mat');
% 
% dt = 0.0015;
% t = 7.5+dt:dt:15;
% t1 = 7.5+dt:dt:11.25;
% t2 = 11.25+dt:dt:15;
% 
% dx = 0.02;
% x = dx/2:dx:2-dx/2;
% dy = dx;
% y = dy/2:dy:1-dy/2;
% 
% pos1 = [0.08 0.2 0.34 0.7];
% pos2 = [0.56 0.2 0.34 0.7];
% c1_pos = [0.44 0.2 0.01 0.7];
% c2_pos = [0.92 0.2 0.01 0.7];
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
% imagesc(x,y,M1(:,:,1250));
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'reference $t = 9.375$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,M1(:,:,end));
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'reference $t = 11.25$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% % print(gcf,'ref1.png','-dpng','-r1500');  
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
% imagesc(x,y,M_dmd(:,:,1250));
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'DMD $t = 9.375$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,M_dmd(:,:,end));
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'DMD $t = 11.25$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% % print(gcf,'DMD1.png','-dpng','-r1500'); 
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
% imagesc(x,y,M_mdmd(:,:,1250));
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'xDMD $t = 9.375$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,M_mdmd(:,:,end));
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'xDMD $t = 11.25$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% % print(gcf,'xDMD1.png','-dpng','-r1500'); 
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
% imagesc(x,y,abs(M1(:,:,1250)-M_dmd(:,:,1250)));
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'DMD Error $t = 9.375$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,abs(M1(:,:,end)-M_dmd(:,:,end)));
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'DMD Error $t = 11.25$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% % print(gcf,'DMD_error1.png','-dpng','-r1500'); 
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
% imagesc(x,y,abs(M1(:,:,1250)-M_mdmd(:,:,1250)));
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'xDMD Error $t = 9.375$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,abs(M1(:,:,end)-M_mdmd(:,:,end)));
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'xDMD Error $t = 11.25$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% % print(gcf,'xDMD_error1.png','-dpng','-r1500'); 
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
% imagesc(x,y,M2(:,:,1250));
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'reference $t = 13.025$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,M2(:,:,end));
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'reference $t = 15$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% % print(gcf,'ref2.png','-dpng','-r1500');  
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
% imagesc(x,y,M_dmd_ex(:,:,1250));
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'DMD $t = 13.025$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,M_dmd_ex(:,:,end));
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'DMD $t = 15$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% % print(gcf,'DMD2.png','-dpng','-r1500'); 
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
% imagesc(x,y,M_mdmd_ex(:,:,1250));
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'xDMD $t = 13.025$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,M_mdmd_ex(:,:,end));
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'xDMD $t = 15$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% % print(gcf,'xDMD2.png','-dpng','-r1500'); 
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
% imagesc(x,y,abs(M2(:,:,1250)-M_dmd_ex(:,:,1250)));
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'DMD Error $t = 13.025$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,abs(M2(:,:,end)-M_dmd_ex(:,:,end)));
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'DMD Error $t = 15$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% % print(gcf,'DMD_error2.png','-dpng','-r1500'); 
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
% imagesc(x,y,abs(M2(:,:,1250)-M_mdmd_ex(:,:,1250)));
% colormap jet;
% colorbar
% c1 = colorbar;
% set(c1,'Position',c1_pos)
% title(c1,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'xDMD Error $t = 13.025$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% 
% subplot('Position',pos2)
% imagesc(x,y,abs(M2(:,:,end)-M_mdmd_ex(:,:,end)));
% colormap jet;
% colorbar
% c2 = colorbar;
% set(c2,'Position',c2_pos)
% title(c2,{'$U$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',8);
% xlabel('$x$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% ylabel('$y$','FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% title ({'xDMD Error $t = 15$'},'FontUnits','points','interpreter','latex',...
%     'FontSize',10);
% % print(gcf,'xDMD_error2.png','-dpng','-r1500'); 
% 

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

subplot(1,2,1)
X = reshape(M1,[50*100,2500]);
X_dmd = reshape(M_dmd,[50*100,2500]);
X_mdmd = reshape(M_mdmd,[50*100,2500]);
y1 = sum((X-X_dmd).^2,1)./sum(X.^2,1);
y3 = sum((X-X_mdmd).^2,1)./sum(X.^2,1);
hold on;
plot(t1,log10(y1),'k-','LineWidth',1);
plot(t1,log10(y3),'r-.','LineWidth',1);
legend({'DMD','xDMD'},'FontUnits','points','interpreter','latex',...
    'FontSize',10,'Location','Best');
legend boxoff

xlabel('$t$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('log relative error','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title({'Representation Error'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);
xlim([7.5 11.25])
ylim([-15,-5])

subplot(1,2,2)
X_ex = reshape(M2,[50*100,2500]);
X_dmd_ex = reshape(M_dmd_ex,[50*100,2500]);
X_mdmd_ex = reshape(M_mdmd_ex,[50*100,2500]);
y1 = sum((X_ex-X_dmd_ex).^2,1)./sum(X_ex.^2,1);
y3 = sum((X_ex-X_mdmd_ex).^2,1)./sum(X_ex.^2,1);
yyaxis left
hold on;
plot(t2,log10(y1),'k-','LineWidth',1);
plot(t2,log10(y3),'r-.','LineWidth',1);
xlim([11.25 15])
ylim([-10,-1])
yyaxis right
plot(t2,log10(sum(X_ex.^2,1)),'b--','LineWidth',1);
ylim([3.79,3.805])


legend({'DMD','xDMD','$\|U\|$'},'FontUnits','points','interpreter','latex',...
    'FontSize',10,'Location','Northwest');
legend boxoff

yyaxis left
xlabel('$t$','FontUnits','points','interpreter','latex',...
    'FontSize',10);
ylabel('log relative error','FontUnits','points','interpreter','latex',...
    'FontSize',10);
title({'Extrapolation Error'},'FontUnits','points','interpreter','latex',...
    'FontSize',10);


yyaxis right
ylabel('$\log(\|U\|)$','FontUnits','points','interpreter','latex',...
    'FontSize',10);


ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
print(gcf,'error_vs_time.png','-dpng','-r1500'); 
