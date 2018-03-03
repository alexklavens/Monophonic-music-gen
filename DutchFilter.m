function y = DutchFilter(signal,fs)
    low = normalize(100,fs);
    high = normalize(8600,fs);
    y = outFilt(signal,[low high],'bandpass');

end

function y = outFilt(signal,band,type)
    if length(band)>1
       [n Wn] = buttord(band(1),band(2),3,50);
       [b a] = butter(n,band,type);
     
    else
        [b a] = butter(10,band,type);
        
    end
    y = filtfilt(b,a,signal);
       
end

function out = normalize(freq,fs)
    out = freq / (fs) ;
end