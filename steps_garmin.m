clear all
clc
close all

[last_filename path] = uigetfile('/Users/kyle/Downloads/*.csv')
totalfiles = str2double(last_filename(end-7:end-5)); %actually one more with no suffix ()

 %% loop through and grab cals
all_days = [];
all_steps = [];
for i=totalfiles:-1:1
    [Days, steps] = importfile_garminSteps([path last_filename(1:end-10) ' ('  num2str(i)  ')' '.csv']);
    all_steps = [all_steps; steps];
    all_days = [all_days; Days];
   
end

%% most recent one
[Days steps] = importfile_garmindrestingHR([path last_filename(1:end-10) '.csv']);
all_steps = [all_steps; steps];
all_days = [all_days; Days];
    
%% plot

%running average
win_size = 10;
mean_steps = nan(size(all_steps));
for i_win = win_size:length(all_steps)-win_size
    mean_steps(i_win) = mean(all_steps(i_win-(win_size-1):i_win+win_size));
end


%%

figure; plot(length(all_steps):-1:1,all_steps);
hold on; line([365 365],[min(all_steps) max(all_steps)],'color','k')
hold on; line([730 730],[min(all_steps) max(all_steps)],'color','k')

hold on; plot(length(all_steps):-1:1,mean_steps,'color','r');
hold on; line([0 length(all_steps)],[10000 10000],'color','k')
axis tight

xlabel('Days before today');
ylabel('Daily Steps');
title('Kyle Daily Steps');

ax = gca;
ax.YRuler.Exponent = 0;

save('steps.mat','mean_steps','all_steps')

