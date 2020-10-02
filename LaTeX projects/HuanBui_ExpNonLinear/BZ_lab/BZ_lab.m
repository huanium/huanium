
M = image_load(151);
%imshow(M)
imtool(M);
%imtool(M(554:615,996:1049));


d = zeros(200,1);
for j = 1:1:length(d)
    M = image_load(4*j); % look at every 4 images
    %d(j) = M(707,1069);
    d(j) = M(573,879);
    %d(j) = mean(M(382:928,556:1192),'all');
end
figure
plot(1:1:length(d),d)
xlabel('Image number/4');
ylabel('Brightness');   

%%%%%%%%%% FUNCTIONS %%%%%%%%%%

function image = image_load(number)

prefix = 'C:\Users\buiqu\Desktop\oscillations\BZ';
name = [prefix, sprintf('%04u',number),'.tif'];
image = imread(name,'tif');
end




