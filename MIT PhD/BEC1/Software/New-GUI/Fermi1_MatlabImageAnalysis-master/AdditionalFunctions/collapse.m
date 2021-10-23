function [tU, yvalavg, yStdError, yvalavgNoWeight,yStdDev]= collapse(traw, yvals, yErr)
%This function takes a list of parameters 'traw' that can have repeats, as
%well as the y-values and optional error.  Collapses all the common 'traw'.
%If there are no weights (ie no
%confidence interval) use yErr= ones (size(traw)).  YErr is half the CI.
%Outputs an ordered list of unique parameters tU, weighted averages yvalavg, and
%optional yvalavgNoWeight = mean of yvals, neglected weighting from yErr



[tU,~,idx]=unique(traw);
n=zeros(size(traw));
for kdx=1:length(traw)
    n(kdx)= length(find(traw==traw(kdx))); %instances of parameter traw
end
nU=zeros(size(tU));
for kdx=1:length(tU)
    nU(kdx)=length(find(traw==tU(kdx)));
end

yWeights=1./yErr.^2;
yWeights(isnan(yWeights))=0; %neglect these points in the weighted average

x1=accumarray(idx, yvals.*yWeights,[],@mean);
x2=accumarray(idx, yWeights,[],@mean);
yvalavg=x1'./x2'; %weighted mean

yvalavgNoWeight=accumarray(idx,yvals,[],@mean)'; %mean

%std error = std/sqrt(n)
%method: take standard deviation of spread of yvals, divide by sqrt(n)
yStdDev=accumarray(idx,yvals,[],@std); 
yStdError=yStdDev'./sqrt(nU);

%method: take individual errorbars, average them, divide by sqrt(n).  This
%doesn't take into account the spread in yvals, though.
% yStdError=accumarray(idx,yErr./sqrt(n),[],@mean);


% figure(38);clf; 
% subplot(3,1,1);
% hold on;
% errorbar(traw,yvals,yErr,'o','MarkerFaceColor','b');
% title('Raw');
% subplot(3,1,2); hold on;
% errorbar(tU,yvalavg,yStdError,'o','MarkerFaceColor','b');
% errorbar(tU,yvalavgNoWeight,yStdError,'.','MarkerSize',20);
% legend('Weighted by yErr','Average wo weighting');
% title('Average with standard error');
% ylabel('Y value');
% xlabel('X value');
% subplot(3,1,3);
% plot(traw,n,'o','MarkerFaceColor','b');
% title('Instances');
% ylabel('Number');
end