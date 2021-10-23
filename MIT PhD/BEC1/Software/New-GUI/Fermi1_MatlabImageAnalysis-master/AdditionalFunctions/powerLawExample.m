%fit power laws using maximum likelihood estimator
%https://www.mathworks.com/matlabcentral/answers/404556-how-can-i-perform-maximum-likelihood-estimation-for-power-law-and-custom-distributions
% Generate power law random variables
alpha = 1.5 %alpha = 1.5 means a power of x=t^-2
t=rand(100,1);
t=logspace(-3,0,10);
% t=[1 3 10 30 100 300 400 500 600 700 800 900 1000];
x = t.^(1/(1-alpha)); 
power=1/(1-alpha)
% x=t.^alpha;
figure(9);clf; hold on;
plot(t,x,'.');
set(gca,'YScale','log','XScale','log');


% Fit that using log(alpha) to avoid problems with alpha <= 0
p = mle(x,'logpdf',@mylogpdf,'start',.5)
% p = mle(KParams(posIdx,2),'logpdf',@mylogpdf,'start',.5)
alphahat = exp(p) 

% Compare with data
figure(10);clf;hold on;
h = histogram(x,'normalization','pdf');
ax = gca;
ylim = ax.YLim;

hold on
xgrid = linspace(min(x),max(x));
plot(xgrid,exp(mylogpdf(xgrid,p,min(x))))
hold off

ax.YLim = ylim;


% log pdf function taking log(alpha)
function logf = mylogpdf(x,logalpha,xmin)
alpha = exp(logalpha);

if nargin<3
    xmin = min(x);
end
 
% f = ((alpha-1)/xmin) * (x/xmin).^-alpha;

logf = log(alpha-1) - log(xmin) - alpha*log(x/xmin);
logf(x<xmin) = -Inf;

end