%%Test function: fake data with realistic parameters, lab x line density
tofseries=6:2:16;
figure(345);clf;hold on;
realTemp=110e-9; %K
pReal=[realTemp 12  0.0005  0];
mu = 5.7715e-31; %J
OmegaX=13*2*pi;
OmegaZ=110*2*pi;
camPix=2.48e-6;
parameterNames = {'Temperature(Kelvin)','amp','center','offset'};

xcoords=[1:340]*camPix;
fitTemp=zeros(size(tofseries));
fitGaussTemp=fitTemp;

for idx=1:length(tofseries)
    tof=tofseries(idx); %ms
    fitfunBose =@(p,x) p(4)+p(2)*PolyLog(2.5, exp(-abs((mu-1/2*mNa*OmegaX^2/(1+OmegaX^2*tof^2/1e6)*(x-p(3)).^2))./(kB*p(1))));
    xvals = fitfunBose(pReal, xcoords);
    
    subplot(2, 3, idx); hold on;
    plot(xcoords,xvals);
    %find the mask to ignore BEC location %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dum=1:length(xvals)-1;
    dumB=dum;
    for jdx=1:length(dum)
        dum(jdx)=xvals(jdx+1)-xvals(jdx);
        dumB(end-jdx+1)=xvals(jdx+1)-xvals(jdx);
    end
    dum2=find(dum<0);
    lowCut=dum2(1);
    dum3=find(dumB>0);
    highCut=length(dum)-dum3(1)+2;
    mask=[1:lowCut-40,highCut+40:length(xcoords)];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    plot(xcoords(mask),xvals(mask));

    %      fit Bose
    maxy=100;
    ub =    [mu/kB*10   2*maxy  xcoords(end)     abs(maxy)/2];
    lb=     [0          0       0                      min(xvals)];
    pGuess= [2*mu/kB    maxy/2    xcoords(end)/2   (xvals(1)+xvals(end))/2];

    opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);

    [param,~,resid,~,~,~,J] = lsqcurvefit(fitfunBose,pGuess,xcoords(mask),xvals(mask),lb,ub,opts);

    plot(xcoords(mask), fitfunBose(param,xcoords(mask)),'.');
    fitTemp(idx)=param(1);

    % fit gaussian function to bose data
    %{'Temperature(Kelvin)','amp','center','offset'};

    fitfunGauss=@(p,x) p(2)*exp(-mNa*OmegaX^2/(OmegaX^2*tof^2/1e6+1)*(x-p(3)).^2/(2*kB*p(1)))+p(4);
    [paramG,~,residG,~,~,~,JG] = lsqcurvefit(fitfunGauss,pGuess,xcoords(mask),xvals(mask),lb,ub,opts);
    fitGaussTemp(idx)=paramG(1);
    plot(xcoords(mask),fitfunGauss(paramG,xcoords(mask)),'.');

    title(strcat('TOF (ms) =',num2str(tof)));
    xlabel('Micron');ylabel('Amp (arb)');
    legend('fake data','mask',strcat('Bose T(nK) = ',num2str(fitTemp(idx)*10^9)),strcat('Gauss T(nK) = ', num2str(fitGaussTemp(idx)*10^9)));

end
mean(fitTemp./fitGaussTemp)
%%



%% real data from 6/18/18 run
xData=[1.58011795244743
-3.14667409682498
-5.69224050871793
-5.50454879358843
-3.36996950057717
5.03139544622464
-2.24764362086861
-4.82581879116161
-6.84391974791037
-5.46384738912049
-12.2172364160847
-6.95052703461965
-10.3865979742039
-2.57729331456445
-8.76774683088385
-8.23769166598322
-7.87924166517810
-10.5311917164491
-6.82162113027780
-9.41902129044371
-12.6528017204849
-7.75393187997627
-7.19578042271785
-12.6288639154457
-7.86302892925005
-10.5164606764917
-6.90770169773546
-9.79005316536929
-11.3968840666707
-13.6361580985606
-11.2759994349365
-10.8219928336077
-11.3982797252970
-6.86982783159428
-8.98754666266092
-9.67013198624205
-9.93905760151500
-4.57174822731296
-7.39190392215430
-8.81744624009272
-12.8231794518781
-9.56312001945085
-5.87146985992099
-8.73499872735547
-8.52043401879159
-11.5500080311242
-8.48232032058224
-3.26569272259637
-10.6535585953741
-9.70362131559937
-6.70552159106070
-2.17586274489914
-10.1543369410610
-9.83672184156324
-3.11027716518500
-6.47265404299188
-7.79669313852516
-2.19849164809184
-6.18075178090010
-0.843244534814472
-5.23546487080571
-4.66478113413767
-1.90385394925355
-3.59206397026145
-6.05184519046853
-3.41692337132626
-4.57865928002684
-3.68932207717528
-0.990150619540210
-0.00898591922779160
-0.250337509365302
4.32656521661294
1.05952555556511
2.94629001526563
1.09202399751877
1.98872231699521
3.13818903027690
-0.0465836619328427
5.66250377145855
4.53946398718648
6.29192524426948
6.23753746670746
8.76076489449306
11.9591892594510
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
13.9383171402832
9.28405801838059
8.33715527539339
5.19948703737405
1.78472753278556
0.0445519852803216
1.22618986666983
4.05602022603185
2.39909410533617
-1.60273548073081
-3.05208559229853
0.317235814877722
-2.79972950786223
-3.12150195129279
-6.29236554814155
-0.00132456915701099
-4.42309261449845
-3.60886499033183
0.794013095933838
-2.31398924308419
-7.05912395153187
-5.67424224487925
-1.40733141202050
-7.00962507024997
-6.95014914408318
-2.41206921443531
-6.59123385415260
-0.993473864350982
-7.43273538704509
-7.30739159718047
-9.68789714060851
-8.44680340062177
-6.42937028946826
-7.65381583929990
-4.72131348962945
-9.49212523963154
-6.62414964049075
-8.44002805726671
-11.0719010934936
-4.89014114152489
-10.0570730290769
-11.3220932904845
-10.9094907788521
-7.58189235545764
-8.79712862488062
-10.3886682394726
-6.50162376836825
-9.35433657576364
-8.04073492556401
-7.94076086779735
-10.9121441127447
-4.80879451501247
-7.67524002464864
-7.70911480069184
-9.22511882285899
-10.3692687544298
-8.05504861526143
-8.30693274910337
-5.35011528696370
-12.3914601517749
-10.7821245274809];


figure(345);plot([1:2:length(xData)*2]*camPix,xData);
