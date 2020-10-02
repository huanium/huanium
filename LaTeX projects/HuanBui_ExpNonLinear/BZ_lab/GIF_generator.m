%// Create file name.
FileName = 'C:\Users\buiqu\Documents\GitHub\huanium\LaTeX projects\HuanBui_ExpNonLinear\BZ_lab\BZ_lab_lite.gif';

for k = 20:8:1020 % load every other image
    disp('Processing...')
    disp(k);
    myimg = im2uint8(image_load(k)); 
    myimg = [myimg(1:10,1:567); myimg(452:928,606:1172)];
    if k == 20
        %// For 1st image, start the 'LoopCount'.
        imwrite(myimg,FileName,'gif','LoopCount',Inf,'DelayTime',0.1);
    else
        imwrite(myimg,FileName,'gif','WriteMode','append','DelayTime',0.1);
    end
end


function image = image_load(number)
prefix = 'C:\Users\buiqu\Desktop\oscillations\BZ';
name = [prefix, sprintf('%04u',number),'.tif'];
image = imread(name,'tif');
end