%% Author: Huan Q. Bui
%% Colby College '21
%% Date: Aug 09, 2020
%%


%parpool('local', 48);

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

Z = 25:25:800000;
AbsSigmaHatX = zeros(length(Z),1);
AbsSigmaHatY = zeros(length(Z),1);

alpha0 = 1/4; 
beta0  = 1/4;

%EstimateX = 1./((abs(Z.^(1))).^(alpha0));
%EstimateY = 1./((abs(Z.^(1))).^(beta0 ));

for r = 1:length(Z)
    [Sx,Sy] = SigHat(Z(r));
    AbsSigmaHatX(r) = abs(Sx);
    AbsSigmaHatY(r) = abs(Sy);
    disp(['Evaluations: ' num2str(r) ' out of ' num2str(length(Z))]);
end

% no plotting here, just generate the data

filename = 'FT_Sigma_Estimate_1D_Sep_8_2020.mat';
save(filename)

%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%








