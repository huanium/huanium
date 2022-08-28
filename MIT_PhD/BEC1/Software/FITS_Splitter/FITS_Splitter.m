%%% split FITS file with 6 kinetic shots into two files
%%% each containing 3 shots: w/ atoms, w/o, and dark
%%% two files are TopA and TopB

%%% Huan Q. Bui
%%% date: Jun 15, 2022

clear all

while true    
    source_dir = "/home/huanium/huanium/MIT PhD/BEC1/Software/FITS_Splitter/source_folder";
    out_dir = "/home/huanium/huanium/MIT PhD/BEC1/Software/FITS_Splitter/output_folder";
    archive_dir = "/home/huanium/huanium/MIT PhD/BEC1/Software/FITS_Splitter/archive_folder";

    %%% count number of fits files in the source folder
    a = dir(fullfile(source_dir,"*.fits"));
    num = size(a,1);
    
    if num >= 1
        disp("Processing...")        
        % split FITS images to output folder, else do nothing
        % work on the first file only, then loop back :)
        dataA = [];
        dataB = [];
        
        combined_fits_loc = source_dir + "/" + a(1).name;
        date_data = a(1).name(1:end-14);
        
        data_combined = fitsread(combined_fits_loc);
        % order being: AW,BW,AWO,BWO,AD,BD
        
        dataA(:,:,1) = data_combined(:,:,1); % AW
        dataA(:,:,2) = data_combined(:,:,3); % AWO
        dataA(:,:,3) = data_combined(:,:,5); % AD
        
        dataB(:,:,1) = data_combined(:,:,2); % BW
        dataB(:,:,2) = data_combined(:,:,4); % BWO
        dataB(:,:,3) = data_combined(:,:,6); % BD
        
        dataA = int16(dataA);
        dataB = int16(dataB);
        
        A_destination = out_dir + "/" + date_data + "_TopA.fits";
        B_destination = out_dir + "/" + date_data + "_TopB.fits";
        
        fitswrite(dataA, A_destination);
        fitswrite(dataB, B_destination);  
        
        % move original file to a different folder to clear source_dir:
        movefile(combined_fits_loc, archive_dir)        
        
    else
        disp("No files found. Continuing...")
    end
        
    %%% repeat task every 1s
    pause(1);
    disp("Stop now or wait 2s")
    pause(2);
    disp("   ")
    
end
