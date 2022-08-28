clear all

% Analysis of FITS images %

% % load all files from a folder %
% prompt  = 'Put folder directory here: ';
% folderDir = input(prompt, 's');

% inputDir = '~/huanium/MIT PhD/BEC1/2021-10-18-catch-wait/2021-10-18_17-20-42.fits';
% target_folder = uigetdir('C:/');
% filePattern = fullfile(target_folder, '*.fits');
% files = dir(filePattern);
% data = fitsread(fullfile(files(1).folder, files(1).name), 'primary');
% disp(files(1).name)

[file,path] = uigetfile('*.fits');
if isequal(file,0)
   disp('No selection.');
else
   disp(['Selected: ', fullfile(path,file)]);
end

data = fitsread(fullfile(path,file), 'primary');


% data has 3 images
% wA = data(:,:,1);
% woA = data(:,:,2);
% dark = data(:,:,3);
OD = real(-log((data(:,:,1) - data(:,:,3))./(data(:,:,2) - data(:,:,3))));

imshow(OD/4);

% rectify data for integration
% make Inf and Nan = 0 so that they don't count
OD(isinf(OD)) = 0;
OD(isnan(OD)) = 0;

% figure(1)
% imshow(wA);
% figure(2)
% imshow(woA);
% figure(3)
% imshow(dark);

% integrating ROI 
roi = drawrectangle;
r = floor(roi.Vertices(:,2)) + 1;
c = floor(roi.Vertices(:,1)) + 1;
% r = [455 513 513 455]; % default values for testing 
% c = [560 560 901 901]; % default values for testing
J = integralImage(OD);
regionSum = J(r(1),c(1)) - J(r(2),c(2)) + J(r(3),c(3)) - J(r(4),c(4));
disp(['Region sum is: ', num2str(regionSum)])
