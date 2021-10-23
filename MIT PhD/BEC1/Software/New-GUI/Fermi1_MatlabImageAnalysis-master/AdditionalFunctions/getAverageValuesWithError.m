function analysis = getAverageValuesWithError(xvals,yvals,excludeIdx)
    analysis = struct;
    uniqueTimes = unique(xvals);
    analysis.xvalsAveraged = zeros(1,length(uniqueTimes));
    analysis.yvalsAveraged = zeros(1,length(uniqueTimes));
    analysis.yStdAveraged  = zeros(1,length(uniqueTimes));
    analysis.y_ciAveraged  = zeros(2,length(uniqueTimes));
    for idx = 1:length(uniqueTimes)
        analysis.xvalsAveraged(idx) = uniqueTimes(idx);
        valuesIdx = xvals(:)==uniqueTimes(idx);
        valuesIdx(excludeIdx) = false;
        
        analysis.yvalsAveraged(idx) = mean(yvals(valuesIdx));
        stdError = std(yvals(valuesIdx))/sqrt(length(yvals(valuesIdx)));
        if(stdError>0)
            analysis.yStdAveraged(idx) = stdError;
        else
            analysis.yStdAveraged(idx) = 0.3;
        end
    end
    analysis.y_ciAveraged(1,:) = analysis.yvalsAveraged-analysis.yStdAveraged;
    analysis.y_ciAveraged(2,:) = analysis.yvalsAveraged+analysis.yStdAveraged;
end