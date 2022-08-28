d = 101;
center = 51;
radiusX = 40;
radiusY = 20;
density = 1;

sphere = zeros(d,d,d);
fun = @(idx,idy,idz) sqrt(((idx-center)/radiusX)^2+((idy-center)/radiusY)^2+((idz-center)/radiusX)^2)<=1;

for idx = 1:d
    for idy = 1:d
        for idz = 1:d
            sphere(idx,idy,idz) = density*fun(idx,idy,idz);
        end
    end
end

sphere2D = sum(sphere,3);

measTest = Measurement('testing','imageStartKeyword','K','sortFilesBy','name');
measTest.settings.marqueeBox(1) = 1;
measTest.settings.marqueeBox(2) = 1;
measTest.settings.marqueeBox(3) = d;
measTest.settings.marqueeBox(4) = d;

measTest.analysis.fit2DGauss.param(1,:) = [0,1,center,center,radiusY,radiusX/radiusY,0];
measTest.images.ODImages(1,:,:) = sphere2D;
figure(14),clf;
measTest.plotODImage(1);
measTest.inverseAbel(1);

%%
d = 101;
center = 51;
radiusX = 40;
density = 1;

sphere = zeros(d,d,d);
fun = @(idx,idy,idz) sqrt((idx-center)^2+(idy-center)^2+(idz-center)^2)<=radiusX;

for idx = 1:d
    for idy = 1:d
        for idz = 1:d
            sphere(idx,idy,idz) = 1/radiusX*(radiusX-sqrt((idx-center)^2+(idy-center)^2+(idz-center)^2))*density*fun(idx,idy,idz);
        end
    end
end

sphere2D = sum(sphere,3);

measTest = Measurement('testing','imageStartKeyword','K','sortFilesBy','name');
measTest.settings.marqueeBox(1) = 1;
measTest.settings.marqueeBox(2) = 1;
measTest.settings.marqueeBox(3) = d;
measTest.settings.marqueeBox(4) = d;

measTest.analysis.fit2DGauss.param(1,:) = [0,1,center,center,radiusY,radiusX/radiusX,0];
measTest.images.ODImages(1,:,:) = sphere2D;
figure(14),clf;
measTest.plotODImage(1);
measTest.inverseAbel(1);


%%
d = 201;
center = 101;
radiusX = 80;
radiusInner = 40;
density = 10;

sphere = zeros(d,d,d);
fun = @(idx,idy,idz) sqrt((idx-center)^2+(idy-center)^2+(idz-center)^2)<=radiusX;
fun2 = @(idx,idy,idz) radiusInner<=sqrt((idx-center)^2+(idy-center)^2+(idz-center)^2);


for idx = 1:d
    for idy = 1:d
        for idz = 1:d
            sphere(idx,idy,idz) = density*fun(idx,idy,idz)*fun2(idx,idy,idz);
        end
    end
end

sphere2D = sum(sphere,3);
sphere1D = sum(sphere2D,2);

measTest = Measurement('testing','imageStartKeyword','K','sortFilesBy','name');
measTest.settings.marqueeBox(1) = 1;
measTest.settings.marqueeBox(2) = 1;
measTest.settings.marqueeBox(3) = d;
measTest.settings.marqueeBox(4) = d;

measTest.analysis.fit2DGauss.param(1,:) = [0,1,center,center,radiusY,radiusX/radiusX,0];
measTest.images.ODImages(1,:,:) = sphere2D;
figure(14),clf;
measTest.plotODImage(1);
measTest.inverseAbel(1);
figure(15), plot(sphere1D,'LineWidth',2)

%%
d = 101;
center = 51;
radiusX = 40;
radiusInner = 20;
density = 10;

sphere = zeros(d,d,d);
fun = @(idx,idy,idz) sqrt((idx-center)^2+(idy-center)^2+(idz-center)^2)<=radiusX;
fun2 = @(idx,idy,idz) radiusInner<=sqrt(((idx-center)*1.2)^2+((idy-center)/1)^2+((idz-center)/1)^2);


for idx = 1:d
    for idy = 1:d
        for idz = 1:d
            sphere(idx,idy,idz) = density*fun(idx,idy,idz)*fun2(idx,idy,idz);
        end
    end
end

sphere2D = sum(sphere,3);
sphere1D = sum(sphere2D,2);

measTest = Measurement('testing','imageStartKeyword','K','sortFilesBy','name');
measTest.settings.marqueeBox(1) = 1;
measTest.settings.marqueeBox(2) = 1;
measTest.settings.marqueeBox(3) = d;
measTest.settings.marqueeBox(4) = d;

measTest.analysis.fit2DGauss.param(1,:) = [0,1,center,center,radiusY,radiusX/radiusX,0];
measTest.images.ODImages(1,:,:) = sphere2D;
figure(14),clf;
measTest.plotODImage(1);
measTest.inverseAbel(1);
figure(15), plot(-50:50,sphere1D,'LineWidth',2)