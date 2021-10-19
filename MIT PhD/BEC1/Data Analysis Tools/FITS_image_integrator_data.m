%%% Name: Huan Q. Bui
%%% Date: Oct 19, 2021
%%% Primitive FITS image display/integrator


% load images from a specified folder
regionSums = [];
target_folder = uigetdir('~/huanium/MIT PhD/BEC1/');
filePattern = fullfile(target_folder, '*.fits');
files = dir(filePattern);
for k = 1 : length(files)
    % load files
    baseFileName = files(k).name;
    fullFileName = fullfile(files(k).folder, baseFileName);
    fprintf(1, 'Reading %s\n', fullFileName);
    
    % Now process
    data_k = fitsread(fullFileName, 'primary');
    
    % get OD image
    OD = data_k(:,:,2) - data_k(:,:,1);
    % re-scale
    OD = OD/255;
    
    % ROI set to be following (assuming catch didn't move much)
    r = [401 548 548 401]; % default values for testing 
    c = [461 461 991 991]; % default values for testing
    J = integralImage(OD);
    regionSums(k) = J(r(1),c(1)) - J(r(2),c(2)) + J(r(3),c(3)) - J(r(4),c(4));
end

% disp(regionSums)
times = [0.1 0.1 0.1 10 10 10 20 20 20 40 40 40 80 80 80];

% fit now
f = fit(times',regionSums','exp1');

% plot now
plot(f)
hold on
markerSize = 30;
scatter(times,regionSums, markerSize, 'b');
hold off
legend('fit', 'data')
ylabel('Sum of pixel values (a.u.)')
xlabel('Time (s)')

% extract lifetime out of fit
coeffs = coeffvalues(f);
disp('=========================')
disp(['Lifetime = ' num2str(-1/coeffs(2)) ' s'])
