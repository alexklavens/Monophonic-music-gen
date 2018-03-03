function myDataset = makeSongDataset(myFolderName)
    myFolder = dir(myFolderName); 
    myDataset = {};
    counter = 0;
    for i = 1:length(myFolder)
        if length(myFolder(i).name) > 4
            counter = counter + 1;
            myDataset{counter} = myFolder(i).name;
        end
    end
end