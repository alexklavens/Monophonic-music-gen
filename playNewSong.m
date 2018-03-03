function play_new_song(interval_map,my_dataset)
    mySq = generate_sequence(interval_map);
    disp('...generating an interval sequence from aquired interval matrix...')

    myPattern = getRandomPattern(my_dataset);
    fprintf('Interval Sequence & rythmic pattern generated...\n')
    fprintf('Generating song...\n');
    disp('Playing the Sequence')
    playSequence(mySq,myPattern,3,44100);
    
end