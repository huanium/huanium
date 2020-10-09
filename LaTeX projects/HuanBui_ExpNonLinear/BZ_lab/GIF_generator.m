%// Create file name.
FileName = 'C:\Users\buiqu\Documents\GitHub\huanium\LaTeX projects\HuanBui_ExpNonLinear\BZ_lab\BZ_waves.gif';

for k = 1:4:1200
    disp('Processing...')
    disp(k);
    myimg = im2uint8(image_load(k)); 
    % myimg = myimg(155:860, 355:1057);
    myimg = myimg(155:860, 355:1057);
    if k == 1  % first img number
        %// For 1st image, start the 'LoopCount'.
        imwrite(myimg,FileName,'gif','LoopCount',Inf,'DelayTime',0.1);
    else
        imwrite(myimg,FileName,'gif','WriteMode','append','DelayTime',0.1);
    end
end


function image = image_load(number)
prefix = 'C:\Users\buiqu\Desktop\waves\BZ';
name = [prefix, sprintf('%04u',number),'.tif'];
image = imread(name,'tif');
end