function [ imageSc ] = upsampleAndFilter1D(this,array1D)
%imageinterpolate  Increase imageage size by Whittacker-Shannon interpolation 
    assert(ismatrix(array1D), '2D imageage required');
    
    scale = this.settings.superSamplingFactor1D;
    
    m = length(array1D);
    
    %fudge filter
    fudgeFilterWidth = this.settings.fudgeWidth;
    fudgeFilterFreq = this.settings.fudgeFilterFreq;
    fudgeFilter = ones(1,m);
    if(fudgeFilterFreq<m)
        filterEdge = (1./(1+((0:m/2-fudgeFilterFreq)/fudgeFilterWidth).^5));
        fudgeFilter(1:length(filterEdge)) = fliplr(filterEdge);
        fudgeFilter(end-length(filterEdge)+1:end) = (filterEdge);
    end
   
    
    imageFFT = zeros(1,m*scale);
    imagem = fftshift(fft(array1D)) .* fudgeFilter;
    imageFFT(1,(1:m)+floor(m/2)*(scale-1)) = imagem;
    
    imageSc = abs(ifft(ifftshift(imageFFT))); % reconstructed imageage
end
