% x = [3     4     2     4     4     2     2     3     4     5     5     6]
% fs = 44100;
% playSequence1(x,1,fs)

function playSequence(degrees,pattern,key,fs)
    ryth = makeRyth(pattern);
    
    mySeq = getNotesForSequence(degrees,key);
    myNotes = [];
    seqCounter = 0;
    for i = 1:length(ryth)
        if ryth(i,1) == 1
            seqCounter = seqCounter + 1;
            thisNote = generate_note(mySeq(seqCounter),14,fs,ryth(i,2));
        else
            %do the silence thing
            thisNote = generate_note(0,14,fs,ryth(i,2));
        end
        myNotes = [myNotes; thisNote];

    end
    

   
    soundsc(myNotes,fs)

end

function myNotes = getNotesForSequence(degrees,key)
    myNotes = [];
    root = getRootFreq(key);
    for i = 1:length(degrees)
        next = DegreeToNote(degrees(i),root);
        myNotes = [myNotes; next];
    end

end


function out = makeChord(rootFreq,fs,time,key)
    first = generate_note(rootFreq,14,fs,time);
    if key == 4
        m3 = 3;
    else
        m3 = 4;
    end
    third = generate_note(rootFreq*2^(m3/12),14,fs,time);
    fifth = generate_note(rootFreq*2^(7/12),14,fs,time);
    out = first+third+fifth;
end
function freq = getRootFreq(key)
    
    degreeVect = [ 4 5 ];
    num = ceil(rand*length(degreeVect));
    myNum = degreeVect(num);
    myNum = key+12*myNum;
    freq = 27.5*2^((myNum-21)/12);
end

function freq = DegreeToNote(degree,rootFreq)
    freq = rootFreq*2^(degree/12);
end