function programTiSaShortPulse(highVoltage,PulseTimeinMuS)

rate = 50;
samplesHigh = round(PulseTimeinMuS*rate);

voltageRamp = [0,highVoltage*ones(1,samplesHigh),0];
%voltageRamp = [startV,endV*ones(1,1)];
%voltageRamp = [zeros(1,round(length(xvals)/2)),endV*ones(1,round(length(xvals)/2))];
rescaledVoltageRamp = ((voltageRamp-min(voltageRamp))./(max(voltageRamp)-min(voltageRamp)) - 0.5) * 2;


AWG = visa('NI', 'USB0::0x05E6::0x3390::1407760::0::INSTR');
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

fprintf(AWG,'%s', sprintf('FREQ %.7f', rate*1e6));
fprintf(AWG, '%s', sprintf('VOLT %.5f', (max(voltageRamp)-min(voltageRamp))));
fprintf(AWG, '%s', sprintf('VOLT:OFFS %.5f', 0.5*(max(voltageRamp)+min(voltageRamp))));
%fprintf(AWG, '%s', 'OUTP:LOAD INF');
fprintf(AWG, '%s', 'OUTP:LOAD 50');

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
 fprintf(AWG, 'OUTP ON');


fclose(AWG);

end