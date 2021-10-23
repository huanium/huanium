function I = GaussianBeamIntensity(lambda,waist,power,posVec)
    x = posVec(1,:);
    y = posVec(2,:);
    z = posVec(3,:);
    RayleighLength = pi*waist^2/lambda;
    waistZ = waist.*sqrt(1+(z./RayleighLength).^2);
    I = 2*power/pi/waist.^2.*(waist./waistZ).^2.*exp(-2.*(x.^2+y.^2)./waistZ.^2);
end