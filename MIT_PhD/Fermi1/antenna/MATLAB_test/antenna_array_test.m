%la = linearArray;
%la.NumElements = 4;
%%% layout(la);
% pattern(la, 70e6);


% % design
% ca = rectangularArray('Size',[2 2],'Element',loopCircular);
% 
% % display info:
% info(ca)
% 
% % show array
% figure(1);
% layout(ca);
% figure(2);
% show(ca);
% figure(3);
% pattern(ca, 5.6e6)
% 
% % impedance:
% figure(4);
% impedance (ca ,50e6:1e6:100e6);

material = metal('copper');
thickness = 0.03; % meters
tilt_axis = 'Z';

loop1 = loopCircular("Conductor", material, 'Thickness',thickness, ...
    'TiltAxis',tilt_axis, 'Tilt', 0);
loop2 = loopCircular("Conductor", material, 'Thickness',thickness, ...
    'TiltAxis',tilt_axis, 'Tilt', 0);
loop3 = loopCircular("Conductor", material, 'Thickness',thickness, ...
    'TiltAxis',tilt_axis, 'Tilt', 0);
loop4 = loopCircular("Conductor", material, 'Thickness',thickness, ...
    'TiltAxis',tilt_axis, 'Tilt', 0);


l1 = linearArray;
l1.Element = [loop1, loop2];
figure(1)
show(l1)

l2 = linearArray;
l2.Element = [loop3, loop4];
figure(2)
show(l2)


