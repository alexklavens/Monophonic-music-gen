function whatiwant =  getRandomPattern(myDataset)

   
    num = ceil(rand*length(myDataset));
    name = myDataset{num};
    [signal,fs] = audioread(name);
    signal = signal(1:fs*30);

    [notwhatiwant, whatiwant] = medianFilter(signal,fs);
end