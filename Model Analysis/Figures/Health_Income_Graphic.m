
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

figure(1)
errorbar(Health_Impact_Income_Decile(:,1),Health_Impact_Income_Decile(:,2),'*', 'MarkerSize',7.5, 'Color', 'black')
% legend('Full Sample')
xlim([0.5,10.5])
xticks(1:10)
xticklabels(Health_Impact_Income_Decile_dh(:,1)')
xlabel('Decile of % change in health','FontSize',12,'FontWeight','bold')
ylabel('% change in household net income','FontSize',12,'FontWeight','bold')


set (figure(1), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'..\Outputs\Fig_1_temp.png','BackgroundColor','none')


figure(2)
errorbar(Health_Impact_Income_Pctile(:,1),Health_Impact_Income_Pctile(:,2),'-*', 'MarkerSize',7.5, 'Color', 'black')
xlim([0.5,100.5])
xticks(1:100)
xticklabels((Health_Impact_Income_Pctile_dh(:,1)'))
xlabel('Percentiles of % change in health','FontSize',12,'FontWeight','bold')
ylabel('% change in household net income','FontSize',12,'FontWeight','bold')


set (figure(2), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(2);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'..\Outputs\Fig_1_temp2.png','BackgroundColor','none')


figure(3)
errorbar(Health_Impact_Income_Quintile(:,1),Health_Impact_Income_Quintile(:,2),'-*', 'MarkerSize',7.5, 'Color', 'black')
xlim([0.5,20.5])
xticks(1:20)
xticklabels((Health_Impact_Income_Quintile_dh(:,1)'))
xlabel('Percentiles of % change in health','FontSize',12,'FontWeight','bold')
ylabel('% change in household net income','FontSize',12,'FontWeight','bold')


set (figure(3), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(3);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'..\Outputs\Fig_1_temp2.png','BackgroundColor','none')
