%%Alex Klavens
%%HW2 helping function

%%access the frequency of a non-sharp/flat note with a string and integer
%%parameter. i.e. GetNote('c',4)
%GetNote1('c',4)
function getnote = GetNote1(note,octave)
    myGrid = GetAllNotes;
    myNote = NoteToNum(note);
    
    getnote = myGrid(myNote,octave);
end

function outArray = NoteArray
    a = 27.5;
    b = 30.868; 
    c = 32.703;
    d = 36.708;
    e = 41.203;
    f = 43.654;
    g = 48.999;
    
    outArray = [a b c d e f g]';
end

function outFreq = GetOctaves(freq)
    thisNote = [];
    for i = 0:7
        new = freq*2^i;
        thisNote = [thisNote new];
        
    end
    outFreq = thisNote;
end

function outGrid = GetAllNotes
    grid = [];
    noteArray = NoteArray;
    for i = 1:7
        this = GetOctaves(noteArray(i));
        grid = [grid; this];
        
    end
    outGrid = grid
end

function outNum = NoteToNum(note)
    if note == 'a'
        outNum = 1;
    elseif note == 'b'
        outNum = 2;
    elseif note == 'c'
        outNum = 3;
    elseif note == 'd'
        outNum = 4;
    elseif note == 'e'
        outNum = 5;
    elseif note == 'f'
        outNum = 6;
    elseif note == 'g'
        outNum = 7;
    end
end


function outScale = Chromatic(note,octave)
    thisNote = GetNote(note,octave);
    
end
