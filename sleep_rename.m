clear all
close all
clc

data_dir = '/Users/kylemathewson/Downloads/';
files = dir([data_dir 'SLEEP_SLEEP_DURATION - *.csv']);

outfiles = {};
for i_file = 1:length(files);
	newName = ['SLEEP_SLEEP_DURATION (' num2str(100+ i_file) ').csv'];
	copyfile([data_dir files(i_file).name],[data_dir newName])

end




