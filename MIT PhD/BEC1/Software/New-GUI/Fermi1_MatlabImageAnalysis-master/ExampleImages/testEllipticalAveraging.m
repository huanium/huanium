measTest = Measurement('testing','imageStartKeyword','K','sortFilesBy','name');

fitfun = @(p,x) p(1)+p(2)*exp( -(...
                ( x(:,:,1)*cosd(p(7))-x(:,:,2)*sind(p(7)) - p(3)*cosd(p(7))+p(4)*sind(p(7)) ).^2/(2*p(5)^2) + ...
                ( x(:,:,1)*sind(p(7))+x(:,:,2)*cosd(p(7)) - p(3)*sind(p(7))-p(4)*cosd(p(7)) ).^2/(2*(p(5)*p(6))^2) ) );
            
measTest.settings.marqueeBox(1) = 1;
measTest.settings.marqueeBox(2) = 1;
measTest.settings.marqueeBox(3) = 40;
measTest.settings.marqueeBox(4) = 60;
   
[x,y]=meshgrid(1:measTest.settings.marqueeBox(3)+1,1:measTest.settings.marqueeBox(4)+1); pixel=zeros(measTest.settings.marqueeBox(4)+1,measTest.settings.marqueeBox(3)+1,2); pixel(:,:,1)=x; pixel(:,:,2)=y;

measTest.analysis.fit2DGauss.param(1,:) = [0,1,20,10,5,1.5,0];
measTest.images.ODImages(1,:,:) = fitfun(measTest.analysis.fit2DGauss.param(1,:),pixel);
measTest.plotODImage(1)
measTest.plotEllipticalAverage(1);
            