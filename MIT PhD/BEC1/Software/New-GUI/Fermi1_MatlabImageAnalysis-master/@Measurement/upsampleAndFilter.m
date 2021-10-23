function [ imageSc ] = upsampleAndFilter(this,image)
%imageinterpolate  Increase imageage size by Whittacker-Shannon interpolation 
    assert(ismatrix(image), '2D imageage required');
    
    scale = this.settings.superSamplingFactor;
    radius = 333*1/this.settings.AbbeRadius;
    
    m = size(image,1);
    n = size(image,2);
    
    [columnsInImage, rowsInImage] = meshgrid(1:n, 1:m);
    centerX = n/2;
    centerY = m/2;
    
    mask = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2 <= radius.^2;
    
    imageFFT = zeros(size(image)*scale);
    imagem = fftshift(fft2(image)) .* mask;
    imageFFT((1:m)+floor(m/2)*(scale-1),(1:n)+floor(n/2)*(scale-1)) = imagem;
    
    imageSc = abs(ifft2(ifftshift(imageFFT))); % reconstructed imageage
end
