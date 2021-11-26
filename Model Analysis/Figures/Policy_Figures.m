%% Policy Figures
%% This code creates all policy figures (Figure 7 in the main text and figures E3-E6 in the appendix)

clear
clc
close all

load ../Outputs/Path_Baseline_v1.mat
A=permute(GINI_K,[3,2,1]);A =[A(:,1),A];GINI_K_baseline = A;
A=permute(GINI_H,[3,2,1]);A =[A(:,1),A];GINI_H_baseline = A;
A=permute(Wagstaffindex_K,[3,2,1]);A =[A(:,1),A];Wagstaffindex_K_baseline = A;
A=permute(Share_HTM,[3,2,1]);A =[A(:,1),A];Share_HTM_baseline = A*100;
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);A =[A(:,1),A];Share_vulnerable_C_baseline = A*100;
A=permute(sum(Share_vulnerable_K),[3,2,1]);A =[A(:,1),A];Share_vulnerable_K_baseline = A*100;

load('../Outputs/Path_Policy_1_v1.mat')

figure(1)
subplot(2,3,1)
A=permute(GINI_K,[3,2,1]);
A =([A(:,1),A]-GINI_K_baseline)./GINI_K_baseline*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([0.585 0.642]) 
%yticks([0.58:0.01:0.64])  
xlim([1 23])
ylabel({'% change in','Gini wealth'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

subplot(2,3,2)
A=permute(GINI_H,[3,2,1]);
A =([A(:,1),A]-GINI_H_baseline)./GINI_H_baseline*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([0.585 0.642]) 
%yticks([0.58:0.01:0.64])  
xlim([1 23])
ylabel({'% change in','Gini health'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

subplot(2,3,3)
A=permute(Wagstaffindex_K,[3,2,1]);
A =([A(:,1),A]-Wagstaffindex_K_baseline)./Wagstaffindex_K_baseline*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 

hold off
%ylim([0.23 0.265]) 
%yticks([0.18:0.01:0.27]) 
xlim([1 23])
ylabel({'% change in','Wagstaff index'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

   
 
subplot(2,3,4)
A=permute(Share_HTM,[3,2,1]);
A =([A(:,1),A]*100-Share_HTM_baseline)./Share_HTM_baseline*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 

hold off
%ylim([18.5 24]) 
%yticks([18:1:26]) 
xlim([1 23])
ylabel({'% change in share of', 'indebted households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';
% legend([hc,  ha(2), hb(2),  hd(1)],'Median outcome (outbreak unc.)',  'p10-p90 (outbreak unc.)', 'p25-p75 (outbreak unc.)', 'One-off pandemic', 'Location', 'best','FontSize',11)


subplot(2,3,5)
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_K_baseline)./Share_vulnerable_K_baseline*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([19.5 23.5]) 
%yticks([18:1:40]) 

xlim([1 23])
ylabel({'% change in share of', 'low wealth households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
 
subplot(2,3,6)
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_C_baseline)./Share_vulnerable_C_baseline*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([19.5 23.5]) 
%yticks([18:1:40]) 

xlim([1 23])
ylabel({'% change in share of', 'low consumption households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;

set (figure(1), 'Units', 'normalized', 'Position', [0.10,0,0.80,0.8]);
h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_7.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_7.pdf','BackgroundColor','none')



figure(2)
subplot(2,3,1)

load('../Outputs/Path_Policy_1_v1.mat')
A=permute(GINI_K,[3,2,1]);
A =([A(:,1),A]-GINI_K_baseline)./GINI_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_2_v1.mat')
A=permute(GINI_K,[3,2,1]);
A =([A(:,1),A]-GINI_K_baseline)./GINI_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

hold off
%ylim([0.585 0.642]) 
%yticks([0.58:0.01:0.64])  
xlim([1 23])
ylabel({'% change in','Gini wealth'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

subplot(2,3,2)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(GINI_H,[3,2,1]);
A =([A(:,1),A]-GINI_H_baseline)./GINI_H_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_2_v1.mat')
A=permute(GINI_H,[3,2,1]);
A =([A(:,1),A]-GINI_H_baseline)./GINI_H_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([0.585 0.642]) 
%yticks([0.58:0.01:0.64])  
xlim([1 23])
ylabel({'% change in','Gini health'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

subplot(2,3,3)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(Wagstaffindex_K,[3,2,1]);
A =([A(:,1),A]-Wagstaffindex_K_baseline)./Wagstaffindex_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_2_v1.mat')
A=permute(Wagstaffindex_K,[3,2,1]);
A =([A(:,1),A]-Wagstaffindex_K_baseline)./Wagstaffindex_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

hold off
%ylim([0.23 0.265]) 
%yticks([0.18:0.01:0.27]) 
xlim([1 23])
ylabel({'% change in','Wagstaff index'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

   
 
subplot(2,3,4)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(Share_HTM,[3,2,1]);
A =([A(:,1),A]*100-Share_HTM_baseline)./Share_HTM_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 
load('../Outputs/Path_Policy_2_v1.mat')
A=permute(Share_HTM,[3,2,1]);
A =([A(:,1),A]*100-Share_HTM_baseline)./Share_HTM_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

hold off
%ylim([18.5 24]) 
%yticks([18:1:26]) 
xlim([1 23])
ylabel({'% change in share of', 'indebted households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';
% legend([hc,  ha(2), hb(2),  hd(1)],'Median outcome (outbreak unc.)',  'p10-p90 (outbreak unc.)', 'p25-p75 (outbreak unc.)', 'One-off pandemic', 'Location', 'best','FontSize',11)


subplot(2,3,5)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_K_baseline)./Share_vulnerable_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 
load('../Outputs/Path_Policy_2_v1.mat')
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_K_baseline)./Share_vulnerable_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([19.5 23.5]) 
%yticks([18:1:40]) 

xlim([1 23])
ylabel({'% change in share of', 'low wealth households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
 
subplot(2,3,6)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_C_baseline)./Share_vulnerable_C_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 
load('../Outputs/Path_Policy_2_v1.mat')
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_C_baseline)./Share_vulnerable_C_baseline*100;
hold on
hd=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([19.5 23.5]) 
%yticks([18:1:40]) 

xlim([1 23])
ylabel({'% change in share of', 'low consumption households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
leg = legend([hd, hc], {'basic', 'extended'}, 'Location','southeast');
title(leg,'Coverage')
set (figure(2), 'Units', 'normalized', 'Position', [0.10,0,0.80,0.8]);
h = figure(2);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_App_E_3.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_App_E_3.pdf','BackgroundColor','none')



figure(3)
subplot(2,3,1)

load('../Outputs/Path_Policy_1_v1.mat')
A=permute(GINI_K,[3,2,1]);
A =([A(:,1),A]-GINI_K_baseline)./GINI_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_2_v1.mat')
A=permute(GINI_K,[3,2,1]);
A =([A(:,1),A]-GINI_K_baseline)./GINI_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

hold off
%ylim([0.585 0.642]) 
%yticks([0.58:0.01:0.64])  
xlim([1 23])
ylabel({'cost adjusted % change in','Gini wealth'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

subplot(2,3,2)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(GINI_H,[3,2,1]);
A =([A(:,1),A]-GINI_H_baseline)./GINI_H_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_2_v1.mat')
A=permute(GINI_H,[3,2,1]);
A =([A(:,1),A]-GINI_H_baseline)./GINI_H_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([0.585 0.642]) 
%yticks([0.58:0.01:0.64])  
xlim([1 23])
ylabel({'cost adjusted % change in','Gini health'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

subplot(2,3,3)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(Wagstaffindex_K,[3,2,1]);
A =([A(:,1),A]-Wagstaffindex_K_baseline)./Wagstaffindex_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_2_v1.mat')
A=permute(Wagstaffindex_K,[3,2,1]);
A =([A(:,1),A]-Wagstaffindex_K_baseline)./Wagstaffindex_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

hold off
%ylim([0.23 0.265]) 
%yticks([0.18:0.01:0.27]) 
xlim([1 23])
ylabel({'cost adjusted % change in','Wagstaff index'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

   
 
subplot(2,3,4)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(Share_HTM,[3,2,1]);
A =([A(:,1),A]*100-Share_HTM_baseline)./Share_HTM_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 
load('../Outputs/Path_Policy_2_v1.mat')
A=permute(Share_HTM,[3,2,1]);
A =([A(:,1),A]*100-Share_HTM_baseline)./Share_HTM_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

hold off
%ylim([18.5 24]) 
%yticks([18:1:26]) 
xlim([1 23])
ylabel({'cost adjusted % change in share of', 'indebted households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';
% legend([hc,  ha(2), hb(2),  hd(1)],'Median outcome (outbreak unc.)',  'p10-p90 (outbreak unc.)', 'p25-p75 (outbreak unc.)', 'One-off pandemic', 'Location', 'best','FontSize',11)


subplot(2,3,5)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_K_baseline)./Share_vulnerable_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 
load('../Outputs/Path_Policy_2_v1.mat')
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_K_baseline)./Share_vulnerable_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([19.5 23.5]) 
%yticks([18:1:40]) 

xlim([1 23])
ylabel({'cost adjusted % change in share of', 'low wealth households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
 
subplot(2,3,6)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_C_baseline)./Share_vulnerable_C_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 
load('../Outputs/Path_Policy_2_v1.mat')
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_C_baseline)./Share_vulnerable_C_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hd=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([19.5 23.5]) 
%yticks([18:1:40]) 

xlim([1 23])
ylabel({'cost adjusted % change in share of', 'low consumption households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
leg = legend([hd, hc], {'basic', 'extended'}, 'Location','southeast');
title(leg,'Coverage')
set (figure(3), 'Units', 'normalized', 'Position', [0.10,0,0.80,0.8]);
h = figure(3);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_App_E_4.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_App_E_4.pdf','BackgroundColor','none')


figure(4)
subplot(2,3,1)

load('../Outputs/Path_Policy_1_v1.mat')
A=permute(GINI_K,[3,2,1]);
A =([A(:,1),A]-GINI_K_baseline)./GINI_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v2.mat')
A=permute(GINI_K,[3,2,1]);
A =([A(:,1),A]-GINI_K_baseline)./GINI_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute(GINI_K,[3,2,1]);
A =([A(:,1),A]-GINI_K_baseline)./GINI_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([0.585 0.642]) 
%yticks([0.58:0.01:0.64])  
xlim([1 23])
ylabel({'% change in','Gini wealth'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

subplot(2,3,2)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(GINI_H,[3,2,1]);
A =([A(:,1),A]-GINI_H_baseline)./GINI_H_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v2.mat')
A=permute(GINI_H,[3,2,1]);
A =([A(:,1),A]-GINI_H_baseline)./GINI_H_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute(GINI_H,[3,2,1]);
A =([A(:,1),A]-GINI_H_baseline)./GINI_H_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 



hold off
%ylim([0.585 0.642]) 
%yticks([0.58:0.01:0.64])  
xlim([1 23])
ylabel({'% change in','Gini health'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

subplot(2,3,3)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(Wagstaffindex_K,[3,2,1]);
A =([A(:,1),A]-Wagstaffindex_K_baseline)./Wagstaffindex_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v2.mat')
A=permute(Wagstaffindex_K,[3,2,1]);
A =([A(:,1),A]-Wagstaffindex_K_baseline)./Wagstaffindex_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute(Wagstaffindex_K,[3,2,1]);
A =([A(:,1),A]-Wagstaffindex_K_baseline)./Wagstaffindex_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([0.23 0.265]) 
%yticks([0.18:0.01:0.27]) 
xlim([1 23])
ylabel({'% change in','Wagstaff index'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

   
 
subplot(2,3,4)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(Share_HTM,[3,2,1]);
A =([A(:,1),A]*100-Share_HTM_baseline)./Share_HTM_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 
load('../Outputs/Path_Policy_1_v2.mat')
A=permute(Share_HTM,[3,2,1]);
A =([A(:,1),A]*100-Share_HTM_baseline)./Share_HTM_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute(Share_HTM,[3,2,1]);
A =([A(:,1),A]*100-Share_HTM_baseline)./Share_HTM_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 

hold off
%ylim([18.5 24]) 
%yticks([18:1:26]) 
xlim([1 23])
ylabel({'% change in share of', 'indebted households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';
% legend([hc,  ha(2), hb(2),  hd(1)],'Median outcome (outbreak unc.)',  'p10-p90 (outbreak unc.)', 'p25-p75 (outbreak unc.)', 'One-off pandemic', 'Location', 'best','FontSize',11)


subplot(2,3,5)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_K_baseline)./Share_vulnerable_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v2.mat')
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_K_baseline)./Share_vulnerable_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_K_baseline)./Share_vulnerable_K_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([19.5 23.5]) 
%yticks([18:1:40]) 

xlim([1 23])
ylabel({'% change in share of', 'low wealth households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
 
subplot(2,3,6)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_C_baseline)./Share_vulnerable_C_baseline*100;
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 
load('../Outputs/Path_Policy_1_v2.mat')
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_C_baseline)./Share_vulnerable_C_baseline*100;
hold on
hd=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_C_baseline)./Share_vulnerable_C_baseline*100;
hold on
he=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([19.5 23.5]) 
%yticks([18:1:40]) 

xlim([1 23])
ylabel({'% change in share of', 'low consumption households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
leg = legend([he,hd, hc], {'30 %', '50 %', '80 %'}, 'Location','southeast');
title(leg,'Replacement')
set (figure(4), 'Units', 'normalized', 'Position', [0.10,0,0.80,0.8]);
h = figure(4);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_App_E_5.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_App_E_5.pdf','BackgroundColor','none')



figure(5)
subplot(2,3,1)

load('../Outputs/Path_Policy_1_v1.mat')
A=permute(GINI_K,[3,2,1]);
A =([A(:,1),A]-GINI_K_baseline)./GINI_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v2.mat')
A=permute(GINI_K,[3,2,1]);
A =([A(:,1),A]-GINI_K_baseline)./GINI_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute(GINI_K,[3,2,1]);
A =([A(:,1),A]-GINI_K_baseline)./GINI_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([0.585 0.642]) 
%yticks([0.58:0.01:0.64])  
xlim([1 23])
ylabel({'cost adjusted % change in','Gini wealth'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

subplot(2,3,2)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(GINI_H,[3,2,1]);
A =([A(:,1),A]-GINI_H_baseline)./GINI_H_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v2.mat')
A=permute(GINI_H,[3,2,1]);
A =([A(:,1),A]-GINI_H_baseline)./GINI_H_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute(GINI_H,[3,2,1]);
A =([A(:,1),A]-GINI_H_baseline)./GINI_H_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 



hold off
%ylim([0.585 0.642]) 
%yticks([0.58:0.01:0.64])  
xlim([1 23])
ylabel({'cost adjusted % change in','Gini health'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

subplot(2,3,3)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(Wagstaffindex_K,[3,2,1]);
A =([A(:,1),A]-Wagstaffindex_K_baseline)./Wagstaffindex_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v2.mat')
A=permute(Wagstaffindex_K,[3,2,1]);
A =([A(:,1),A]-Wagstaffindex_K_baseline)./Wagstaffindex_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute(Wagstaffindex_K,[3,2,1]);
A =([A(:,1),A]-Wagstaffindex_K_baseline)./Wagstaffindex_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([0.23 0.265]) 
%yticks([0.18:0.01:0.27]) 
xlim([1 23])
ylabel({'cost adjusted % change in','Wagstaff index'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';

   
 
subplot(2,3,4)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(Share_HTM,[3,2,1]);
A =([A(:,1),A]*100-Share_HTM_baseline)./Share_HTM_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 
load('../Outputs/Path_Policy_1_v2.mat')
A=permute(Share_HTM,[3,2,1]);
A =([A(:,1),A]*100-Share_HTM_baseline)./Share_HTM_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute(Share_HTM,[3,2,1]);
A =([A(:,1),A]*100-Share_HTM_baseline)./Share_HTM_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 

hold off
%ylim([18.5 24]) 
%yticks([18:1:26]) 
xlim([1 23])
ylabel({'cost adjusted % change in share of', 'indebted households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';
% legend([hc,  ha(2), hb(2),  hd(1)],'Median outcome (outbreak unc.)',  'p10-p90 (outbreak unc.)', 'p25-p75 (outbreak unc.)', 'One-off pandemic', 'Location', 'best','FontSize',11)


subplot(2,3,5)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_K_baseline)./Share_vulnerable_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v2.mat')
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_K_baseline)./Share_vulnerable_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_K_baseline)./Share_vulnerable_K_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([19.5 23.5]) 
%yticks([18:1:40]) 

xlim([1 23])
ylabel({'cost adjusted % change in share of', 'low wealth households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
 
subplot(2,3,6)
load('../Outputs/Path_Policy_1_v1.mat')
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_C_baseline)./Share_vulnerable_C_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hc=plot(1:size(A',1), mean(A),'-o','linestyle', '-.','color', '[0 0 0]','LineWidth',2); 
load('../Outputs/Path_Policy_1_v2.mat')
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_C_baseline)./Share_vulnerable_C_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
hd=plot(1:size(A',1), mean(A),'-d','linestyle', '--','color', '[0 0 0]','LineWidth',2); 

load('../Outputs/Path_Policy_1_v3.mat')
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);
A =([A(:,1),A]*100-Share_vulnerable_C_baseline)./Share_vulnerable_C_baseline*100./mean(mean(permute(Total_Cost(:,4:23,:),[3,2,1]),2));
hold on
he=plot(1:size(A',1), mean(A),'-+','linestyle', ':','color', '[0 0 0]','LineWidth',2); 


hold off
%ylim([19.5 23.5]) 
%yticks([18:1:40]) 

xlim([1 23])
ylabel({'cost adjusted % change in share of', 'low consumption households'},'FontSize',13,...
       'FontWeight','bold')
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
leg = legend([he,hd, hc], {'30 %', '50 %', '80 %'}, 'Location','southeast');
title(leg,'Replacement')
set (figure(5), 'Units', 'normalized', 'Position', [0.10,0,0.80,0.8]);
h = figure(5);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_App_E_6.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_App_E_6.pdf','BackgroundColor','none')





