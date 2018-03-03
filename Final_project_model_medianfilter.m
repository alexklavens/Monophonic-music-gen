[sample fs] = audioread('NLB073269_all.mp3');
soundlength = length(sample);
first5 = sample(1:(fs*5));

out = median_filter(first5,fs);
soundsc(out,fs)
