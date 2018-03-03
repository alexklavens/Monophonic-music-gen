

function intervals = getIntervals(soundVector,key)
    midiVector = getMidi(soundVector);
    intervals = zeros(length(midiVector),1);
   
    %intervals vector is a list of normalized midi numbers in terms of
    %key-interval patterns
    for i = 1:length(midiVector)
        firstMod = mod(midiVector(i),12);
        secondMod = mod(firstMod,key+1);
        intervals(i) = secondMod;
    end
%     intervals;
end
        

function outMidi = getMidi(soundVector)
    outMidi = zeros(length(soundVector),1);
    for i = 1:length(soundVector)
        outMidi(i) =  NoteToMidi(soundVector(i));
    end
end