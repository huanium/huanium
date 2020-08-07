%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

n_times = 300;
support_bound = 80;
disp('Calculating...');
% tic
data = real(fast_convolve(n_times, support_bound));    
dim = size(data);
x = floor(-dim(1)/2)+1:1:floor(dim(1)/2);
y = floor(-dim(2)/2)+1:1:floor(dim(2)/2);
[X, Y] = meshgrid(x, y);
s = surfc(X, Y, data, 'LineWidth',0.1,'edgecolor','black','FaceAlpha',0.6);
%s = meshc(X, Y, data);

%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%

%%Extract X,Y and Z data from surface plot
% x=s.XData;
% y=s.YData;
% z=s.ZData;
% x=x(1,:);
% y=y(:,1);
% xnumlines = support_bound/1; 
% ynumlines = xnumlines; 
% xspacing = round(length(x)/xnumlines);
% yspacing = round(length(y)/ynumlines);
% %%Plot the mesh lines 
% % Plotting lines in the X-Z plane
% hold on
% for i = 1:yspacing:length(y)
%     Y1 = y(i)*ones(size(x)); % a constant vector
%     Z1 = z(i,:);
%     plot3(x,Y1,Z1,'-k','LineWidth',0.5);
% end
% % Plotting lines in the Y-Z plane
% for i = 1:xspacing:length(x)
%     X2 = x(i)*ones(size(y)); % a constant vector
%     Z2 = z(:,i);
%     plot3(X2,y,Z2,'-k','LineWidth',0.5);
% end
% hold off

xlabel('X');
ylabel('Y');
xlim([-floor(dim(1)/2)  floor(dim(2)/2)]);
ylim([-floor(dim(1)/2)  floor(dim(2)/2)]);
colorbar;
%toc

%------- Fast Convolve ----------

function conv_power = fast_convolve(n_times, support_bound)

% Phi = zeros(17,17);
% shift = floor(17/2)+1;
% % mono terms 
% % Phi(r,c) = Phi(x,y), like it should be... sorry Python
% Phi( 0+shift, 0+shift)  = 82909/98304-89i/384;
% Phi(-1+shift, 0+shift)  = 7/96+1i/12;     
% Phi( 1+shift, 0+shift)  = 7/96+1i/12;      
% Phi( 2+shift, 0+shift)  = -(7/192+5i/384);               
% Phi(-2+shift, 0+shift)  = -(7/192+5i/384);
% Phi( 3+shift, 0+shift)  = 1/96;               
% Phi(-3+shift, 0+shift)  = 1/96;
% Phi( 4+shift, 0+shift)  = -1/768;              
% Phi(-4+shift, 0+shift)  = -1/768;
% Phi( 0+shift,-1+shift)  = (715/12288+1i/12);
% Phi( 0+shift, 1+shift)  = (715/12288+1i/12);
% Phi( 0+shift,-2+shift)  = -(1001/24576+5i/128);
% Phi( 0+shift, 2+shift)  = -(1001/24576+5i/128);
% Phi( 0+shift,-3+shift)  = (91/4096+1i/96);
% Phi( 0+shift, 3+shift)  = (91/4096+1i/96);
% Phi( 0+shift, 4+shift)  = -(455/49152+1i/768);
% Phi( 0+shift,-4+shift)  = -(455/49152+1i/768);
% Phi( 0+shift, 5+shift)  = 35/12288;
% Phi( 0+shift,-5+shift)  = 35/12288;
% Phi( 0+shift, 6+shift)  = -5/8192;
% Phi( 0+shift,-6+shift)  = -5/8192;
% Phi( 0+shift, 7+shift)  = 1/12288;
% Phi( 0+shift,-7+shift)  = 1/12288;
% Phi( 0+shift, 8+shift)  = -1/196608;
% Phi( 0+shift,-8+shift)  = -1/196608;
% 
% % cross terms
% Phi(-2+shift,-1+shift)  = -1/192;
% Phi( 2+shift,-1+shift)  = -1/192;
% Phi(-2+shift, 1+shift)  = -1/192;
% Phi( 2+shift, 1+shift)  = -1/192;
% Phi(-2+shift,-2+shift)  =  1/768;
% Phi( 2+shift,-2+shift)  =  1/768;
% Phi(-2+shift, 2+shift)  =  1/768;
% Phi( 2+shift, 2+shift)  =  1/768;

Phi = zeros(9,9);
shift = floor(9/2)+1;

% mono terms 
Phi( 0+shift, 0+shift)  = (301/384-7i/48);
Phi(-1+shift,-0+shift)  = (7/96+1i/24);
Phi( 1+shift, 0+shift)  = (3/32+1i/24);
Phi( 2+shift, 0+shift)  = -1/48;
Phi(-2+shift,-0+shift)  = -1/48;
Phi( 0+shift, 1+shift)  = (7/96+1i/24);
Phi(-0+shift,-1+shift)  = (7/96+1i/24);
Phi( 0+shift, 2+shift)  = -(7/192+1i/96);
Phi(-0+shift,-2+shift)  = -(7/192+1i/96);
Phi( 0+shift, 3+shift)  = 1/96;
Phi(-0+shift,-3+shift)  = 1/96;
Phi( 0+shift, 4+shift)  = -1/768;
Phi(-0+shift,-4+shift)  = -1/768;

% cross terms
Phi(-1+shift,-1+shift)  =  1/192;
Phi(-1+shift, 1+shift)  =  1/192;
Phi( 1+shift, 1+shift)  = -1/192;
Phi( 1+shift,-1+shift)  = -1/192;

conv_power = Phi;

k=0;
while k < n_times
    k = k + 1;
    conv_power = conv2(Phi, conv_power, 'full');
    dim_f = size(conv_power);
    
    if dim_f(1) > support_bound || dim_f(2) > support_bound
        conv_power = cropND(conv_power, support_bound);

    end
end
end

% ------ crop ND ---------

function img = cropND(img, sup_bd)

size_img = size(img);
if sup_bd < size_img(1) && sup_bd < size_img(2)
    img = img( floor(size_img(1)/2)-floor(sup_bd/2)+1: 1 :floor(size_img(1)/2)+floor(sup_bd/2),...
        floor(size_img(2)/2)-floor(sup_bd/2)+1: 1 :floor(size_img(1)/2)+floor(sup_bd/2));
end
end
    
    

        
    
    


