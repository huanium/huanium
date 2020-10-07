
% M = image_load(151);
% imshow(M)
% imtool(M);
% imtool(M(554:615,996:1049));


d = zeros(1000,1);
for j = 1:1:length(d)
    M = image_load(4*j); % look at every 4 images
    d(j) = M(707,1069);
    %d(j) = M(573,879);
    %d(j) = mean(M(382:928,556:1192),'all');
end
figure
plot(1:1:length(d),d)
xlabel('Image number/4');
ylabel('Brightness');   



% Fs = 4;               % 4Hz -- 4 pics per second                     
% T = 1/Fs;             % Sampling period       
% L = 4000;             % Length of signal 1000s
% t = (0:L-1)*T;        % Time vector
% 
% FFT_d = fft(d);
% P2 = abs(FFT_d/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% 
% f = Fs*(0:(L/2))/L;
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')





%%%%%%%%%% FUNCTIONS %%%%%%%%%%

function image = image_load(number)

prefix = 'C:\Users\buiqu\Desktop\oscillations\BZ';
name = [prefix, sprintf('%04u',number),'.tif'];
image = imread(name,'tif');
end




