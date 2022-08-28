function programFBSetPointOnAWG_withSuckingInBeforeJump(FieldValues,DurationsInMS)
% FieldValues array of 3 Values in Gauss
% DurationsInMS array of 4 Values in ms

%% compensate SG = 1.022G at setpoint = 1.2, By is powered off

% FieldValues(2) = FieldValues(2)-1.022;
% FieldValues(3) = FieldValues(3)-1.022;

%ConstantSGByFieldOffset = -1.1235; %good for setpoint 1.2 --> 44A
% ConstantSGByFieldOffset = -1.3545; % good for setpoint 1.435 --> 53A
% FieldValues(2) = FieldValues(2)+ConstantSGByFieldOffset;
% FieldValues(3) = FieldValues(3)+ConstantSGByFieldOffset;

% calibrated on 190903
ConstantSGByFieldOffset = -1.3545-0.2; % good for setpoint 1.435 --> 53A 
ConstantSGByFieldOffset = -1.4545; % good for setpoint 2.5V CC mode 50A, Jan 29 2020


FieldValues(2) = FieldValues(2);
FieldValues(3) = FieldValues(3)+ConstantSGByFieldOffset;
FieldValues(4) = FieldValues(4)+ConstantSGByFieldOffset;

DurationTotal = sum(DurationsInMS);
ntotalSamples = 50000;
timePerSample = DurationTotal/ntotalSamples;

FieldRamp = FieldValues(1)*ones(1,ntotalSamples);

SampleEndFirstLinear = round(ntotalSamples*DurationsInMS(1)/DurationTotal);
SampleEndSGRamp = SampleEndFirstLinear+round(ntotalSamples*DurationsInMS(2)/DurationTotal);
SampleEndFirstPlateau = SampleEndSGRamp+round(ntotalSamples*DurationsInMS(3)/DurationTotal);
SampleEndFirstRamp = SampleEndFirstPlateau+round(ntotalSamples*DurationsInMS(4)/DurationTotal);
SampleEndSecondPlateau = SampleEndFirstRamp+round(ntotalSamples*DurationsInMS(5)/DurationTotal);
SampleEndThirdPlateau = SampleEndSecondPlateau+round(ntotalSamples*DurationsInMS(6)/DurationTotal);

FieldRamp(1:SampleEndFirstLinear) = ((1:SampleEndFirstLinear)-1)/(SampleEndFirstLinear-1)*(FieldValues(2)-FieldValues(1))+FieldValues(1);
FieldRamp(SampleEndFirstLinear+1:SampleEndSGRamp) = (((SampleEndFirstLinear+1):SampleEndSGRamp)-(SampleEndFirstLinear+1))/(SampleEndSGRamp-(SampleEndFirstLinear+1))*(FieldValues(2)+ConstantSGByFieldOffset-FieldValues(2))+FieldValues(2);
FieldRamp(SampleEndSGRamp+1:SampleEndFirstPlateau) = FieldValues(2)+ConstantSGByFieldOffset;
FieldRamp(SampleEndFirstPlateau+1:SampleEndFirstRamp) = (((SampleEndFirstPlateau+1):SampleEndFirstRamp)-(SampleEndFirstPlateau+1))/(SampleEndFirstRamp-(SampleEndFirstPlateau+1))*(FieldValues(3)-(FieldValues(2)+ConstantSGByFieldOffset))+FieldValues(2)+ConstantSGByFieldOffset;
FieldRamp(SampleEndFirstRamp+1:SampleEndSecondPlateau) = FieldValues(3);
FieldRamp(SampleEndSecondPlateau+1:SampleEndThirdPlateau) = (((SampleEndSecondPlateau+1):SampleEndThirdPlateau)-(SampleEndSecondPlateau+1))/(SampleEndThirdPlateau-(SampleEndSecondPlateau+1))*(FieldValues(4)-(FieldValues(3)+ConstantSGByFieldOffset))+FieldValues(3)+ConstantSGByFieldOffset;

if DurationsInMS(6)>0.1
    StepInGauss = 0;
else
    StepInGauss = FieldValues(4)-FieldValues(3);
end
times   = timePerSample*(0:length(FieldRamp(SampleEndThirdPlateau+1:end))-1);
amp1     = 0.03597;
drift1   = 1/0.3092;

amp2     = 0.05345;
drift2   = 0.5893;


FieldRamp(SampleEndThirdPlateau+1:end) = FieldValues(4)+StepInGauss*amp1*exp(-times/drift1)+StepInGauss*amp2*exp(-times/drift2);


Slope=0.026873;
OffSet=0.031583;
%27-08-2019 recalibrated
Slope=0.02686;
OffSet=0.03232;
%jan 29 2020
Slope=0.02807;
OffSet=-0.0561;
%Jul 2020
Slope=0.027390784598184;
OffSet=-0.002881719727214;

FieldToSetpoint = @(FieldInGauss) FieldInGauss*Slope+OffSet;
voltageRamp = (FieldToSetpoint(FieldRamp));
rescaledVoltageRamp = ((voltageRamp-min(voltageRamp))./(max(voltageRamp)-min(voltageRamp)) - 0.5) * 2;


TransFreq = BreitRabiInMHz(FieldValues(end)-ConstantSGByFieldOffset,-7/2,-9/2);

fprintf('-7/2 -> -9/2 transition: %.3fMHz; Final Setpoint: %.4fV \n',TransFreq,(voltageRamp(end)));

%% output a values in Bohr
%-7/2 resonances
m7Bres1 = 81.61;
m7Bres2 = 90.47;
m7Bres3 = 111.8;

m7Bzx1 = m7Bres1-0.34 ;
m7Bzx2 = m7Bres2-7.93;
m7Bzx3 = m7Bres3-19;

%%%% TIEMANN theory
m7Bres1 = 81.65;
m7Bres2 = 90.40;
m7Bres3 = 110.3;

m7Bzx1 = m7Bres1-0.30 ;
m7Bzx2 = m7Bres2-6.50;
m7Bzx3 = m7Bres3-17.05;

%%%%% End Tiemann theory

m7Bres = [m7Bres1;m7Bres2;m7Bres3];
m7Bzx = [m7Bzx1;m7Bzx2;m7Bzx3];
m7deltaB = m7Bres-m7Bzx;
%BG scattering length for -7/2 at 90G
abgm7=-710;

asc_m7 = @(B) fb_fun(m7deltaB,m7Bres,B,abgm7);
% -9/2 resonances
m9Bres1 = 78.41;
m9Bres2 = 89.1;

m9Bzx1 = m9Bres1-5.2;
m9Bzx2 = m9Bres2-8.8;

%%%%% Tiemann theory

m9Bres1 = 78.35;
m9Bres2 = 89.80;

m9Bzx1 = m9Bres1-5.80;
m9Bzx2 = m9Bres2-9.55;
%%%%%% end Tiemann theory

m9Bres = [m9Bres1;m9Bres2];
m9Bzx = [m9Bzx1;m9Bzx2];
m9deltaB = m9Bres-m9Bzx;
abgm9=-730; %BG scattering of -9/2 according to ABM model, at 90G

asc_m9 = @(B) fb_fun(m9deltaB,m9Bres,B,abgm9);

fprintf('-9/2 scattering length: %.0f a_Bohr; -7/2 scattering length: %.0f a_Bohr \n',asc_m9(FieldValues(end)-ConstantSGByFieldOffset),asc_m7(FieldValues(end)-ConstantSGByFieldOffset));


%% actual programming

AWG = visa('NI', 'USB0::0x05E6::0x3390::1407763::0::INSTR');
set(AWG, 'OutputBufferSize', 4000100);
fopen(AWG);


cmd = 'DATA VOLATILE';
for i=1:length(rescaledVoltageRamp)
    cmd = sprintf('%s,%.5f', cmd, rescaledVoltageRamp(i));
end
fprintf(AWG, cmd);
fprintf(AWG, 'DATA:COPY ARB_1, VOLATILE');
fprintf(AWG, 'FUNC:USER ARB_1');
fprintf(AWG, 'FUNC:SHAP USER');

rate = 1;

fprintf(AWG,'%s', sprintf('FREQ %.7f', 1000/(DurationTotal)));
fprintf(AWG, '%s', sprintf('VOLT %.5f', (max(voltageRamp)-min(voltageRamp))));
fprintf(AWG, '%s', sprintf('VOLT:OFFS %.5f', 0.5*(max(voltageRamp)+min(voltageRamp))));
%fprintf(AWG, '%s', 'OUTP:LOAD 50');
%fprintf(test, '%s', sprintf('APPLy:DC DEF,DEF,%d', 2));
%                     fprintf(this.vi,'%s', sprintf('FREQ %.7f', this.settings.rate/length(this.data)*1e6));
%                     fprintf(this.vi, '%s', sprintf('VOLT %.5f', (max(this.data)-min(this.data))));
%                     fprintf(this.vi, '%s', sprintf('VOLT:OFFS %.5f', 0.5*(max(this.data)+min(this.data))));

%set burst mode
 fprintf(AWG, 'BURS:MODE TRIG');
 fprintf(AWG, '%s', sprintf('BURS:NCYC %d', 1));
 fprintf(AWG, 'TRIG:SOUR EXT');
 fprintf(AWG, 'BURS:STAT ON');
 fprintf(AWG, 'BURS:PHASE 0');
 fprintf(AWG, '%s', 'OUTP:LOAD INF'); %must be high z or everything is off by 2x
 fprintf(AWG, 'OUTP ON');
 

fclose(AWG);
delete(AWG)
clear AWG


end

function out = fb_fun(deltaB,Bres,B,abg)
%abg = -800; %background scattering length

out = abg*(1+deltaB(1)./(B-Bres(1)));
for i = 2:size(deltaB,1)
    out = out.*(1+deltaB(i)./(B-Bres(i)));
end

end