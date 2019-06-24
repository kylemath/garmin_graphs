clear all
close all
clc

data_dir = '/Users/kylemathewson/Downloads/';
files = dir([data_dir 'COMMON_TOTAL_CALORIES - *.csv']);

outfiles = {};
for i_file = 1:length(files);
	newName = ['COMMON_TOTAL_CALORIES (' num2str(100+ i_file) ').csv'];
	copyfile([data_dir files(i_file).name],[data_dir newName])

end




