function MarqueeBoxes = createMarqueeBoxes(centerY,centerX,boxWidths,boxHeigths)
    MarqueeBoxes = [];
    for jdx = 1:2*length(boxHeigths)
        for idx = 1:2*length(boxWidths)
            boxIdx = floor((idx+1)/2);
            boxJdx = floor((jdx+1)/2);
            if(mod(idx,2))
                yOffset = sum(boxWidths(1:boxIdx));
            else
                yOffset = -sum(boxWidths(1:boxIdx-1));
            end
            if(mod(jdx,2))
                xOffset = sum(boxHeigths(1:boxJdx));
            else
                xOffset = -sum(boxHeigths(1:boxJdx-1));
            end
            MarqueeBoxes(2*length(boxWidths)*(jdx-1)+idx,:) = [centerY-yOffset,centerX-xOffset,boxWidths(boxIdx),boxHeigths(boxJdx)];
        end
    end
end
