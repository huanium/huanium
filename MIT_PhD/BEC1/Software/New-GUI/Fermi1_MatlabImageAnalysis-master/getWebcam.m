%% run webcam with fixed values
myCam = webcam;
myCam.Saturation = 128;
myCam.Contrast = 80;
myCam.Brightness = 140;
preview(myCam);
%% stop webcam
closePreview(myCam);

%% set MB
myImg = snapshot(myCam);
figure(991),clf;
imshow(myImg);
% draw by hand 
marqueeBox = round(getrect)

%static MB
% marqueeBox = [865   489   104    35];
%marqueeBox = [868   490    66    30];


%% counts vs time 
counts = [];
t = tic;
time = [];
figure(993);clf;
xlabel('s');
while true
    time = [time;toc(t)];
    myImg = snapshot(myCam);
    regionOfInterest = myImg(marqueeBox(2):marqueeBox(2)+marqueeBox(4),marqueeBox(1):marqueeBox(1)+marqueeBox(3));
    figure(992),clf;
    imshow(regionOfInterest);
    counts(end+1) = sum(sum(regionOfInterest));
    figure(993);
    plot(time,counts)
    pause(60);
end
