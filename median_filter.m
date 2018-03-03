% % Returns a vector of pitch and times
% 
%  [sample fs] = audioread('SSB.wav');
% 
% %[sample fs] = audioread('NLB072497_all.mp3');
% figure(1)
% plot(sample)
% 
% 
% sample = sample(1:fs*6);
% soundsc(sample,fs)
% pause;
% median_filter1(sample,fs);asdf


% function [out, newSounds] = median_filter1(signal,fs)


%  [sample,fs] = audioread('SSB.wav');
% %[sample fs] = audioread('NLB073588_all.mp3');
% 
% first5 = sample(1:(fs*20));
% first5 = DutchFilter(first5,fs)
% median_filter1(first5,fs);

%returns 
function [noteList, newSounds] = median_filter(signal,fs)

     medSize = 40;
    fft_size = 2^12;
    noverlap = floor(fft_size/1.1);
   
    
    [S F T] = spectrogram(signal,hanning(fft_size),noverlap,fft_size,fs);
    S = abs(S);
    figure(4)
    imagesc(S.^2)
    
    signal = DutchFilter(signal,fs)
    
   
    [S F T] = spectrogram(signal,hanning(fft_size),noverlap,fft_size,fs);
    S = abs(S);
    figure(5)
    imagesc(S.^2);
    
    mags = allMags(S);
    magThresh = max(mags)*.15;
    
    
   % startFFT = floor(.25*length(S(1,:)));
    noteList = [];
    
    hopSize = fft_size - noverlap;
    for bin = 1:length(S(1,:))
        myNote = find_fund_template(S,F,T,bin,fs);
        noteList = [noteList;myNote];
       
        
   
    end
    figure(2)
    plot(noteList,'+');
    title(['Notes Before Median Filter'])

    newNotes = MedianFilter(noteList,medSize);
    newNotes = MedianFilter(noteList,90);
    
    figure(3)
    plot(newNotes,'+')
    title(['Notes After Median Filter'])

    
    
    
%     
%     plot( noteList(:,1),newNotes,'+')
%   





    %%%%%%%
    %For loop that returns vector of frequencies startTime and End Time
    %%%%%%%

    myNotes = []; %% array of [note startIndex stopIndex]
    
    startIndx = 0;
    for i = 1:length(newNotes)-1
        if newNotes(i) ~= newNotes(i+1)
            myNotes = [myNotes; newNotes(i) startIndx T(i)];
            startIndx = T(i);
        end
    end
    
    
    
    %%%%%%%
    %For loop that returns vector of frequencies and length
    %%%%%%%
    
    newSounds = []; %%array of [frequency, T(ending) - T(start) 
    for i = 1:length(myNotes)
        freq = myNotes(i,1);
        time = (myNotes(i,3)) - (myNotes(i,2));
        newSounds = [newSounds; freq time];
    end
    
    %for each line, generate note of that freq and time
    myOutSample = [];
    for i = 1:length(newSounds)
        nextNote = generate_note(newSounds(i,1),14,fs,newSounds(i,2));
        myOutSample = [myOutSample; nextNote];
    end
    outSound = myOutSample;

    soundsc(outSound,fs)
end
    


function newScore = MedianFilter(freqList,size)
    filter = size/2;
    newScore = [];
    

    
    for i = 1:length(freqList)
        medStart = i-filter;
        medEnd = i+filter;
        if medStart < 1
            medStart = 1;
        elseif medEnd >length(freqList)
            medEnd = length(freqList);
        end
%         medStart
%         medEnd
        window = freqList(medStart:medEnd);
        newScore(i) = median(window);
    end


end


function frequency_estimate = find_fund_template(S,F,T,item,fs)
    spectrum = S(:,item);
    disp(length(spectrum))
    fft_size = 2^12;
    freqs = (0:fft_size/2)*fs/fft_size;
    
    for bin = 50:200
        empty = zeros(1,length(spectrum));
        for i = 1:14
            empty(bin*i) = 1/i;
        end
        empty = empty(1:length(spectrum));

        a = corrcoef(spectrum,empty);
        corr(bin) = a(1,2);
    end
    
   [maxCorr idx] = max(corr);
   idx
  
   mags = allMags(S);
   disp('number of magnitudes')
   disp(length(mags))
   if mags(idx) < max(mags)*.1
       frequency_estimate = NaN;
   else
       frequency_estimate = F(idx);
   end
%    
   
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