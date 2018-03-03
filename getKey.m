% %%%key finding
% function main
%  %    x = [1 3 4 0 0 1 4 5 7 5 4 0]
% %    x = [3.9800    2.6900 3.3400    3.1700    6.3300    2.6800    3.5200    5.3800    2.6000    3.5300    2.5400    4.7500]
% %     x = [6.35, 2.23, 3.48, 2.33, 4.38,4.09, 2.52, 5.19, 2.39, 3.66, 2.29, 2.88];
% %     x = [6.33, 2.68,3.52, 5.38, 2.60, 3.53, 2.54, 4.75, 3.98, 2.69, 3.34, 3.17];
%     
%     x = [ 5.3800    2.6000    3.5300    2.5400    4.7500    3.9800    2.6900    3.3400    3.1700 6.3300    2.6800    3.5200];
%     getKey1(x)
% end

% 
% function idx = getKey1(histoVect)

function idx = getKey(histoVect)
    major = [6.35, 2.23, 3.48, 2.33, 4.38,4.09, 2.52, 5.19, 2.39, 3.66, 2.29, 2.88];
    minor = [6.33, 2.68,3.52, 5.38, 2.60, 3.53, 2.54, 4.75, 3.98, 2.69, 3.34, 3.17];
    
    xNames = {'C';'C#';'D';'D#';'E';'F';'F#';'G';'G#';'A';'A#';'B';};

    
    majorVect = getAllKeys(major);
    minorVect = getAllKeys(minor);
    
    bothVect = [majorVect ; minorVect];
    size(bothVect);
    

    histoVect = histoVect.Values;
    corr = zeros(24,1);
    for key = 1:24
        thisKey = bothVect(key,:);
        a = corrcoef(histoVect,thisKey);
        corr(key) = a(1,2);
        
    end
    
    [maxCorr, idx] = max(corr);
    
    if idx <= 12
        keyType = 'major';
    else
        keyType = 'minor';
        idx = mod(idx,12);
        
    end

    switch 'none' %'key profiles'
        case 'key profiles'
            key = xNames(idx);
            figure(1)
            bar(majorVect(idx,:))
            title(['Krumhansl Profile at' key keyType])
            set(gca,'xticklabel',xNames);

            figure(2)
            bar(histoVect)
            title(['Histogram of Note Agg. Profile'])
            set(gca,'xticklabel',xNames);
        case 'none'
            ab = NaN;
            
    end

end

function keyVect = getAllKeys(type)
    keyVect = [];
    for i =  0:11
        next = circshift(type,i);
        keyVect= [keyVect; next];
    end
end
    