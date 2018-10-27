clear all
clc
close all

%% initialize
[last_filename path] = uigetfile('/Users/kyle/Downloads/*.csv')
totalfiles = str2double(last_filename(end-6:end-5)) %actually one more with no suffix ()
TypesL = {'Walking','Running','Cycling','Swimming','Other'};
DaysL = {'Mon','Tue','Wed','Thu','Fri','Sat','Sun'};
n_days = length(DaysL);
n_types = length(TypesL);

%% loop sthrough
totals = [];
all_totals = [];
for i=totalfiles:-1:1
    [Days Types Cals] = importfile_garminActiveCals([last_filename(1:end-9) ' ('  num2str(i)  ')' '.csv']);
    data = table(Days,Types,Cals)
    for i_day = 1:n_days
        for i_type = 1:n_types
            totals(i_day,i_type) = sum(data.Cals(ismember(data.Types,TypesL{i_type}) & ismember(data.Days,DaysL{i_day})));
        end
    end
    all_totals = [all_totals; totals]
    clear totals
end

%% last (most recent)
[Days Types Cals] = importfile_garminActiveCals([last_filename(1:end-9) '.csv'])
data = table(Days,Types,Cals)
for i_day = 1:n_days
    for i_type = 1:n_types
        totals(i_day,i_type) = sum(data.Cals(ismember(data.Types,TypesL{i_type}) & ismember(data.Days,DaysL{i_day})));  
    end
    all_totals = [all_totals; totals]
end

%% plot

figure; plot(all_totals); legend(TypesL);
hold on; plot(sum(all_totals'));



