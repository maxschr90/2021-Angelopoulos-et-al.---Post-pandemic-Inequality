
clear
clc
close all

Health_Impact_Income=table2array(readtable('../../Data Preparation & Analysis/Outputs/HealthIncomeHistogramm.xlsx', 'Sheet','Full Sample'));
Health_Impact_Income =flip([Health_Impact_Income]);
Health_Impact_Income_Subsample=table2array(readtable('../../Data Preparation & Analysis/Outputs/HealthIncomeHistogramm.xlsx', 'Sheet','Negative Transition'));
Health_Impact_Income_Subsample =flip([Health_Impact_Income_Subsample]);

% figure(1)
% subplot(1,2,1)
% errorbar(Health_Impact_Income(:,1),Health_Impact_Income(:,2),'*', 'MarkerSize',5, 'Color', 'black')
% xlim([0.5,10.5])
% xticks(1:10)
% xticklabels((1:10))
% xlabel('Decile of % change in health','FontSize',12,'FontWeight','bold')
% ylabel('% change in household net income','FontSize',12,'FontWeight','bold')
% title('Full Sample')
% subplot(1,2,2)
% errorbar(Health_Impact_Income_Subsample(:,1),Health_Impact_Income_Subsample(:,2),'*', 'MarkerSize',5, 'Color', 'black')
% xlim([0.5,10.5])
% xticks(1:10)
% xticklabels((1:10))
% xlabel('Decile of % change in health','FontSize',12,'FontWeight','bold')
% title('Negative Social Class Transition')

figure(1)
errorbar(Health_Impact_Income(:,1),Health_Impact_Income(:,2),'*', 'MarkerSize',7.5, 'Color', 'black')
hold on 
errorbar(Health_Impact_Income_Subsample(:,1),Health_Impact_Income_Subsample(:,2),'o', 'MarkerSize',7.5, 'Color', 'black')
legend('Full Sample','Negative Socioeconomic Transition')
xlim([0.5,10.5])
xticks(1:10)
xticklabels((1:10))
xlabel('Decile of % change in health','FontSize',12,'FontWeight','bold')
ylabel('% change in household net income','FontSize',12,'FontWeight','bold')


set (figure(1), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'..\Outputs\Fig_1_temp.png','BackgroundColor','none')