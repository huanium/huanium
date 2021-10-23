% readSPE.m
function image = readSPE(this,filename)

%% Start of Code

% parse optional input
% if nargin>1
%     filename = strcat(dirPath,filename);
% else
%     filename = dirPath;
% end

%Ask UI for directory
%filename=uigetfile;



% Open the file
fd = fopen(filename,'r');
if(fd < 0)
    error('Could not open file, bad filename')
end

% Get the image dimensions:
stripDim = getData(fd, '2A', 'uint16');     %first dim
pixelDim = getData(fd, '290', 'uint16');    %second dim
nDim = getData(fd, '5A6', 'uint32');        %third dim

% Get the pixel data type
dataType = getData(fd, '6C', 'uint16');

% Get the image
fseek(fd, hex2dec('1004'), 'bof');

image = zeros([pixelDim,stripDim,nDim]);
switch dataType
    case 0     % single precision float (4 bytes)
        image = single(image);      %maintain datatype in function output
        for i=1:nDim
            image(:,:,i) = fread(fd, [stripDim,pixelDim], 'float32')';
        end
        
    case 1    % long int (4 bytes)
        image = int32(image);
        for i=1:nDim
            image(:,:,i) = fread(fd, [stripDim,pixelDim], 'int32')';
        end
        
    case 2    % short int (2 bytes)
        image = int16(image);
        for i=1:nDim
            image(:,:,i) = fread(fd, [stripDim,pixelDim], 'int16')';
        end
        
    case 3    % short unsigned int (2 bytes)
        image = uint16(image);
        for i=1:nDim
            image(:,:,i) = fread(fd, [stripDim,pixelDim], 'uint16')';
        end
        
    otherwise
        image = -1;
end
this.settings.rawImageSize = [length(image(:,1,1)),length(image(1,:,1))];
fclose('all');
end

%%
% getData() reads one piece of data at a specific location
%
function data = getData(fd, hexLoc, dataType)
% Inputs: fd - int    - file descriptor
%     hexLoc - string - location of data relative to beginning of file
%   dataType - string - type of data to be read
%
fseek(fd, hex2dec(hexLoc), 'bof');
data = fread(fd, 1, dataType);
end