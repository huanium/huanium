function [timestamp,parameter_string] = ReadSnippetFile(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [TIMESTAMP,PARAMETER_STRING] = IMPORTFILE(FILENAME) Reads data from
%   text file FILENAME for the default selection.
%
%   [TIMESTAMP,PARAMETER_STRING] = IMPORTFILE(FILENAME, STARTROW, ENDROW)
%   Reads data from rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   [timestamp,parameter_string] = importfile('2015-11-18.txt',1, 16);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2015/11/18 18:18:07

%% Initialize variables.
delimiter = '\t';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% Format string for each line of text:
%   column1: datetimes (%{MM-dd-yyyy_HH_mm_ss}D)
%	column2: text (%s)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%{MM-dd-yyyy_HH_mm_ss}D%s%[^\n\r]';

try

%% Open the text file.
fileID = fopen(filename,'r');

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
timestamp = dataArray{:, 1};
parameter_string = dataArray{:, 2};


% For code requiring serial dates (datenum) instead of datetime, uncomment
% the following line(s) below to return the imported dates as datenum(s).

% timestamp=datenum(timestamp);

catch
    warning('Could not read the snippet file.')
    timestamp_string = {'01-01-0000_00_00_00'};
    format_in = 'mm-dd-yyyy_HH_MM_ss';
    timestamp = datenum(timestamp_string,format_in);
    parameter_string = {'empty'};
    
end