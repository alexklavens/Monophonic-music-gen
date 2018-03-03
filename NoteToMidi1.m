NoteToMidi(440)

function n = NoteToMidi(freq)
    n = round(12 * log2(freq/27.5))+21;
end