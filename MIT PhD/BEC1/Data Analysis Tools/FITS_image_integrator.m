clear all

% Analysis of FITS images %

% % load all files from a folder %
% prompt  = 'Put folder directory here: ';
% folderDir = input(prompt, 's');

inputDir = '~/huanium/MIT PhD/BEC1/2021-10-18-catch-wait/2021-10-18_17-20-42.fits';
data = fitsread(inputDir, 'primary');
% data has 3 images
% first image:
wA = data(:,:,1);
woA = data(:,:,2);
dark = data(:,:,3);

% OD: OD image = ???
OD = data(:,:,2) - data(:,:,1);


% re-scale
wA = wA/255; 
woA = woA/255; 
dark = dark/255; 
OD = OD/255; 

% figure(1)
% imshow(wA);
% figure(2)
% imshow(woA);
% figure(3)
% imshow(dark);
% figure(4)
imshow(OD);


% integrating ROI 
roi = drawrectangle;
%r = floor(roi.Vertices(:,2)) + 1;
%c = floor(roi.Vertices(:,1)) + 1;
r = [401 548 548 401]; % default values for testing 
c = [461 461 991 991]; % default values for testing
J = integralImage(OD);
regionSum = J(r(1),c(1)) - J(r(2),c(2)) + J(r(3),c(3)) - J(r(4),c(4));

disp(['Region sum is: ', num2str(regionSum)])
