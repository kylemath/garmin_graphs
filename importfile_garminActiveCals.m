function [Day,Type,Cals] = importfile_garminActiveCals(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [DAY,TYPE,CALS] = IMPORTFILE(FILENAME) Reads data from text file
%   FILENAME for the default selection.
%
%   [DAY,TYPE,CALS] = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data
%   from rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   [Day,Type,Cals] = importfile('ACTIVITY_ACTIVE_CALORIES (2).csv',3, 18);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2017/09/03 10:13:45

%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 3;
    endRow = inf;
end

%% Format string for each line of text:
%   column1: text (%s)
%	column2: text (%s)
%   column3: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r','n','UTF-8');
% Skip the BOM (Byte Order Mark).
fseek(fileID, 3, 'bof');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
Day = dataArray{:, 1};
Type = dataArray{:, 2};
Cals = dataArray{:, 3};


