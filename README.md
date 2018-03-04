# Smart-Melody-Generator
Learns patterns from a database of music to generate original melodies

# About the project
This was a final project for my Digital Sound Processing course. It analyzes a database of monophonic Dutch folk melodies to create inteligent original melodies. It's centered around key detection and interval normalization as to create a matrix of frequent interval patterns. With the obtained matrix, a melody generation method is employed,

# The Matrix

This program is centered around the creation and use of a 12 x 12 matrix representing possible changes of musical intervals. Database analysis populates the matrix, and melody generation makes use of it.

The matrix is updated throughout an analysis of the entire dataset of samples. As each additional sample is analyzed, the matrix becomes better defined as a representaiton of the dataset. In my case, I used this under the assumption that the program is using a dataset of alike samples to create melodies based on patterns found throughout the dataset. The method still holds to create melodies as a blend of whatever might be in the dataset.

### 1. Gets the notes
This program takes each song and breaks it down to what it determines are individual notes.

### 2. Key detection
Based on those notes, a key-detection algorithm is applied. This uses the assumption the monophonic music is in one diatonic key.

### 3. Key normalization
Using the determined key, the program selects the key's 'root note' and creates a vector of all notes in the sample, but in terms
of its interval relation to the root note.

### 4. Filling the matrix 
The program iterates through the vector Notes of note intervals and populates particular points of change on our matrix. For example, every isntance of a root note at Notes\[1] (MATLAB uses indexing starting at 1) transitioning to the key's major fifth at Notes\[2] would increment a counter for the first row (root note origin) and 8th column (major 5th / 8th semitone destination).

Then, the iterator would look at what key normalized interval change happend with Notes\[2] as the origin and Notes\[3] as the destination. If, for example, Notes\[3] was the key's major fourth note, the matrix would update at row 8 (major fifth origin), column 6 (major fourth destination).

# Melody Generation
The resulting matrix will be populated with interval changes found by an analysis of the dataset. The program now forms and generates a melody based on this matrix.

### Creating the new melody
The program assumes that a new piece starts at the root note. This is arbitrary. From this root note, the program looks at the matrix and chooses a destination note from the root note origin based on weighted probabiltiies of note transitions. If the root note often transitions to the fifth, there is a greater but not guaranteed, chance that this is the interval transition the program will choose.

Based on an arbitrary song length, the program continues to accumulate a vector of interval transitions based on the interval matrix.

Once completed, the program picks a key for the sample to be based on, and iterates through the vector of interval transitions. For each note, the program calculates a frequency and generates a sample based on that frequency.

The samples are accumulated in a vector of continuous monophonic samples. Once completed, the program can play to the user a series of computer-generated notes as the final melodic product.

# Areas of needed improvement

Right now, the program does not analyze for rhythm, nor does it make inteligent rhythmic decisions when generating original melodies. I believe instead it picks a certain number of notes to generate and keeps going until that need is filled.

The first step to change this would be to incorperate a more musical process for randomly making rhythmic decisions. For example, the program should begin assuming 4/4 time, deciding how many musical measures should be filled for a song, and randomly picking between eigth, quarter, half, and whole note time spaces. From this time-based template, the program can go through the interval matrix and "fill" the song with notes of those times.

A better way to go about this would be to analyze rhythm in the inital analysis of the database and maintain a matrix similar to the interval matrix, but for keeping track of common rhythmic patterns.
