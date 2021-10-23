function averageRadiallyElliptical(this,currentImageIdx,varargin)

p = inputParser;

p.addParameter('BECTFx',NaN);
p.addParameter('BECTFy',NaN);
p.addParameter('BECx',NaN);
p.addParameter('BECy',NaN);
p.parse(varargin{:});
BECTFx  = p.Results.BECTFx;
BECTFy  = p.Results.BECTFy;
BECx  = p.Results.BECx;
BECy  = p.Results.BECy;

if(isnan(BECTFx)||isnan(BECTFy)||isnan(BECx)||isnan(BECy))
    if(~isfield(this.analysis, 'fit2DGauss'))
        this.fit2DGaussian(currentImageIdx);
    end
    if(length(this.analysis.fit2DGauss.param(:,1))<currentImageIdx)
        this.fit2DGaussian(currentImageIdx);
    end
    
    xcen = this.analysis.fit2DGauss.param(currentImageIdx,3);
    widthx = this.analysis.fit2DGauss.param(currentImageIdx,5);
    ycen = this.analysis.fit2DGauss.param(currentImageIdx,4);
    widthy = this.analysis.fit2DGauss.param(currentImageIdx,5)*this.analysis.fit2DGauss.param(currentImageIdx,6);
else
    xcen = BECx;
    widthx = BECTFx;
    ycen = BECy;
    widthy = BECTFy;
end

if strcmp(this.settings.plotImage,'original')
    croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
elseif strcmp(this.settings.plotImage,'filtered')
    croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
end

dsx = length(croppedODImage(:,1));
dsy = length(croppedODImage(1,:));

binwid = 1/(sqrt(widthx*widthy));
pix = 1;
%--------------------------------------------------------------------------
% Transforms detector signal into a radial intensity distribution
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%Determine the maximal circle within the croppedAtomImage
%--------------------------------------------------------------------------
if xcen < dsx/2
    rxmax = xcen*pix;
else
    rxmax = (dsx-xcen)*pix;
end
if ycen < dsy/2
    rymax = ycen*pix;
else
    rymax = (dsy-ycen)*pix;
end
if rxmax < rymax
    rmax = rxmax;
else
    rmax = rymax;
end
%--------------------------------------------------------------------------
%Converting into 1-D radial intensity distribution and scale modulation
%--------------------------------------------------------------------------
[yrange,xrange] = size(croppedODImage);
for idx = 1:xrange
    for idy = 1:yrange
        radius = sqrt(((idx-.5-xcen)/widthx)^2+((idy-.5-ycen)/widthy)^2);
        value(idx+yrange*(idy-1),2) = radius;
        value(idx+yrange*(idy-1),3) = croppedODImage(idy,idx);
    end
end
value(:,2) = value(:,2)*pix;
value = sortrows(value,2);

%--------------------------------------------------------------------------
%Reduce data to r<=rmax
%--------------------------------------------------------------------------
[maxval,maxpos] = min(abs(value(:,2)-rmax/sqrt(widthx*widthy)));
value = value(1:maxpos,:);

%--------------------------------------------------------------------------
%Binning the points of binwidth
%--------------------------------------------------------------------------
binup = round(max(value(:,2)));
for jdx = 1 : 1 : binup/binwid
    ind = find(value(:,2)< jdx*binwid & value(:,2)>(jdx-1)*binwid); %searches for entries within bin
    no = size(ind);
    nos(jdx) = no(1);
    binned(jdx,1) = mean(value(ind,2));
    binned(jdx,4) = sqrt(sum((value(ind,2)-binned(jdx,1)).^2))/no(1);
    binmean = mean(value(ind,3));
    binned(jdx,2) = binmean;
    if no(1) == 1
        binned(jdx,3) = 0.025*binned(jdx,2);
    else
        binned(jdx,3) = sqrt(sum((value(ind,3)-binmean).^2))/no(1);
    end
end

%--------------------------------------------------------------------------
%Clean of entries with NaN
%--------------------------------------------------------------------------
erase = isnan(binned);
k = 0;
for jdx = 1 : 1 : binup/binwid
    if erase(jdx,2) ~= 1
        k = k+1;
        hilfs(k,:) = binned(jdx,:);
    end
end
binned = hilfs;
this.analysis.averagedElliptical.radialCoordinates(currentImageIdx,:) = NaN(1,min(this.settings.marqueeBox(3),this.settings.marqueeBox(4))+1);
this.analysis.averagedElliptical.radialAverageOD(currentImageIdx,:)   = NaN(1,min(this.settings.marqueeBox(3),this.settings.marqueeBox(4))+1);

this.analysis.averagedElliptical.radialCoordinates(currentImageIdx,1:length(binned(:,1)))  = sqrt(widthx*widthy)*[binned(:,1)'];
this.analysis.averagedElliptical.radialAverageOD(currentImageIdx,1:length(binned(:,1)))    = [binned(:,2)'];

this.settings.inverseAbel.widthx = widthx;
this.settings.inverseAbel.widthy = widthy;

