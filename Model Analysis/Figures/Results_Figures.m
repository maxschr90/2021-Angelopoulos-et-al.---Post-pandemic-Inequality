%%  Figures 
%% This file generates figures 2-6 in the main text
 

clear
close all
clc

%%% Figure 1 

load ../Outputs/Path_cert_v1.mat
A=permute(GINI_K,[3,2,1]);A =[A(:,1),A];GINI_K_bestcase = A;
A=permute(GINI_H,[3,2,1]);A =[A(:,1),A];GINI_H_bestcase = A;
A=permute(Wagstaffindex_K,[3,2,1]);A =[A(:,1),A];Wagstaffindex_K_bestcase = A;
A=permute(Share_HTM,[3,2,1]);A =[A(:,1),A];Share_HTM_bestcase = A*100;
A=permute((Share_vulnerable_C(3,:,:)),[3,2,1]);A =[A(:,1),A];Share_vulnerable_C_bestcase = A*100;
A=permute(sum(Share_vulnerable_K),[3,2,1]);A =[A(:,1),A];Share_vulnerable_K_bestcase = A*100;

load ../Outputs/Path_Baseline_v1.mat
figure(1)
subplot(2,3,1)
A=permute(GINI_K,[3,2,1]);
A =[A(:,1),A];
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (GINI_K_bestcase),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([0.585 0.642]) 
yticks([0.58:0.01:0.64])  
xlim([1 23])
ylabel({'Gini wealth'},'FontSize',13,...
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
A =[A(:,1),A];
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (GINI_H_bestcase),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([0.098 0.106]) 
yticks([0.09:0.001:0.15])  
xlim([1 23])
ylabel({'Gini health'},'FontSize',13,...
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
A =[A(:,1),A];
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (Wagstaffindex_K_bestcase),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([0.23 0.265]) 
yticks([0.18:0.01:0.27]) 
xlim([1 23])
ylabel({'Wagstaff index'},'FontSize',13,...
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
A =[A(:,1),A]*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 
hold on
hd=plot(1:size(A',1),  (Share_HTM_bestcase),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([18.5 24]) 
yticks([18:1:26]) 
xlim([1 23])
ylabel({'% indebted households'},'FontSize',13,...
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


subplot(2,3,5)
A=permute(sum(Share_vulnerable_K),[3,2,1]);
A =[A(:,1),A]*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (Share_vulnerable_K_bestcase),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([31.5 36]) 
yticks([18:1:40]) 

xlim([1 23])
ylabel({'% low wealth households'},'FontSize',13,...
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
A =[A(:,1),A]*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~] = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (Share_vulnerable_C_bestcase),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([19.5 23.5]) 
yticks([18:1:40]) 

xlim([1 23])
ylabel({'% low consumption households'},'FontSize',13,...
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
exportgraphics(h,'Outputs/Fig_2.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_2.pdf','BackgroundColor','none')


%%% Figure 2
%%% Wealth, Ginis and indebetedness by socioeconomic group
%%% Begin Figure


load ../Outputs/Path_cert_v1.mat
A=permute(Mean_K_Class(1,:,:),[3,2,1]); A =[A(:,1),A]./A(:,1);Mean_K_Prof_oneoff_1 = A;
A=permute(Mean_K_Class(2,:,:),[3,2,1]);A =[A(:,1),A]./A(:,1);Mean_K_Inter_oneoff_1 = A;
A=permute(Mean_K_Class(3,:,:),[3,2,1]);A =[A(:,1),A]./A(:,1);Mean_K_Rout_oneoff_1 = A;
A=permute(Mean_K_Class(4,:,:),[3,2,1]);A =[A(:,1),A]./A(:,1);Mean_K_Inact_oneoff_1 = A;
A=permute(GINI_K_Class(1,:,:),[3,2,1]); A =[A(:,1),A];GINI_K_Prof_oneoff_1 = A;
A=permute(GINI_K_Class(2,:,:),[3,2,1]);A =[A(:,1),A];GINI_K_Inter_oneoff_1 = A;
A=permute(GINI_K_Class(3,:,:),[3,2,1]);A =[A(:,1),A];GINI_K_Rout_oneoff_1 = A;
A=permute(GINI_K_Class(4,:,:),[3,2,1]);A =[A(:,1),A];GINI_K_Inact_oneoff_1 = A;
A=permute(Share_HTM_Class(1,:,:),[3,2,1]); A =[A(:,1),A];Share_HTM_Prof_oneoff_1 = A*100;
A=permute(Share_HTM_Class(2,:,:),[3,2,1]);A =[A(:,1),A];Share_HTM_Inter_oneoff_1 = A*100;
A=permute(Share_HTM_Class(3,:,:),[3,2,1]);A =[A(:,1),A];Share_HTM_Rout_oneoff_1 = A*100;
A=permute(Share_HTM_Class(4,:,:),[3,2,1]);A =[A(:,1),A];Share_HTM_Inact_oneoff_1 = A*100;



%%% Begin Figure

load ../Outputs/Path_Baseline_v1.mat

figure(2)
%%%% WEALTH %%%%
subplot(3,4,1)
set(gca,'FontSize',8,'fontname','Helvetica','xticklabel',{[]})
A=permute(Mean_K_Class(1,:,:),[3,2,1]);
A =[A(:,1),A]./A(:,1);
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hold on
hd=plot(1:size(A',1),  (Mean_K_Prof_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 


hold off
ylim([0.975 1.30])
yticks([0.95 1 1.05 1.15 1.25])
xlim([1 23])
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
ylabel({'Wealth'},'FontSize',13,...
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
title({'Professionals'},'FontSize',13,...
       'FontWeight','bold')

subplot(3,4,2)
A=permute(Mean_K_Class(2,:,:),[3,2,1]);
A =[A(:,1),A]./A(:,1);
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hold on
hd=plot(1:size(A',1),  (Mean_K_Inter_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 


hold off
ylim([0.98 1.08])
yticks([0.91 0.94 0.97 1 1.03 1.06])
xlim([1 23])
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
title({'Intermediate'},'FontSize',13,...
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

subplot(3,4,3)
A=permute(Mean_K_Class(3,:,:),[3,2,1]);
A =[A(:,1),A]./A(:,1);
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hd=plot(1:size(A',1),  (Mean_K_Rout_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([0.88 1.09])
yticks([0.80 0.85 0.90 0.95 1 1.05])
xlim([1 23])
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
title({'Routine'},'FontSize',13,...
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

subplot(3,4,4)
A=permute(Mean_K_Class(4,:,:),[3,2,1]);
A =[A(:,1),A]./A(:,1);
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hold on

hd=plot(1:size(A',1),  (Mean_K_Inact_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([0.975 1.098])
yticks([0.975 1 1.025 1.05 1.075 1.1  1.15])
xlim([1 23])
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
title({'Non-employed'},'FontSize',13,...
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



%%% Indebted %%%%
subplot(3,4,9)
set(gca,'FontSize',8,'fontname','Helvetica','xticklabel',{[]})
A=permute(Share_HTM_Class(1,:,:),[3,2,1]);
A =[A(:,1),A]*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (Share_HTM_Prof_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([7.25 8.25])
yticks([7:0.25:9])
xlim([1 23])
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
ylabel({'% indebted households'},'FontSize',13,...
       'FontWeight','bold')
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';


subplot(3,4,10)
A=permute(Share_HTM_Class(2,:,:),[3,2,1]);
A =[A(:,1),A]*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (Share_HTM_Inter_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([13 22])
yticks([13:2:22])
xlim([1 23])
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

subplot(3,4,11)
A=permute(Share_HTM_Class(3,:,:),[3,2,1]);
A =[A(:,1),A]*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (Share_HTM_Rout_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([32 38])
yticks([31:1:38])
xlim([1 23])
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 

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

subplot(3,4,12)
A=permute(Share_HTM_Class(4,:,:),[3,2,1]);
A =[A(:,1),A]*100;
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (Share_HTM_Inact_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([39 41.2])
yticks([39:0.5:42])
xlim([1 23])
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


%%% GINI %%%%
subplot(3,4,5)
set(gca,'FontSize',8,'fontname','Helvetica','xticklabel',{[]})
A=permute(GINI_K_Class(1,:,:),[3,2,1]);
A =[A(:,1),A];
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (GINI_K_Prof_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([0.442 0.475])
yticks(0.442:0.005:0.475)
xlim([1 23])
xticks([3 8 13 18 23])
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
ylabel({'Gini wealth'},'FontSize',13,...
       'FontWeight','bold')
box on
grid on
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '-.';
ax.GridAlpha = 0.5;
%ax.Layer = 'top';


subplot(3,4,6)
A=permute(GINI_K_Class(2,:,:),[3,2,1]);
A =[A(:,1),A];
hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (GINI_K_Inter_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([0.53 0.6])
yticks(0.53:0.01:0.6)
xlim([1 23])
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

subplot(3,4,7)
A=permute(GINI_K_Class(3,:,:),[3,2,1]);
A =[A(:,1),A];

hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (GINI_K_Rout_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 


hold off
ylim([0.64 0.701])
yticks(0.64:0.01:0.701)
xlim([1 23])
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

subplot(3,4,8)
A=permute(GINI_K_Class(4,:,:),[3,2,1]);
A =[A(:,1),A];


hold on
[ha,~,~] = shadedplot(1:size(A',1), prctile(A,10), prctile(A,90), [0.9 0.9 0.9],[0.9 0.9 0.9]); 
hold on
[hb,~,~]  = shadedplot(1:size(A',1), prctile(A,25), prctile(A,75), [0.7 0.7 0.7],[0.7 0.7 0.7]); 
hold on
hc=plot(1:size(A',1), prctile(A,50),'linestyle', '-','color', '[0 0 0 ]','LineWidth',2); 
hold on
hold on
hd=plot(1:size(A',1),  (GINI_K_Inact_oneoff_1),'linestyle', '--','color', 'red','LineWidth',2); 

hold off
ylim([0.73 0.763])
yticks(0.73:0.005:0.763)
xlim([1 23])
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



set (figure(2), 'Units', 'normalized', 'Position', [0.10,0,0.80,0.6]);
h = figure(2);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_3.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_3.pdf','BackgroundColor','none')




load('../Outputs/Microsimulations_Data.mat')

figure(4)
subplot(2,2,1)
title('Wealth')
A = [Mean_K_pct - Mean_K_ss_pct]./Mean_K_ss_pct*100;
hold on
plot(A(5,:), '-*',  'LineWidth', 1.25)
plot(A(4,:), '-o',  'LineWidth', 1.25)
plot(A(3,:), '-+',  'LineWidth', 1.25)
plot(A(2,:), '-d',  'LineWidth', 1.25)
plot(A(1,:), '-p',  'LineWidth', 1.25)

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
leg = legend('90th pctile','75th pctile', '50th pctile', '25th pctile','10th pctile', 'Location', 'best');
% title(leg, 'Households starting from')
ylabel({'% deviations relative', 'to model without COVID-19'})

subplot(2,2,2)
title('Health')
A = [Mean_H_pct - Mean_H_ss_pct]./Mean_H_ss_pct*100;
hold on
plot(A(5,:), '-*',  'LineWidth', 1.25)
plot(A(4,:), '-o',  'LineWidth', 1.25)
plot(A(3,:), '-+',  'LineWidth', 1.25)
plot(A(2,:), '-d',  'LineWidth', 1.25)
plot(A(1,:), '-p',  'LineWidth', 1.25)

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 


subplot(2,2,3)
A = [Mean_K_grp - Mean_K_ss_grp]./Mean_K_ss_grp*100;
hold on
plot(A(1,:), '-.*',  'LineWidth', 1.25)
plot(A(2,:), '-.o',  'LineWidth', 1.25)
plot(A(3,:), '-.+',  'LineWidth', 1.25)
plot(A(4,:), '-.d',  'LineWidth', 1.25)

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
leg = legend('Professionals', 'Intermediate', 'Routine', 'Non-employed', 'Location', 'best')
% title(leg, 'Households starting from')
ylabel({'% deviations relative', 'to model without COVID-19'})

subplot(2,2,4)
A = [Mean_H_grp - Mean_H_ss_grp]./Mean_H_ss_grp*100;
hold on
plot(A(1,:), '-.*',  'LineWidth', 1.25)
plot(A(2,:), '-.o',  'LineWidth', 1.25)
plot(A(3,:), '-.+',  'LineWidth', 1.25)
plot(A(4,:), '-.d',  'LineWidth', 1.25)

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 


set (figure(4), 'Units', 'normalized', 'Position', [0.10,0,0.80,0.8]);
h = figure(4);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_4.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_4.pdf','BackgroundColor','none')


%%% Figure 5


figure(5)
subplot(1,2,1)
A = [Mean_K_uncert_pct - Mean_K_ss_pct]./Mean_K_ss_pct*100;
hold on
plot(A(5,:), '-*',  'LineWidth', 1.25)
plot(A(4,:), '-o',  'LineWidth', 1.25)
plot(A(3,:), '-+',  'LineWidth', 1.25)
plot(A(2,:), '-d',  'LineWidth', 1.25)
plot(A(1,:), '-p',  'LineWidth', 1.25)

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
leg = legend('90th pctile','75th pctile', '50th pctile', '25th pctile','10th pctile', 'Location', 'southeast');
% title(leg, 'Households starting from')
ylabel({'% deviations relative', 'to model without COVID-19'})



subplot(1,2,2)
A = [Mean_K_uncert_grp - Mean_K_ss_grp]./Mean_K_ss_grp*100;
hold on
plot(A(1,:), '-.*',  'LineWidth', 1.25)
plot(A(2,:), '-.o',  'LineWidth', 1.25)
plot(A(3,:), '-.+',  'LineWidth', 1.25)
plot(A(4,:), '-.d',  'LineWidth', 1.25)

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
leg = legend('Professionals', 'Intermediate', 'Routine', 'Non-employed', 'Location', 'best')
% title(leg, 'Households starting from')
ylabel({'% deviations relative', 'to model without COVID-19'})

set (figure(5), 'Units', 'normalized', 'Position', [0.10,0,0.80,0.8]);
h = figure(5);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_5.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_5.pdf','BackgroundColor','none')


%%% Figure 6
C_1_pct_path = (Mean_C_pct_surprise_1-Mean_C_pct)./Mean_C_pct*100;
C_1_grp_path = (Mean_C_grp_surprise_1-Mean_C_grp)./Mean_C_grp*100;
H_1_pct_path = (Mean_H_pct_surprise_1-Mean_H_pct)./Mean_H_pct*100;
H_1_grp_path = (Mean_H_grp_surprise_1-Mean_H_grp)./Mean_H_grp*100;
U_1_pct_path = (Mean_U_pct_surprise_1-Mean_U_pct)./Mean_U_pct*100;
U_1_grp_path = (Mean_U_grp_surprise_1-Mean_U_grp)./Mean_U_grp*100;

figure(6)
subplot(2,3,1)
title('Consumption')
hold on
plot(C_1_pct_path(5,:), '-*',  'LineWidth', 1.25)
plot(C_1_pct_path(4,:), '-o',  'LineWidth', 1.25)
plot(C_1_pct_path(3,:), '-+',  'LineWidth', 1.25)
plot(C_1_pct_path(2,:), '-d',  'LineWidth', 1.25)
plot(C_1_pct_path(1,:), '-p',  'LineWidth', 1.25)

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
% title(leg, 'Households starting from')
ylabel({'% deviations due', 'to surprise shock'})

subplot(2,3,2)
title('Health')
hold on
plot(H_1_pct_path(5,:), '-*',  'LineWidth', 1.25)
plot(H_1_pct_path(4,:), '-o',  'LineWidth', 1.25)
plot(H_1_pct_path(3,:), '-+',  'LineWidth', 1.25)
plot(H_1_pct_path(2,:), '-d',  'LineWidth', 1.25)
plot(H_1_pct_path(1,:), '-p',  'LineWidth', 1.25)

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 

subplot(2,3,3)
title('Utility')
hold on
plot(U_1_pct_path(5,:), '-*',  'LineWidth', 1.25)
plot(U_1_pct_path(4,:), '-o',  'LineWidth', 1.25)
plot(U_1_pct_path(3,:), '-+',  'LineWidth', 1.25)
plot(U_1_pct_path(2,:), '-d',  'LineWidth', 1.25)
plot(U_1_pct_path(1,:), '-p',  'LineWidth', 1.25)
leg = legend('90th pctile','75th pctile', '50th pctile', '25th pctile','10th pctile', 'Location', 'southeast');

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 


subplot(2,3,4)
hold on
plot(C_1_grp_path(1,:), '-.*',  'LineWidth', 1.25)
plot(C_1_grp_path(2,:), '-.o',  'LineWidth', 1.25)
plot(C_1_grp_path(3,:), '-.+',  'LineWidth', 1.25)
plot(C_1_grp_path(4,:), '-.d',  'LineWidth', 1.25)

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 
% title(leg, 'Households starting from')
ylabel({'% deviations due', 'to surprise shock'})

subplot(2,3,5)
hold on
plot(H_1_grp_path(1,:), '-.*',  'LineWidth', 1.25)
plot(H_1_grp_path(2,:), '-.o',  'LineWidth', 1.25)
plot(H_1_grp_path(3,:), '-.+',  'LineWidth', 1.25)
plot(H_1_grp_path(4,:), '-.d',  'LineWidth', 1.25)

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 

subplot(2,3,6)
hold on
plot(U_1_grp_path(1,:), '-.*',  'LineWidth', 1.25)
plot(U_1_grp_path(2,:), '-.o',  'LineWidth', 1.25)
plot(U_1_grp_path(3,:), '-.+',  'LineWidth', 1.25)
plot(U_1_grp_path(4,:), '-.d',  'LineWidth', 1.25)
leg = legend('Professionals', 'Intermediate', 'Routine', 'Non-employed', 'Location', 'southeast')

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 

set (figure(6), 'Units', 'normalized', 'Position', [0.10,0,0.80,0.8]);
h = figure(6);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_6.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_6.pdf','BackgroundColor','none')