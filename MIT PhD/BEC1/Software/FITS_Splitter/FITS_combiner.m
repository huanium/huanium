addressA = "/home/huanium/huanium/MIT PhD/BEC1/Software/FITS_Splitter/source_folder/ignore/04-07-2022_15_50_46_TopA.fits";
addressB = "/home/huanium/huanium/MIT PhD/BEC1/Software/FITS_Splitter/source_folder/ignore/04-07-2022_15_50_46_TopB.fits";

dataA = int16(fitsread(addressA, 'primary'));
dataB = int16(fitsread(addressB, 'primary'));


data_combined = [];
data_combined(:,:,1) = dataA(:,:,1); % AW
data_combined(:,:,2) = dataB(:,:,1); % BW
data_combined(:,:,3) = dataA(:,:,2); % AWO
data_combined(:,:,4) = dataB(:,:,2); % BWO
data_combined(:,:,5) = dataA(:,:,3); % AD
data_combined(:,:,6) = dataB(:,:,3); % BD

data_combined = int16(data_combined);

target_file = "/home/huanium/huanium/MIT PhD/BEC1/Software/FITS_Splitter/source_folder/2022-04-07_15-50-46_combined.fits";

fitswrite(data_combined, target_file)