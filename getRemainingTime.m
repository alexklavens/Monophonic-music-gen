function totalLen = getRemainingTime(dataset)
    totalLen = 0;
    for i = 1:length(dataset)
        time = getLengthOfSong(dataset{i});
        totalLen = totalLen + time*1.4;
    end
end



function lenTime = getLengthOfSong(sample)
    [samp, fs] = audioread(sample);
    len = length(samp);
    lenTime = len/fs;
end