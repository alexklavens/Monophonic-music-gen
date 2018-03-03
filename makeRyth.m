%Take a vector of 

function rythVect = makeRyth(threeCols)
    times = zeros(length(threeCols),1);
    rythVect = [];
    for i = 1:size(threeCols,1)-1
        firstSilence = threeCols(i,3);
        secondSilence = threeCols(i+1,2);
        timeDif = (secondSilence-firstSilence);
        times(i) = threeCols(i,3)- threeCols(i,2);
        
        rythVect = [rythVect; 1 times(i)];
        if timeDif > .1
            rythVect = [rythVect; 0 timeDif];
        end
    end
    
end