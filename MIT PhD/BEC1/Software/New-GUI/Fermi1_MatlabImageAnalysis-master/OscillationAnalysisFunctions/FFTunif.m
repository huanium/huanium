function OscAnalysis = FFTunif(ana,varargin)
%ana is an analysis object with the relevant cloud positions.  
%Returns the |FFT(omega)|^2 frequency analysis
%from COM oscillations in the y-axis.
%Optional inputs
%If 'BEC' selected, gets COM from fitBimodalExcludeCenter.  If 'Gauss'
%selected, uses Gaussian peak position.  Else uses the true COM.
%If 'RemoveLinear' is true, fits a linear slope to the timeseries and
%subtracts off the line to take care of long-term machine drifts.
%Fits up to t= HighTCut in ms
    p = inputParser;
    p.addParameter('COMtype','BEC'); 
    p.addParameter('RemoveLinear','true'); 
    p.addParameter('HighTCut',[]);
    p.parse(varargin{:});
    COMtype                 = p.Results.COMtype;
    RemoveLinear            = p.Results.RemoveLinear;
    HighTCut                = p.Results.HighTCut;

    pixelToMicron=2.5;
    if strcmp('BEC',COMtype)
        try
            y=pixelToMicron*ana.analysis.fitBimodalExcludeCenter.yparam(:,3)';
            disp('Using BEC parabola peak position for FFT');

        catch
            warning('No fitBimodalExcludeCenter field exists');
        end
    elseif strcmp('Gauss',COMtype)
        y=pixelToMicron*ana.analysis.fitIntegratedGaussY.param(:,3)';
        disp('Using Gaussian peak position for FFT');
    else
        y=pixelToMicron*ana.analysis.COMY;
        disp('Using true center-of-mass for FFT');
    end
    if RemoveLinear
        figure(33);clf; hold on;
        plot(1:length(y),y,'.');
        
        linFit=polyfit(1:length(y),y,1);
        plot(linFit(2)+linFit(1)*[1:length(y)],'LineWidth',2);
        title(strcat('remove slope: ',num2str(linFit(1))));
        xlabel('Shot #');ylabel('y (um)');
        y=y-linFit(1)*(1:length(y));
    end
    traw=ana.parameters; %time in ms

    if ~isempty(HighTCut)
        keepIdx=find(traw<HighTCut);
        traw=traw(keepIdx);
        y=y(keepIdx);
    end

    [t,~,idx]=unique(traw);
    ymean=accumarray(idx,y,[],@mean);
    tSpace=t(2)-t(1);
    capIdx=length(t); %how far does the uniform spacing go?
    for idx=2:length(t)
        if t(idx)~=t(idx-1)+tSpace
            capIdx=idx-1;
            break;
        end
    end
    figure(32);clf;
    subplot(2,1,1);
    plot(traw, y,'.','MarkerSize',10)
    hold on;plot(t,ymean,'LineWidth',2);
    plot(t(1:capIdx),ymean(1:capIdx),'.','MarkerSize',20);
    legend('raw','mean');
    ylabel('COM (um)'); xlabel('Osc time (ms)');

    subplot(2,1,2);
    
    
    %FFT
    %zero pad from t(end) to next power of two higher than length (t(capIdx));
    n=2^nextpow2(capIdx);
    ffty=fft(ymean(1:capIdx)-mean(ymean(1:capIdx)),n); %returns n data points
    f=1/tSpace*(0:(n/2))/n; % By Nyquist, max freq is n/2*sample frequency
    P=abs(ffty(1:n/2+1)).^2/n^2;

    plot(f,P,'LineWidth',2);
    ylabel('|F(f)|^2');  xlabel('Freq (kHz)');
    
    OscAnalysis=struct;
    OscAnalysis.freq=f;
    OscAnalysis.powerSpecDensity=P;
end