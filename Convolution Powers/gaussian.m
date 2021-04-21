% plot Gaussian 

mu = [0 0];
Sigma = [1 0; 0 1];


x1 = -4:0.2:4;
x2 = -4:0.2:4;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

y = mvnpdf(X,mu,Sigma);
y = reshape(y,length(x2),length(x1));

surf(x1,x2,y)
xlabel('x1')
ylabel('x2')
