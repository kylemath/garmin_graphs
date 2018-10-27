clear all
clc
close all

[last_filename path] = uigetfile('/Users/kyle/Downloads/*.csv')
totalfiles = str2double(last_filename(end-7:end-5)); %actually one more with no suffix ()

 %% loop through and grab cals
all_days = [];
all_sleep = [];
for i=totalfiles:-1:1
    [Days, sleep] = importfile_garminSleep([path last_filename(1:end-10) ' ('  num2str(i)  ')' '.csv']);
    all_sleep = [all_sleep; sleep];
    all_days = [all_days; Days];
   
end

%% most recent one
[Days sleep] = importfile_garmindrestingHR([path last_filename(1:end-10) '.csv']);
all_sleep = [all_sleep; sleep];
all_days = [all_days; Days];
    
%% plot

%running average
win_size = 6;
mean_sleep = nan(size(all_sleep));
for i_win = win_size:length(all_sleep)-win_size
    mean_sleep(i_win) = mean(all_sleep(i_win-(win_size-1):i_win+win_size));
end


%%

figure; plot(length(all_sleep):-1:1,all_sleep);
hold on; line([730 730],[min(all_sleep) max(all_sleep)],'color','k')
hold on; line([365 365],[min(all_sleep) max(all_sleep)],'color','k')

hold on; plot(length(all_sleep):-1:1,mean_sleep,'color','r');
hold on; line([0 length(all_sleep)],[8 8],'color','k')
axis tight

xlabel('Days before today');
ylabel('Daily Sleep (hrs)');
title('Kyle Daily Sleep');

save('sleep.mat','mean_sleep','all_sleep')


