function myNum = getIntervalChange(intervalVector)
    probVector = [];
    for i = 1:length(intervalVector)
        for ammount = 1:intervalVector(i)
            probVector = [probVector i];
        end
    end
    num = ceil(rand*length(probVector));
    myNum = probVector(num);
end