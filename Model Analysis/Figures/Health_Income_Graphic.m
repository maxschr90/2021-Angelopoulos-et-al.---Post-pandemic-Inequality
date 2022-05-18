
clear
clc
close all

Health_Impact_Income_Decile=table2array(readtable('../../Data Preparation & Analysis/Outputs/HealthIncomeHistogramm.xlsx', 'Sheet','Deciles'));
Health_Impact_Income_Decile =flip([Health_Impact_Income_Decile]);
Health_Impact_Income_Pctile=table2array(readtable('../../Data Preparation & Analysis/Outputs/HealthIncomeHistogramm.xlsx', 'Sheet','Percentiles'));
Health_Impact_Income_Pctile =flip([Health_Impact_Income_Pctile]);
Health_Impact_Income_Pctile_dh=table2array(readtable('../../Data Preparation & Analysis/Outputs/HealthIncomeHistogramm.xlsx', 'Sheet','Percentiles XAxis'));
Health_Impact_Income_Pctile_dh =flip([Health_Impact_Income_Pctile_dh]);
Health_Impact_Income_Decile_dh=table2array(readtable('../../Data Preparation & Analysis/Outputs/HealthIncomeHistogramm.xlsx', 'Sheet','Deciles XAxis'));
Health_Impact_Income_Decile_dh =flip([Health_Impact_Income_Decile_dh]);
Health_Impact_Income_Quintile=table2array(readtable('../../Data Preparation & Analysis/Outputs/HealthIncomeHistogramm.xlsx', 'Sheet','Quintiles'));
Health_Impact_Income_Quintile =flip([Health_Impact_Income_Quintile]);
Health_Impact_Income_Quintile_dh=table2array(readtable('../../Data Preparation & Analysis/Outputs/HealthIncomeHistogramm.xlsx', 'Sheet','Quintiles XAxis'));
Health_Impact_Income_Quintile_dh =flip([Health_Impact_Income_Quintile_dh]);

AA=[Health_Impact_Income_Decile_dh(:,1) Health_Impact_Income_Decile(:,1:2)];
AA=sortrows(AA,1)

figure(1)
hold on
line([0 10],[0 0],'LineWidth',2,'LineStyle','--','Color', 'Red')
hold on
errorbar(1:10,AA(:,2),AA(:,3),'-s', 'MarkerSize',8, 'Color', 'black','MarkerFaceColor','black')
hold off
% legend('Full Sample')
xlim([0.5,10.5])
xticks(1:10)
xticklabels(AA(:,1))
xlabel('Decile of % change in health','FontSize',12,'FontWeight','bold')
ylabel('% change in household net income','FontSize',12,'FontWeight','bold')


set (figure(1), 'Units', 'normalized', 'Position', [0.01,0,0.8,0.6]);
h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'..\Outputs\Fig_1_temp.emf','BackgroundColor','none')
exportgraphics(h,'..\Outputs\Fig_1_temp.pdf','BackgroundColor','none')

BB=[Health_Impact_Income_Pctile_dh(:,1) Health_Impact_Income_Pctile(:,1:2)];
BB=sortrows(BB,1)

figure(2)
hold on
line([0 100],[0 0],'LineWidth',2,'LineStyle','--','Color', 'Red')
hold on
errorbar([1:1:100],BB(:,2),BB(:,3),'-s', 'MarkerSize',8, 'Color', 'black','MarkerFaceColor','black')
hold off
xlim([0.5,100.5])
xticks(5:10:100)
%xticklabels((BB(:,1)))
xticklabels({BB(5,1),BB(15,1),BB(25,1),BB(35,1),BB(45,1),BB(55,1),BB(65,1),BB(75,1),BB(85,1),BB(95,1)})
%xticklabels([1 10 20 30 40 50 60 70 80 90 100])
xlabel('Percentiles of % change in health','FontSize',12,'FontWeight','bold')
ylabel('% change in household net income','FontSize',12,'FontWeight','bold')


set (figure(2), 'Units', 'normalized', 'Position', [0.01,0,0.8,0.6]);
h = figure(2);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'..\Outputs\Fig_1_temp2.emf','BackgroundColor','none')
exportgraphics(h,'..\Outputs\Fig_1_temp2.pdf','BackgroundColor','none')


CC=[Health_Impact_Income_Quintile_dh(:,1) Health_Impact_Income_Quintile(:,1:2)];
CC=sortrows(CC,1)

figure(3)
hold on
line([0 20],[0 0],'LineWidth',2,'LineStyle','--','Color', 'Red')
hold on
errorbar([1:1:20],CC(:,2),CC(:,3),'-s', 'MarkerSize',8, 'Color', 'black','MarkerFaceColor','black')
hold off
xlim([0.5,20.5])
xticks(2:2:20)
%xticklabels((BB(:,1)))
xticklabels({CC(2,1),CC(4,1),CC(6,1),CC(8,1),CC(10,1),CC(12,1),CC(14,1),CC(16,1),CC(18,1),CC(20,1)})
%xticklabels([1 10 20 30 40 50 60 70 80 90 100])
xlabel('20-quantiles of % change in health','FontSize',12,'FontWeight','bold')
ylabel('% change in household net income','FontSize',12,'FontWeight','bold')


set (figure(3), 'Units', 'normalized', 'Position', [0.01,0,0.8,0.6]);
h = figure(3);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'..\Outputs\Fig_1_temp3.emf','BackgroundColor','none')
exportgraphics(h,'..\Outputs\Fig_1_temp3.pdf','BackgroundColor','none')




