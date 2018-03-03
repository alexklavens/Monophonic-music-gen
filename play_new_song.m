function play_new_song(interval_map,my_dataset)
    mySq = generate_sequence(interval_map);
    myPattern = getRandomPattern(my_dataset);
    playSequence(mySq,myPattern,3,44100);
end