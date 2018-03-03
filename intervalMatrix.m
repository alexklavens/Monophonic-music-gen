function intervals = makeMap(DegreeVector)
    disp('Entering the interval matrix function')
    intervals = zeros(12);
    length(DegreeVector)
    for i = 2:length(DegreeVector)
        first = DegreeVector(i-1)+1;
        second = DegreeVector(i)+1;
        intervals(first,second) = intervals(first,second)+1;
    end
    intervals;
end