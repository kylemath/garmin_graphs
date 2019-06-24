clear all
clc
close all

resting_HR_rename
[last_filename path] = uigetfile('/Users/kylemathewson/Downloads/*.csv')
totalfiles = str2double(last_filename(end-7:end-5)); %actually one more with no suffix ()

 %% loop through and grab cals
all_days = [];
all_RHRs = [];
for i=totalfiles:-1:1
    [Days RHR] = importfile_garmindrestingHR([path last_filename(1:end-10) ' ('  num2str(i)  ')' '.csv']);
    all_RHRs = [all_RHRs; RHR];
    all_days = [all_days; Days];
   
end

%% most recent one
[Days RHR] = importfile_garmindrestingHR([path last_filename(1:end-10) '.csv']);
all_RHRs = [all_RHRs; RHR];
all_days = [all_days; Days];
    
%% plot

%running average
win_size = 6;
mean_RHRs = nan(size(all_RHRs));
for i_win = win_size:length(all_RHRs)-win_size
    mean_RHRs(i_win) = mean(all_RHRs(i_win-(win_size-1):i_win+win_size));
end


%%

figure; plot(length(all_RHRs):-1:1,all_RHRs);
hold on; line([365 365],[min(all_RHRs) max(all_RHRs)],'color','k')
hold on; line([730 730],[min(all_RHRs) max(all_RHRs)],'color','k')

hold on; plot(length(all_RHRs):-1:1,mean_RHRs,'color','r');
hold on; line([0 length(all_RHRs)],[50 50],'color','k')
axis tight

xlabel('Days before today');
ylabel('Resting Heart Rate (BPM)');
title('Kyle Resting Heart Rate');


save('resting_HR.mat','mean_RHRs','all_RHRs')
