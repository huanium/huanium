nNa=3.5e19*[1]; %Na density per meter
contactPerMeter=40*nNa.^(1/3); %per K atom, at maximum interaction + Na density
aIB=-3870*aBohr;
% aIB=0.0001;
d=nNa.^(-1/3);
Nbosons=contactPerMeter/(4*pi).*(d-d.^2/aIB);
% figure(1);clf;
% plot(nNa,contactPerMeter);
% figure(2);clf;plot(nNa,Nbosons)