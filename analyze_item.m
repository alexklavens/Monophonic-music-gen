
function intervals = analyze_item(fileName,songAmount)
    addpath(genpath('DutchSampleFolder'));
%     disp('file name');
%     disp(fileName)
%     
%     
%     disp('Determining character vector')
%     (ischar(fileName))
    [sample, fs] = audioread(fileName);
   
    sample = sample(1:end/songAmount);

    [pitchTimes, newSounds] = medianFilter(sample,fs);
    x = PitchTimesToMidiTimes(pitchTimes);

    y = OctaveNormalizeMidi(x);
    h = makeHistogram(y);
    key = getKey(h);
    intervals = getIntervals(newSounds,key);

%     disp('We now have a vector of normalized intervals');
%     intervalMap = makeMap(intervals);
% 
%     mySq = generate_sequence(intervalMap)
%     playSequence(mySq,key,fs);



    % soundsc(sample,fs)


    % get vector of pitch,start and stop times

    %soundsc(first5,fs)


    %goal: have a 3 column vector of pitch, start, stop
    %create histogram of song (pitch vs time)
end

function midiTimes = PitchTimesToMidiTimes(pitchTimes)
    midiTimes = pitchTimes;
    for i = 1:size(pitchTimes,1)
        midiTimes(i,1) = NoteToMidi(pitchTimes(i,1));
    end
end
        
function outVector = OctaveNormalizeMidi(midiVector)
    outVector = midiVector;
    for i = 1:length(midiVector)
        num = midiVector(i,1);
%         while num >= 12
%             num = num-12;
%         end
        outVector(i,1)=mod(num,12);
    end
end


function h = makeHistogram(noteVector)
    h = histogram(noteVector,[0:12]);
end

function mags = allMags(S)    
    numFrames = size(S,2);
    mags = zeros(1,numFrames);
    for i = 1:numFrames
        mags(i) = magnitude(S,i);
    end
        
        
    
end

function mag = magnitude(S, col)
    mag = sum(S(:,col));    
end