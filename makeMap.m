function intervals = makeMap(DegreeVector)
    degrees = removeNaN(DegreeVector);
    intervals = zeros(12);
    for i = 2:length(degrees)
        i;
        first = degrees(i-1)+1;
        second = degrees(i)+1;
        intervals(first,second) = intervals(first,second)+1;
    end
end

function outVect =removeNaN(vect)
    outVect = [];
    for i = 1:length(vect)
        if ~isnan(vect(i))
            outVect = [outVect vect(i)];
        end
    end
end