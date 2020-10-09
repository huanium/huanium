
% M = image_load(500);
% imshow(M)
% imtool(M);
% imtool(M(554:615,996:1049));

% how does the brightness of a region depend in time?
d = zeros(1200,1);
for j = 1:4:length(d)
    %M = image_load(j); % look at every 4 images
    
    % coordinates used for BZ oscillations
    %d(j) = M(707,1069);
    %d(j) = M(573,879);
    %d(j) = mean(M(382:928,556:1192),'all');
    
    % brightness at a region, in a particular time
    %d(j) = mean(M(515:519,693:697),'all');
end

% consider a vertical line. We want to look at how the brightness change in space,
% over time!

y1 = 250;
y2 = 500;
x1 = 698;
x2 = 698; 
line_length = y2-y1;
time_points = 10; % pick out only ten time points

% matrix: row = line at a certain time.
line_brightness = zeros(line_length, time_points);

% look at 10 images, equally spaced in time
% from first to last image
first_image = 1;
last_image = 500;
step = round((last_image - first_image)/time_points);

for k = 1:1:time_points
    % pick out the image
    M = image_load(first_image + step*k);
    
    % obtain pixel values along the line
    % put it in the kth row of the matrix
    line_brightness(:,k) = M(y1:y2-1,x1);
    %hold on
    
    % make sure they have the right dimensions!
    % plot(y1:1:y2-1, line_brightness(:,k)+3000*k);
    
    % plot this in space-time:
    % plot3(y1:1:y2-1, line_brightness(:,k)+3000*k, 1:1:time_points);
end
%xlabel('Space');
%ylabel('Brightness');
%hold off

% "slice" plots
pixel = (y1:1:y2-1).';
pixelMat = repmat(pixel, 1, time_points); %// For plot3
time_vec = 1:2:2*time_points;
timeMat = repmat(time_vec, numel(pixel), 1); %//For plot3
figure 
plot3(pixelMat, timeMat, line_brightness); 
grid;
xlabel('Vertical direction'); ylabel('Time'); zlabel('Brightness');
view(40,40); %// Adjust viewing angle so you can clearly see data

   
% figure
% plot(1:1:length(d),d)
% xlabel('Image number');
% ylabel('Brightness');   
% % fast fourier transform to find frequency components
% Fs = 2;               % 2Hz -- 2 pics per second                     
% T = 1/Fs;             % Sampling period       
% L = 1200;             % Length of signal 1200
% t = (0:L-1)*T;        % Time vector
% 
% FFT_d = fft(d);
% P2 = abs(FFT_d/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% 
% f = Fs*(0:(L/2))/L;
% 
% figure;
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')




%%%%%%%%%% FUNCTIONS %%%%%%%%%%

function image = image_load(number)

prefix = 'C:\Users\buiqu\Desktop\waves\BZ';
name = [prefix, sprintf('%04u',number),'.tif'];
image = imread(name,'tif');
end




