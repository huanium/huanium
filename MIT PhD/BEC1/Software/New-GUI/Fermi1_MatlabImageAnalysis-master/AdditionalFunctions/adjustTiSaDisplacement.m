function adjustTiSaDisplacement(distanceInPx,imageParameterArray)
    % distanceInPx is the desired offset between PODT and TiSA in px
    % array of images recorded 0 = no TiSa
    % 1 = 1064nm; e.g. [0,0,1,1]

    meas = Measurement('DetermineOffSet','imageStartKeyword','Na','sortFilesBy','name','moveFile',true);
    
    meas.settings.marqueeBox=[429    95   230   132]; 
    %meas.settings.normBox=[475 100 smallMBwidthX smallMBwidthY ]; 
    
    for idx = 1:length(imageParameterArray)
        meas.loadNewestSPEImage(imageParameterArray(idx));
        meas.fitBimodalExcludeCenter('last','BlackedOutODthreshold',4.1);
    end
    
    xvals = imageParameterArray;
    %yvals = meas.analysis.measNa.analysis.COMY;
    yvals = meas.analysis.fitBimodalExcludeCenter.yparam(:,3);
    
    averagedPositions = getAverageValuesWithError(xvals,yvals,[]);
    
    offsetInPx = averagedPositions.yvalsAveraged(1)-averagedPositions.yvalsAveraged(2);
    pxPerStep = 0.043829*2;
    
    requiredPicoMotorSteps = -(offsetInPx-distanceInPx)/pxPerStep;
    
    fprintf('Moving %i Steps (%.2f pixel)\n',round(requiredPicoMotorSteps),(offsetInPx-distanceInPx));
    %%Alex code here
    if abs(requiredPicoMotorSteps) >100
        warning('steps exceed 100, press button to move');
        waitforbuttonpress;
    end
    movePicoMotor(2,round(requiredPicoMotorSteps))
end