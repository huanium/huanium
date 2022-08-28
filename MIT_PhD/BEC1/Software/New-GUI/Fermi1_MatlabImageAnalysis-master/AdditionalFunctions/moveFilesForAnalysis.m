% copy files back from done folder
if((exist( 'done\')==7))
    files= dir([pwd '\done\'  '*spe']);
    for RunIdx = 1:length(files)
        movefile(['done\' files(RunIdx).name],[pwd]);
    end
end
if((exist( 'badShots\')==7))
    files= dir([pwd '\badShots\'  '*spe']);
    for RunIdx = 1:length(files)
        movefile(['badShots\' files(RunIdx).name],[pwd]);
    end
end
