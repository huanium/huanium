function yEndArray = breathingSpectrumForFitting(omegas,modFreqArray,NCycles,amplitudes,phases,beamRatio)

    xEndArray = [];
    yEndArray = [];
    zEndArray = [];

    for idx = 1:length(modFreqArray)
        [times,diffEqSolution] = solveHydroBreathing(omegas,modFreqArray(idx),NCycles,amplitudes,phases,beamRatio);
        xEndArray(idx) = diffEqSolution(end,1);
        yEndArray(idx) = diffEqSolution(end,3);
        zEndArray(idx) = diffEqSolution(end,5);
    end


end