%% evaluate freq vs drag
aBF=[0:5:50 60:20:500]*aBohr; 
sigma=4*pi*aBF.^2;%cross section
v=sqrt(8*kB*130e-9/pi/(mK+mNa)); %relative rms thermal velocity
n=1.4e19;%Na density weighted by K gaussian density 1/NK * integral(nK nNa d^3r)
n=1e17;
pkDensity=6e19; %peak Na
drag=sigma*v*n;
% drag=0:.02:1;

nPoints=400;
x1=zeros(nPoints,length(drag));
x2=zeros(nPoints,length(drag));
pxx1=zeros(nPoints+1,length(drag));
pxx2=zeros(nPoints+1,length(drag));
for idx=1:length(drag)
    [x,t]=demoCoupledHarmonicOscillatorsOld(drag(idx),'meanFieldShift',true','aBF',aBF(idx),'density',pkDensity);
    x1(:,idx)=x(:,2);
    x2(:,idx)=x(:,4);
    % lomb-scargle
    [pxx1(:,idx),f1] = plomb(x(:,2),t,.2);
    [pxx2(:,idx),f2] = plomb(x(:,4),t,.2);
    figure(4);clf; hold on;
    plot(f1*1000,pxx1(:,idx));
    plot(f2*1000,pxx2(:,idx));
    xlim([0 200]);
%     waitforbuttonpress;
end
disp('finished');
%% plot spectral response vs aBF
colorlimit=300;
figure(5);
[X,Y]=meshgrid(aBF/aBohr,(f1*1e3));
surf(X,Y,(pxx1),'EdgeColor','none','LineStyle','none','FaceColor','interp');
view([90 90]);
ylabel('Freq (Hz)'); xlabel('a (a_0)');
title('Na periodogram');

set(gca, 'CLim', [0, colorlimit]);
colorbar
figure(6);
surf(X,Y,(pxx2),'EdgeColor','none','LineStyle','none','FaceColor','interp');
view([90 90]);
set(gca, 'CLim', [0, colorlimit]);
ylabel('Freq (Hz)'); xlabel('a (a_0)');
title('K periodogram');
colorbar
