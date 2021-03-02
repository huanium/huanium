% Author: Huan Q. Bui
% Colby College '21
% Date: Aug 07, 2020



clear
close all

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%


%%% max |\phi^(n) (x)| vs. n  %%%%%%%
 
support_bound = 400;
n = 0:10:100;
sup = [];
scaled_sup = [];
muP = 1/2+1/4;
%muP = 1/2 + 1/8;
%muP = 1/2 + 1/2;
for n_times = n
    %A = (n_times^muP)*abs(fast_convolve(n_times, support_bound));
    M = max(abs(fast_convolve(n_times, support_bound)) , [], 'all'); % find max;
    sup = [sup M]; % concatenate
    scaled_sup = [scaled_sup (n_times^muP)*M]; % concatenate
    disp(['Progress: ' num2str(n_times)]);
end
% figure for SUP
figure(1)
%plot(n,sup, '-o', 'color','blue', 'LineWidth', 1)
plot(log(n),log(sup), '-o', 'color','blue', 'LineWidth', 1) % plot log instead
%xlim([0 max(n)])
%ylim([-0.01 0.7])
xlabel('log(n)', 'FontSize',16);
ylabel('', 'FontSize', 16 );
% figure for SCALED_SUP
hold on 
nY = n.^(-muP);
%plot(n, nY, 'LineWidth', 2)
plot(log(n), log(nY), 'LineWidth', 2)  % plot log instead
hold off
legend('f(n) = log(max_{K}|\phi^{(n)}|)','log(n^{-\mu_\phi}) = log(n^{-3/4})', 'FontSize',14);

figure(2)
plot(n,scaled_sup, '-o', 'color','blue', 'LineWidth', 1)
xlim([0 max(n)])
ylim([0 1.8])
xlabel('n', 'FontSize',16);
legend('n^{\mu_\phi} \cdot f(n) = n^{3/4}f(n)', 'FontSize',14)





%%%%%%% PLOT THE CONVOLUTION POWER %%%%%%%

% figure
% n_times = 10000;
% support_bound = 1000;
% disp('Calculating...');
% % tic
% data = real(fast_convolve(n_times, support_bound));    % plot the real part
% %data = imag(fast_convolve(n_times, support_bound));    % plot the img part
% %data = abs(fast_convolve(n_times, support_bound));      % plot the abs
% dim = size(data);
% x = floor(-dim(1)/2)+1:1:floor(dim(1)/2);
% y = floor(-dim(2)/2)+1:1:floor(dim(2)/2);
% [X, Y] = meshgrid(x, y);
% s = surf(X, Y, data, 'LineWidth',0.5,'edgecolor','black', 'EdgeAlpha', 0.2 , 'FaceAlpha',1);
% %s = surfc(X, Y, data, 'LineWidth',0.2,'edgecolor','black', 'EdgeAlpha', 0.25 , 'FaceAlpha',0.6);
% xlabel('X', 'FontSize',16);
% ylabel('Y', 'FontSize',16);
% title(['Re(\phi^{(', num2str(n_times), ')})'], 'FontSize', 16 );
% %title(['|\phi^{(', num2str(n_times), ')}|'], 'FontSize', 16 );
% %colorbar;
% %s = meshc(X, Y, data);
% xlabel('X');
% ylabel('Y');
% %xlim([-floor(dim(1)/2)  floor(dim(2)/2)]);
% %ylim([-floor(dim(1)/2)  floor(dim(2)/2)]);
% 
% xlim([-floor(dim(1)/4)  floor(dim(2)/4)]);
% ylim([-floor(dim(1)/4)  floor(dim(2)/4)]);
% box off



%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%



%------- Fast Convolve ----------

function conv_power = fast_convolve(n_times, support_bound)

% EXAMPLE 0 in the paper
% Phi = zeros(5,5);
% shift = floor(5/2)+1;
% 
% Phi( 0+shift, 0+shift)  =  (1/192)*(144 - 64i);
% Phi( 1+shift, 0+shift)  = (1/192)*(16 + 16i);
% Phi(-1+shift, 0+shift)  = (1/192)*(16 + 16i);
% Phi( 2+shift, 0+shift)  = -4*(1/192) ;
% Phi(-2+shift, 0+shift)  = -4*(1/192)  ;    
% Phi( 0+shift, 1+shift)  = (1/192)*(16+16i);
% Phi( 0+shift,-1+shift)  = (1/192)*(16+16i);
% Phi( 0+shift, 2+shift)  = -4*(1/192);
% Phi( 0+shift,-2+shift)  = -4*(1/192);
% Phi( -1+shift, -1+shift)  = (1/192)*1i;  
% Phi( 1+shift, -1+shift)  = -(1/192)*1i;   
% Phi( -1+shift, 1+shift)  = -(1/192)*1i;  
% Phi( 1+shift, 1+shift)  = (1/192)*1i;  

% % EXAMPLE 3 in the paper
% Phi = zeros(17,17);
% shift = floor(17/2)+1;
% % second example with cross term, E = diag(1/2,1/8)
% % mono terms
% Phi( 0+shift, 0+shift)  = complex(26527/32768,-43/192);
% Phi( -1+shift,0+shift)  = complex(253/3072,1/48);
% Phi( 1+shift, 0+shift)  = complex(259/3072,1/48);
% Phi( 2+shift,shift)  = -1/48;
% Phi( -2+shift,shift)  = -1/48;
% Phi( shift, -1 + shift)  = complex(715/12288,7/48);
% Phi( shift, +1 + shift)  = complex(715/12288,7/48);
% Phi(shift, -2+shift)  = -complex(1001/24576,7/96);
% Phi(shift,  2+shift)  = -complex(1001/24576,7/96);
% Phi( 0+shift, -3+shift)  = complex(91/4096,1/48);
% Phi( 0+shift, 3+shift)  = complex(91/4096,1/48);
% Phi( shift,  4+shift)  = -complex(455/49152,1/384);
% Phi( shift, -4+shift)  = -complex(455/49152,1/384);
% Phi( 0+shift, 5+shift)  = 35/12288;
% Phi(-0+shift, -5+shift)  = 35/12288;
% Phi( 0+shift, 6+shift)  = -5/8192;
% Phi(-0+shift, -6+shift)  = -5/8192;
% Phi( 0+shift, 7+shift)  = 1/12288;
% Phi(-0+shift, -7+shift)  = 1/12288;
% Phi( 0+shift, 8+shift)  = -1/196608;
% Phi(-0+shift, -8+shift)  = -1/196608;
% 
% % cross terms
% Phi(-1 +shift, -2+shift)  = 1/1536;
% Phi( 1 +shift, -2+shift)  = -1/1536;
% Phi(-1 +shift, +2+shift)  = 1/1536;
% Phi( 1 +shift, +2+shift)  = -1/1536;
% Phi(-1 +shift, -4+shift)  = -1/6144;
% Phi( 1 +shift, -4+shift)  = 1/6144;
% Phi(-1 +shift, +4+shift)  = -1/6144;
% Phi( 1 +shift, +4+shift)  = 1/6144;



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

% %%%%% EXAMPLE 1 in PAPER %%%%%%%%%%%
% Phi = zeros(9,9);
% shift = floor(9/2)+1;
% 
% % mono terms 
% Phi( 0+shift, 0+shift)  = complex(173/256,-7/32);
% Phi( 1+shift, 0+shift)  = complex(1/8,1/16);
% Phi(-1+shift, 0+shift)  = complex(1/8,1/16);
% Phi( 2+shift, 0+shift)  = -1/32;
% Phi(-2+shift, 0+shift)  = -1/32;
% Phi( 0+shift, 1+shift)  = complex(7/64,1/16);
% Phi( 0+shift,-1+shift)  = complex(7/64,1/16);
% Phi( 0+shift, 2+shift)  = -complex(7/128,1/64);
% Phi( 0+shift,-2+shift)  = -complex(7/128,1/64);
% Phi( 0+shift, 3+shift)  = 1/64;
% Phi( 0+shift,-3+shift)  = 1/64;
% Phi( 0+shift, 4+shift)  = -1/512;
% Phi( 0+shift,-4+shift)  = -1/512;



%%%%% EXAMPLE 2 in PAPER %%%%%%%%%%%
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
    
    

        
    
    


