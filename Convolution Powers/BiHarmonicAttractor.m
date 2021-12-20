n=200;
tau=6;

x=-100:1:100;
parfor k=1:length(x)
    h = @(z)exp(-1i*(n*z.^6/128+x(k).*z))/(2*pi);
    %g = @(z)exp(-1i*(n*z.^2/32+x(k).*z))/(2*pi);
    %g = @(z)exp(-n*(1/2+3*1i/8)*z.^4-1i*x(k).*z)/(2*pi);
    H1(k) = integral(h,-tau,tau,'RelTol',1e-14,'AbsTol',1e-14);
    %G1(k) = integral(g,-tau,tau,'RelTol',1e-14,'AbsTol',1e-14);
    G1(k) = (1-1i).*exp(2i*x(k).^2/n)./(sqrt(n*pi));
    disp(['Calculated ', num2str(k), ' out of ', num2str(length(x))])
    
    [msg, id] = lastwarn;
    warning('off', id)
end

y=x;
for k=1:length(x)
    for j=1:length(y)
        H(k,j)= H1(k)*G1(j);
        %G(k,j)=G1(j)*G1(k);
        %K(k,j)=H(k,j)+1i^(n+2*(x(k)+y(j)))*G(k,j);
    end
end
%mesh(x,y,real(H))


%axis([-75 75 -75 75 -0.007 0.007])



figure(2)

h1 = surf(x,y,real(H));
set(h1, 'LineWidth',0.1,'edgecolor','black', 'EdgeAlpha', 0.25 , 'FaceAlpha',1);
axis([-50 50 -50 50 -0.014 0.016])
view(50,20)
xlabel('x', 'FontSize',14);
ylabel('y', 'FontSize',14);

% figure(2)
% h2 = surf(x,y,real(G));
% set(h2, 'LineWidth',0.1,'edgecolor','black', 'EdgeAlpha', 0.25 , 'FaceAlpha',1);
% axis([-50 50 -50 50 -0.007 0.014])
% view(40,40)
% 
% figure(3)
% h3 = surf(x,y,real(K));
% set(h3, 'LineWidth',0.1,'edgecolor','black', 'EdgeAlpha', 0.25 , 'FaceAlpha',1);
% axis([-50 50 -50 50 -0.007 0.014])
% view(40,40)
