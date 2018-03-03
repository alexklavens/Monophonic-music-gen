%this function will convert a pitch to a midi number


%make a matrix of all frequencies same size
%make a matrix of all midi pitches of same size
%noteVector()


findNote(440)

%outputs two numbers that are the frequency domain of a particualr
%frequency
function [low, high] = getQuarterTone(freq)
    low = freq*2^(-.25/12);
    high = freq*2^(.25/12);
end

function truth = inRange(num,low,high)
    truth = low <= num && num<=high;
end

%checks if note is with
function idx = findNote(freq)
    notes = noteVector();
    for i = 1:length(notes)
        noteCheck = notes(i);
        [low, high] = getQuarterTone(noteCheck);
        if inRange(freq,low,high)
            idx = i
        end
    end
end
        

function notes = noteVector()
%outputs a vector of all notes
    c0 = 8.1757989156;
    numZeros = 127;
    notes = zeros(numZeros,1);
    for i = 1:numZeros
        notes(i) = c0*2^(i/12);
    end
end

function notes =MIDIVector()
    numZeros = 127;
    notes = zeros(numZeros,1);
    for i = 1:numZeros+1
        notes(i) = i-1;
    end
end
        
    