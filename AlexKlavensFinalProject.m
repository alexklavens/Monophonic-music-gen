%%%%%%%%%%%%%%
%This Module is the central facilitator of Automatic monophonic music
%generation
%
%It will access and go through a database of songs
%Each 'song' will return its interval composition and this module will keep
%track of an 'interval map' from which music will be automatically
%generated
%%%%%%%%%%%%%%
% addpath('DutchSampleFolder')

% database = 'DutchSampleFolder';




database = 'DutchAudioPart1';
addpath(genpath(database));
my_dataset = makeSongDataset(database);
fprintf('Welcome! This program will analyze a database of %d Dutch Folk Melodies\n\n',length(my_dataset));



interval_map = zeros(12);

part = 1;
thisGo = round(length(my_dataset)/part);
for i = 1:thisGo
%     timeRemaining = getRemainingTime(myDataset(i:end))
    fprintf('Analyzing song #%d of %d\n',i,thisGo)
%     fprintf('........Time Remaining: %f minutes\n',timeRemaining/60)
    try
        intervals = analyze_item(my_dataset{i},1);
        nextMap = makeMap(intervals);
        interval_map = interval_map + nextMap;
    catch
        fprintf('Song #%d was not included in the dataset\n',i);
    end
end

play_new_song(interval_map,my_dataset);

fprintf('\n\n.....................\n\n')
fprintf('You may view certain information by typing in the following entries...\n')
fprintf('View interval matrix: interval_map\n')
fprintf('Generate and play a new piece (30 seconds): play_new_song(interval_map,my_database)\n')


