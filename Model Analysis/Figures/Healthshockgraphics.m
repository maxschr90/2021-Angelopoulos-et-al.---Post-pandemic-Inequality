%% Healthshock Figures
%% This code creates figures D1 & D2 in the appendix

clear
clc
close all

Healthshockresponse=table2array(readtable('../../Data Preparation & Analysis/Outputs/Healthshockresponse.xlsx', 'Sheet','Raw'));
Healthshockresponse =[(-1:5)',Healthshockresponse];
HealthshockresponseS1=table2array(readtable('../../Data Preparation & Analysis/Outputs/Healthshockresponse.xlsx', 'Sheet','Mincerian'));
HealthshockresponseS1 =[(-1:5)',HealthshockresponseS1];

figure(1)
ciplot(Healthshockresponse(:,3),Healthshockresponse(:,4),Healthshockresponse(:,1), [0.5, 0.5, 0.5])
hold on
plot(Healthshockresponse(:,1),Healthshockresponse(:,2), 'LineWidth',1.5, 'Color', 'black')
xticklabels({'t-1', 't', 't+1', 't+2', 't+3', 't+4', 't+5'})
ylabel('Standardized SF-12 PCS Measure','FontSize',12,...
       'FontWeight','bold')
set (figure(1), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'..\Outputs\Fig_App_D_1.eps','BackgroundColor','none')

figure(2)
ciplot(HealthshockresponseS1(:,3),HealthshockresponseS1(:,4),HealthshockresponseS1(:,1), [0.5, 0.5, 0.5])
hold on
plot(HealthshockresponseS1(:,1),HealthshockresponseS1(:,2), 'LineWidth',1.5, 'Color', 'black')
xticklabels({'t-1', 't', 't+1', 't+2', 't+3', 't+4', 't+5'})
ylabel({'Standardized SF-12 PCS Measure','(recentred residuals)'},'FontSize',12,...
       'FontWeight','bold')
set (figure(2), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(2);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(h,'Outputs\Fig_App_D_2.eps','BackgroundColor','none')






function ciplot(lower,upper,x,colour);
     
% ciplot(lower,upper)       
% ciplot(lower,upper,x)
% ciplot(lower,upper,x,colour)
%
% Plots a shaded region on a graph between specified lower and upper confidence intervals (L and U).
% l and u must be vectors of the same length.
% Uses the 'fill' function, not 'area'. Therefore multiple shaded plots
% can be overlayed without a problem. Make them transparent for total visibility.
% x data can be specified, otherwise plots against index values.
% colour can be specified (eg 'k'). Defaults to blue.

% Raymond Reynolds 24/11/06

if length(lower)~=length(upper)
    error('lower and upper vectors must be same length')
end

if nargin<4
    colour='b';
end

if nargin<3
    x=1:length(lower);
end

% convert to row vectors so fliplr can work
if find(size(x)==(max(size(x))))<2
x=x'; end
if find(size(lower)==(max(size(lower))))<2
lower=lower'; end
if find(size(upper)==(max(size(upper))))<2
upper=upper'; end

fill([x fliplr(x)],[upper fliplr(lower)],colour)

end

