function [boxW,boxH]=generateAnalysisBoxes(BEC_X, numBoxesX, numBoxesY, numBECX, numBECY)
    %Generates box y-heights and x-widths that will give a linear density tuning
    %as a function of increasing box index
    
    %Inputs:
    %numBoxesX= desired number of analysis boxes in x-direction, typ 12
    %numBoxesY= desired number of analysis boxes in y-direction, typ 3
    %numBECX= desired number of analysis boxes inside the condensate xTF,
    %for y = 0 
    %numBECY= desired number of analysis boxes inside the condensate yTF,
    %for y = 0 
    
    %Outputs (in pixel units)
    %BoxW will be variable widths engineered to give near linear variation
    %in density, both for the BEC, and for the thermals
    %However, there will be finer grain resolution near the BEC boundary
    %(1 pixel)
    %BoxH are variable heights engineered to give near linear variation in 
    %BEC density. All box heights in y-direction fall within the yTF radius

    camPix=2.48;
    camPix=2.5; %use z-camera!!!
        


    %get x-axis dimensions (boxWidths)

    xTFpix=BEC_X.TF/camPix; %x TF radius in pixels
    
    x=ones(1, numBoxesX+1);

    x(1:numBECX)=xTFpix*sqrt(1-linspace(1,0,numBECX));
  
    x(numBECX+1)=x(numBECX)+1; %one "intermediate" point of one pixel resolution
    x(numBECX+2:end)=x(numBECX+1)+1-floor(0.75*xTFpix*log(linspace(1,.1,numBoxesX-numBECX)));

    boxWtemp=zeros(1, numBoxesX);
    boxW=zeros(1, numBoxesX);
    for d=1:numBoxesX
        boxWtemp(d)=max(0,(x(d+1)-x(d)));
    end
    remainder = 0;
    for idx = 1:numBoxesX
        boxW(idx) = floor(boxWtemp(idx)+remainder);
        remainder = min(rem(boxWtemp(idx)+remainder,boxW(idx)),rem(boxW(idx),boxWtemp(idx)+remainder));
    end
    
    
    %get y-axis dimensions (boxHeights)
    y=ones(1, numBoxesY+1);
    yTFpix=xTFpix*BEC_X.Omegas(1)/BEC_X.Omegas(2);
    y(1:numBECY)=yTFpix*sqrt(1-linspace(1,0,numBECY)); 
    y(numBECY+1)=y(numBECY)+1; %one "intermediate" point of one pixel resolution
    y(numBECY+2:end)=y(numBECY+1)+1-floor(0.75*yTFpix*log(linspace(1,.1,numBoxesY-numBECY)));
    
    boxHtemp=zeros(1, numBoxesY);
    boxH=zeros(1, numBoxesY);
    for d=1:numBoxesY
        boxHtemp(d)=max(0,(y(d+1)-y(d)));
    end
    remainder = 0;
    for idx = 1:numBoxesY
        boxH(idx) = floor(boxHtemp(idx)+remainder);
        remainder = min(rem(boxHtemp(idx)+remainder,boxH(idx)),rem(boxH(idx),boxHtemp(idx)+remainder));
    end
    
    string1 = 'Relative Box Width (in units of pixel): ';
    string2 = 'Absolute Box Width (in units of TF):';
    for idx = 1:numBoxesX
        string1 = [string1, num2str(boxW(idx)), ' '];
        string2 = [string2, num2str(sum(boxW(1:idx))/xTFpix,2), ' '];
    end
    fprintf([string1,'\n']);
    fprintf([string2,'\n']);
    
    string1 = 'Relative Box Height (in units of pixel): ';
    string2 = 'Absolute Box Height (in units of TF):';
    for idx = 1:numBoxesY
        string1 = [string1, num2str(boxH(idx)), ' '];
        string2 = [string2, num2str(sum(boxH(1:idx))/yTFpix,2), ' '];
    end
    fprintf([string1,'\n']);
    fprintf([string2,'\n']);
    
end
