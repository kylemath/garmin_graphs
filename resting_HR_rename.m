clear all
close all
clc

data_dir = '/Users/kylemathewson/Downloads/';
files = dir([data_dir 'WELLNESS_RESTING_HEART_RATE - *.csv']);

outfiles = {};
for i_file = 1:length(files);
	newName = ['WELLNESS_RESTING_HEART_RATE (' num2str(100+ i_file) ').csv'];
	copyfile([data_dir files(i_file).name],[data_dir newName])

end




