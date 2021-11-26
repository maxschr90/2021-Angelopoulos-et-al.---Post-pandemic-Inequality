%% Appendix Figures 
%% This file generates figures D3, E1 & E2 in the appendix

Healthshockgraphics

clear
close all
clc

load ../Outputs/Path_Baseline_v1.mat

for i=1:9
    Y_decile(i) = wprctile(Y(:,1),10*i, ALPHA,8);
end
D = ones(90000,1);
for i=1:9
    D =D+(Y(:,1)> Y_decile(i));
end

Y(:,1) = [wages(4,exostates)'+aa*(1+0.0056)+(aa<0).*aa*0.01];
Y(:,2) = [wages(1,exostates)'+aa+(aa<0).*aa*0.01];
Y(:,3) = [wages(2,exostates)'+aa*(1+0.0034)+(aa<0).*aa*0.01];
W(:,1) = [wages(4,exostates)'];
W(:,2) = [wages(1,exostates)'];
W(:,3) = [wages(2,exostates)'];


for i=1:10
   Res(i,:) = sum(Y((D==i),:).*ALPHA(D==i))./sum(ALPHA(D==i));
   Ear(i,:) = sum(W((D==i),:).*ALPHA(D==i))./sum(ALPHA(D==i));
end
Res = (Res./Res(:,1)-1)*100;
Ear = (Ear./Ear(:,1)-1)*100;

figure(1)
subplot(2,1,2)
bar(1:10,[Res(:,2)';Res(:,3)'])
ylabel('% change total resources','FontSize',18,'FontWeight','bold')
xlabel('Deciles of the pre-Covid-19 income distribution','FontSize',18,'FontWeight','bold')
subplot(2,1,1)
bar(1:10,[Ear(:,2)';Ear(:,3)'])
ylabel('% change post policy labour income','FontSize',18,'FontWeight','bold')
legend('Change during pandemic', 'Change during recurrent outbreak', 'Location', 'best','FontSize',18)


set (figure(1), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_App_D_3.eps','BackgroundColor','none')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% find quantiles
Y = [wages(4,exostates)'+aa*0.0056+(aa<0).*aa*0.01];
for i=1:4
    Y_quantiles(i) = wprctile(Y(:,1),20*i, ALPHA,8);
end
CC =c_choice(:,:,1);
CC =CC(:);

C_Quintile(1,:) = [C(Y<=Y_quantiles(1))'*ALPHA(Y<=Y_quantiles(1));CC(Y<=Y_quantiles(1))'*ALPHA(Y<=Y_quantiles(1))]./sum(ALPHA(Y<=Y_quantiles(1)));
C_Quintile(2,:) = [C(Y>Y_quantiles(1)&Y<=Y_quantiles(2))'*ALPHA(Y>Y_quantiles(1)&Y<=Y_quantiles(2));CC(Y>Y_quantiles(1)&Y<=Y_quantiles(2))'*ALPHA(Y>Y_quantiles(1)&Y<=Y_quantiles(2))]./sum(ALPHA(Y>Y_quantiles(1)&Y<=Y_quantiles(2)));
C_Quintile(3,:) = [C(Y>Y_quantiles(2)&Y<=Y_quantiles(3))'*ALPHA(Y>Y_quantiles(2)&Y<=Y_quantiles(3));CC(Y>Y_quantiles(2)&Y<=Y_quantiles(3))'*ALPHA(Y>Y_quantiles(2)&Y<=Y_quantiles(3))]./sum(ALPHA(Y>Y_quantiles(2)&Y<=Y_quantiles(3)));
C_Quintile(4,:) = [C(Y>Y_quantiles(3)&Y<=Y_quantiles(4))'*ALPHA(Y>Y_quantiles(3)&Y<=Y_quantiles(4));CC(Y>Y_quantiles(3)&Y<=Y_quantiles(4))'*ALPHA(Y>Y_quantiles(3)&Y<=Y_quantiles(4))]./sum(ALPHA(Y>Y_quantiles(3)&Y<=Y_quantiles(4)));
C_Quintile(5,:) = [C(Y>Y_quantiles(4))'*ALPHA(Y>Y_quantiles(4));CC(Y>Y_quantiles(4))'*ALPHA(Y>Y_quantiles(4))]./sum(ALPHA(Y>Y_quantiles(4)));

C_Quintile(:,3) = (C_Quintile(:,2)-C_Quintile(:,1))./C_Quintile(:,1)*100;

KK =k_choice(:,:,1);
KK =KK(:);
K = k_choice_stat(:);

K_Quintile(1,:) = [K(Y<=Y_quantiles(1))'*ALPHA(Y<=Y_quantiles(1));KK(Y<=Y_quantiles(1))'*ALPHA(Y<=Y_quantiles(1))]./sum(ALPHA(Y<=Y_quantiles(1)));
K_Quintile(2,:) = [K(Y>Y_quantiles(1)&Y<=Y_quantiles(2))'*ALPHA(Y>Y_quantiles(1)&Y<=Y_quantiles(2));KK(Y>Y_quantiles(1)&Y<=Y_quantiles(2))'*ALPHA(Y>Y_quantiles(1)&Y<=Y_quantiles(2))]./sum(ALPHA(Y>Y_quantiles(1)&Y<=Y_quantiles(2)));
K_Quintile(3,:) = [K(Y>Y_quantiles(2)&Y<=Y_quantiles(3))'*ALPHA(Y>Y_quantiles(2)&Y<=Y_quantiles(3));KK(Y>Y_quantiles(2)&Y<=Y_quantiles(3))'*ALPHA(Y>Y_quantiles(2)&Y<=Y_quantiles(3))]./sum(ALPHA(Y>Y_quantiles(2)&Y<=Y_quantiles(3)));
K_Quintile(4,:) = [K(Y>Y_quantiles(3)&Y<=Y_quantiles(4))'*ALPHA(Y>Y_quantiles(3)&Y<=Y_quantiles(4));KK(Y>Y_quantiles(3)&Y<=Y_quantiles(4))'*ALPHA(Y>Y_quantiles(3)&Y<=Y_quantiles(4))]./sum(ALPHA(Y>Y_quantiles(3)&Y<=Y_quantiles(4)));
K_Quintile(5,:) = [K(Y>Y_quantiles(4))'*ALPHA(Y>Y_quantiles(4));KK(Y>Y_quantiles(4))'*ALPHA(Y>Y_quantiles(4))]./sum(ALPHA(Y>Y_quantiles(4)));

K_Quintile(:,3) = (K_Quintile(:,2)-K_Quintile(:,1))./K_Quintile(:,1)*100;

figure(2)
bar(1:5,[C_Quintile(:,3)';K_Quintile(:,3)'])
legend('Consumption', 'Savings', 'Location', 'best','FontSize',18)
ylabel('% change in','FontSize',18,'FontWeight','bold')
xticklabels({'1', '2', '3', '4', '5'})
xlabel('Quintiles of the pre-Covid-19 income distribution','FontSize',18,'FontWeight','bold')


set (figure(2), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(2);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_App_D_4.eps','BackgroundColor','none')


load('../Outputs/Microsimulations_Data.mat')

figure(3)
subplot(2,2,1)
title('Wealth')
A = [Mean_K_nocap_pct - Mean_K_ss_pct]./Mean_K_ss_pct*100;
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
A = [Mean_H_nocap_pct - Mean_H_ss_pct]./Mean_H_ss_pct*100;
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
A = [Mean_K_nocap_grp - Mean_K_ss_grp]./Mean_K_ss_grp*100;
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
A = [Mean_H_nocap_grp - Mean_H_ss_grp]./Mean_H_ss_grp*100;
hold on
plot(A(1,:), '-.*',  'LineWidth', 1.25)
plot(A(2,:), '-.o',  'LineWidth', 1.25)
plot(A(3,:), '-.+',  'LineWidth', 1.25)
plot(A(4,:), '-.d',  'LineWidth', 1.25)

xlim([1 23])
xticks([3 8 13 18 23]-1)
xtickangle(45)
xticklabels({'2020','2025', '2030','2035','2040'}) 

set (figure(3), 'Units', 'normalized', 'Position', [0.10,0,0.80,0.8]);
h = figure(3);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs/Fig_App_E_1.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_App_E_1.pdf','BackgroundColor','none')



figure(4)
subplot(2,2,1)
title('Wealth')
A = [Mean_K_pct_hw - Mean_K_ss_pct_hw]./Mean_K_ss_pct_hw*100;
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
A = [Mean_H_pct_hw - Mean_H_ss_pct_hw]./Mean_H_ss_pct_hw*100;
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
exportgraphics(h,'Outputs/Fig_App_E_2.eps','BackgroundColor','none')
exportgraphics(h,'Outputs/Fig_App_E_2.pdf','BackgroundColor','none')