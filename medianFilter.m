%  [x,fs] = audioread('SSB.wav');
% %[sample fs] = audioread('NLB073588_all.mp3');
% 
% first5 = sample(1:(fs*15));
% medianFilter(first5,fs);
function [newscore, outNotes] = medianFilter(x,fs)
    x = DutchFilter(x,fs);
    fft_size = 4096;
    noverlap = floor(fft_size/1.1);
    [S F T] = spectrogram( x, hanning(fft_size), noverlap, fft_size, fs);
    S = abs(S);
    
    
    score = []; %keeps track of estimated frequencies
    
    mags = allMags(S);
    magThresh = max(mags)*.05;
    
    
    %for each frame, estimate the frequency
    for i = 1:length(S(1,:))
        if mags(i) < magThresh
            fund_freq = NaN;
        else
            fund_freq = find_fund_template(S(:,i),fs,fft_size);
        end
        score(i) = fund_freq;
    end
    
    %score is a vector with frequencies
    
    
%     figure(1);
%     plot(score,'+');
    newscore = zeros(length(score),1);
    for i = 1:length(score)
        if score(i) == 0
            newscore(i) = 0;
        else
            filtSize = 30;
            start = i - filtSize;
            fin = i + filtSize;
            if start < 1
                start = 1;
            elseif fin > length(score)
                fin = length(score);
            end

            window = score(start:fin);
            newscore(i) = median(window);
        end
    end

%     figure(2);
%     plot(newscore, '+');
    
    start = 0;
    notes = [];
    for i = 1:length(newscore)-1
        if newscore(i) ~= newscore(i+1)
            notes = [notes ; newscore(i) start T(i)];
            start = T(i);
        end
    end
    outNotes = notes;
    outNotes = [];
    for i = 1:length(notes)
        if (notes(i,3) - notes(i,2)) > .1
            outNotes = [outNotes; notes(i,1) notes(i,2) notes(i,3)];
        end
    end
   
    
    
    
    
    
%     song = [];
%     for i = 1:length(notes)
%         song = [song; generate_note(notes(i,1), 14,fs,(notes(i,3) - notes(i,2)))];
%     end
%     
%      soundsc(song, fs);
%     
    
    
end



function y = find_fund_template(spectrum,fs,fft_size)
    freqs = (0:fft_size/2)*fs/fft_size;
    corr = zeros(150,1);
    for bin = 50:200
        template = zeros(1,length(spectrum));
        for n = 1:10
            template(bin*n) = 1/n;
        end
        a = corrcoef(spectrum, template);
        corr(bin) = a(1,2);
    end
    
    [m, max_corr] = max(corr);
    frequency_estimate = freqs(max_corr);
    
    y = frequency_estimate;
end

function mags = allMags(S)
    %returns a vector of magnitudes of x
    
    numFrames = size(S,2);
    mags = zeros(1,numFrames);
    for i = 1:numFrames
        
        mags(i) = magnitude(S,i);
    end
        
        
    
end



function mag = magnitude(S, col)
   %%takes a spectrogram (a vector)and column number and returns the magnitude
    %%(sum)
    
    
    mag = sum(S(:,col));    
end