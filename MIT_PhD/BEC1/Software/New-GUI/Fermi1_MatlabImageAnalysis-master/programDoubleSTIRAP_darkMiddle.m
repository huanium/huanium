function programDoubleSTIRAP_darkMiddle(ampUpleg_W,ampDownleg_W,beginningBuffer,pulseDuration,pulsePause,endBufferTime)
    %ampUpleg       in rel units 0-1
    %ampDownleg     in rel units 0-1
    %pulseDuration  in us
    %pulsePause     in us
    %endBufferTime  in us
    ntotalSamples   = 10000;
    
    pulseDurationUp   = 1*pulseDuration;
    pulseDurationDown = 1*pulseDuration;
    totalTime         = pulseDurationUp+pulseDurationDown+endBufferTime+pulsePause+beginningBuffer; %in micro seconds
    sinperiodUp       = round(ntotalSamples*(pulseDurationUp/totalTime));
    SinUpSamples      = 0:1:sinperiodUp; 
    
    sinperiodDown         = round(ntotalSamples*(pulseDurationDown/totalTime));
    SinDownSamples        = 0:1:sinperiodDown; 
    
    %TiSa calibration 2020-10-12
    %[controlVoltage,sortIdx]=sort([0,0.6,0.7,0.8,1,1.2,1.4,1.6,1.8,2,2.2,2.4,2.6,2.8,3.0,3.2,3.5,4,4.5,5]);
    %opticalPower            =[0,0.01,1.6,6,18,43,72,105,137,175,211,250,280,320,370,420,490,630,800,1000];
    %opticalPower            = opticalPower(sortIdx);
    %TiSa calibration 2021-03-24
    controlVoltage      = [0,1,50,100,150,200,250,300,400,500,600,700,800,900,950,1000,1100,1200,1300,1400,1500]/1000;
    opticalPower        = [0,0.032,0.170,0.6,1.56,3,5.9,10.5,27,60,116,200,300,430,510,589,725,829,952,1020,1075]/1000;
    %[controlVoltage,sortIdx]=sort([0,2]);
    %opticalPower            =[0,2];
    
    RabiFreqConversion      = sqrt(opticalPower);
    RabiFreqConversion      = RabiFreqConversion/max(RabiFreqConversion);
%     figure(3),clf;
%     plot(controlVoltage,RabiFreqConversion)
%     
    Upleg = ampUpleg_W*[zeros(1,round(ntotalSamples*(beginningBuffer/totalTime))),...
            1/2*(1+sin(pi*SinUpSamples*1/sinperiodUp-pi/2)),...
            zeros(1,round(ntotalSamples*(pulsePause/totalTime))-1),...
            1/2*(1+sin(pi*SinDownSamples*1/sinperiodDown+pi/2)),...
            zeros(1,round(ntotalSamples*(endBufferTime/totalTime))-1)];
    UplegMixerCorrected = interp1(opticalPower,controlVoltage,Upleg);
    RabiRampUpleg = interp1(RabiFreqConversion,controlVoltage,Upleg);
    
    
    %Dye calibration 2020-10-12
    %[controlVoltage,sortIdx]=sort([0,0.01,0.02,0.03,0.04,0.05,0.06,0.09,0.12,0.15,0.2,0.3,0.4,0.5,0.6,0.7,0.8,1]);
    %opticalPower            =[0,0.01,0.1,0.5,0.75,1.4,1.8,3,5.2,10,20.7,33.6,71.1,100,115,140,170,250];
    %opticalPower            = opticalPower(sortIdx);
    %Dye calibration 2021-03-24
    controlVoltage      = [0,1,50,100,150,200,250,300,400,500,600,700,800,900,1000,1100]/1000;
    opticalPower  = ([0.0005,0.0009,0.0018,0.0045,0.0092,0.015,0.022,0.03,0.05,0.073,0.097,0.122,0.142,0.163,0.175,0.182]-0.0005)/1000;
    
    %[controlVoltage,sortIdx]=sort([0,2]);
    %opticalPower            =[0,2];
    
    RabiFreqConversion      = sqrt(opticalPower);
    RabiFreqConversion      = RabiFreqConversion/max(RabiFreqConversion);
%     figure(4),clf;
%     plot(controlVoltage,RabiFreqConversion)
    
    Downleg = ampDownleg_W*[ones(1,round(ntotalSamples*(beginningBuffer/totalTime))),...
            1/2*(1+sin(pi*SinDownSamples*1/sinperiodDown+pi/2)),...
            zeros(1,round(ntotalSamples*(pulsePause/totalTime))-1),...
            1/2*(1+sin(pi*SinUpSamples*1/sinperiodUp-pi/2)),...
            ones(1,round(ntotalSamples*(endBufferTime/totalTime))-1)];
    DownlegMixerCorrected = interp1(opticalPower,controlVoltage,Downleg);
    RabiRampDownleg = interp1(RabiFreqConversion,controlVoltage,Downleg);   
    
 
    figure(8173),clf;
        hold on
        plot((1:ntotalSamples)/ntotalSamples*(totalTime),Upleg(1:ntotalSamples),'LineWidth',2)
        plot((1:ntotalSamples)/ntotalSamples*(totalTime),UplegMixerCorrected(1:ntotalSamples),'LineWidth',2)
        plot((1:ntotalSamples)/ntotalSamples*(totalTime),Downleg(1:ntotalSamples),'LineWidth',2)
        plot((1:ntotalSamples)/ntotalSamples*(totalTime),DownlegMixerCorrected(1:ntotalSamples),'LineWidth',2)
        hold off
        xlabel('time (us)' )
        legend('Upleg (mW)','Upleg (mixer corrected voltage)','Downleg (mW)','Downleg (mixer corrected voltage)'    )
        box on
    
    
%     figure(8174),clf;
%         hold on
%         plot((1:ntotalSamples)/ntotalSamples*(totalTime),RabiRampUpleg(1:50000),'LineWidth',2)
%         plot((1:ntotalSamples)/ntotalSamples*(totalTime),RabiRampDownleg(1:50000),'LineWidth',2)
%         hold off
%         xlabel('time (us)' )
%         ylabel('rel. Rabi Freq.' )
%         box on
    drawnow
    programAWGvoltageRamp('USB0::0x05E6::0x3390::1407760::0::INSTR',totalTime,UplegMixerCorrected(1:ntotalSamples))   % this is the TiSa control
    programAWGvoltageRamp('USB0::0x05E6::0x3390::1421789::0::INSTR',totalTime,max(DownlegMixerCorrected)-DownlegMixerCorrected(1:ntotalSamples)) % this is the old gaussian
    
end