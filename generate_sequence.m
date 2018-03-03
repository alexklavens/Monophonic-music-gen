function intervalSequence = generate_sequence(intervalMap)
    
    startRow = intervalMap(1,:);
    intervalSequence = [];
    for i = 1:100
        myChange = getIntervalChange(startRow);
        counter = 0;
        if i > 4
            while myChange == intervalSequence(i-1) && myChange == intervalSequence(i-2) && myChange == intervalSequence(i-3) && myChange == intervalSequence(i-4) && (length(startRow) - (sum(startRow(:) == 0)) > 1)
                myChange = getIntervalChange(startRow);
                counter = counter + 1;
            end
        end

        intervalSequence(i) = myChange;
        startRow = intervalMap(myChange,:);
    end
%     disp(intervalSequence);
end