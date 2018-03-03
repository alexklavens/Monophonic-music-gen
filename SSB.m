 %[sample,fs] = audioread('SSB.wav');
[sample,fs] = audioread('NLB073588_all.mp3');

first5 = sample(1:(fs*15));
first5 = DutchFilter(first5,fs);
track_frequency(first5,fs);
function track_frequency(x,fs)
    fft_size = 4096;
    noverlap = floor(fft_size/1.1);
    [S F T] = spectrogram( x, hanning(fft_size), noverlap, fft_size, fs);
    S = abs(S);
    
    
    score = []; %keeps track of estimated frequencies
    
    %for each frame, estimate the frequency
    for i = 1:length(S(1,:))
        fund_freq = find_fund_template(S(:,i),fs,fft_size);
        score(i) = fund_freq;
    end
    
    %score is a vector with frequencies
    
    
    figure(1);
    plot(score,'+');
    newscore = [];
    for i = 1:length(score)
        if score(i) == 0
            newscore(i) = 0;
            disp('score(i) == 0')
        else
            %Brian set median frame to 40 centered on i
            start = i - 20;
            fin = i + 20;
            if start < 1
                start = 1;
            elseif fin > length(score)
                fin = length(score);
            end

            window = score(start:fin);
            newscore(i) = median(window);
        end
    end
    figure(2);
    plot(newscore, '+');
    
    start = 0;
    notes = [];
    for i = 1:length(newscore)-1
        if newscore(i) ~= newscore(i+1)
            notes = [notes ; newscore(i) start T(i)];
            start = T(i);
        end
    end
    
    song = [];
    for i = 1:length(notes)
        song = [song generate_note(notes(i,1), (notes(i,3) - notes(i,2)), fs, 4)];
    end
    
    soundsc(song, fs);
    
    
    
end

function y = generate_note(freq, secs, fs, n)
    t = 0:1/fs:secs;
    env = 0:1/fs:.01;
    env = 100*env;
    s = sin(2*pi*t*freq);
    for i = 2:n
        s = s + (1/i)*sin(2*pi*t*(freq*i));
    end

    uno_length = (length(t)-(2*length(env)));
    env = [env ones(1, uno_length) (1-env)];

%     s = s .* env;
    y=s;
end



function y = find_fund_template(spectrum,fs,fft_size)
    freqs = (0:fft_size/2)*fs/fft_size;
    corr = [];
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