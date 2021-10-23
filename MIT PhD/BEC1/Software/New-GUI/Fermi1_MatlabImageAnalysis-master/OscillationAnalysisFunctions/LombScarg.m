function OscAnalysis = LombScarg(ana,varargin)
%ana is an analysis object with the relevant cloud positions.  
%Returns the Lomb scargle power spectral
%density from COM oscillations in the y-axis.
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
            disp('Using BEC parabola peak position for LS');

        catch
            warning('No fitBimodalExcludeCenter field exists');
        end
    elseif strcmp('Gauss',COMtype)
        y=pixelToMicron*ana.analysis.fitIntegratedGaussY.param(:,3)';
        disp('Using Gaussian peak position for LS');
    else
        y=pixelToMicron*ana.analysis.COMY;
        disp('Using true center-of-mass for LS');
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

    figure(31);clf;
    subplot(2,1,1);
    plot(traw, y,'.','MarkerSize',20)
    hold on;plot(t,ymean,'LineWidth',2);
    legend('raw','mean');
    ylabel('COM (um)'); xlabel('Osc time (ms)');

    subplot(2,1,2);
    [pLS,fLS]=plomb(ymean,t/1e3,300); %specify max frequency
    plot(fLS,pLS,'LineWidth',2);
    ylabel('Lomb scargle PSD');  xlabel('Freq (Hz)');
    
    OscAnalysis=struct;
    OscAnalysis.freqLS=fLS;
    OscAnalysis.powerSpecDensityLS=pLS;
end