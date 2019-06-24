clear all
clc
close all

totalcalories_rename
[last_filename path] = uigetfile('/Users/kylemathewson/Downloads/*.csv')
totalfiles = str2double(last_filename(end-7:end-5)); %actually one more with no suffix ()

 %% loop through and grab cals collected using MurGaa.app
all_cals = [];
all_days = [];
for i=totalfiles:-1:1
    [Days Type Cals] = importfile_totalcoloriesgarmin([path last_filename(1:end-10) ' ('  num2str(i)  ')' '.csv']);
    n_days = length(Cals)/2;
    current_active_cals = Cals(n_days+1:end);
    current_rest_cals = Cals(1:n_days);
    current_total_cals = current_active_cals+current_rest_cals;    
    current_days = Days(n_days+1:end);
    all_cals = [all_cals; current_total_cals];
    all_days = [all_days; current_days];
    
end

%% most recent one
[Days Type Cals] = importfile_totalcoloriesgarmin([path last_filename(1:end-10) '.csv']);
n_days = length(Cals)/2;
current_active_cals = Cals(n_days+1:end);
current_rest_cals = Cals(1:n_days);
current_total_cals = current_active_cals+current_rest_cals;
current_days = Days(n_days+1:end);
all_cals = [all_cals; current_total_cals];
all_days = [all_days; current_days];

%% plot

%running average
win_size = 10;
mean_cals = nan(size(all_cals));
for i_win = win_size:length(all_cals)-win_size
    mean_cals(i_win) = mean(all_cals(i_win-(win_size-1):i_win+win_size));
end


%%


all_cals(all_cals < 2400) = 2400;
figure; line(length(all_cals):-1:1,all_cals);
hold on; plot(length(all_cals):-1:1,mean_cals,'color','r');
hold on; line([0 length(all_cals)],[4000 4000],'color','k')
hold on; line([365 365],[2000 max(all_cals)],'color','k')
hold on; line([730 730],[2000 max(all_cals)],'color','k')


axis tight

xlabel('Days before today');
ylabel('Total Calories (Resting+Active)');
title('Kyle Calories/Day');

save('cals.mat','mean_cals','all_cals')

