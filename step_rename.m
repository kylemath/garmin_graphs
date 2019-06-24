clear all
close all
clc

data_dir = '/Users/kylemathewson/Downloads/';
files = dir([data_dir 'WELLNESS_TOTAL_STEPS - *.csv']);

outfiles = {};
for i_file = 1:length(files);
	newName = ['WELLNESS_TOTAL_STEPS (' num2str(100+ i_file) ').csv'];
	copyfile([data_dir files(i_file).name],[data_dir newName])

end




