%%Alex Klavens
%%HW2 helping function
%%generate a note of a given frequency for a certain length

function out = generate_note (freq,harmonics,fs,t)
    time = 0:1/fs:t;
    x = zeros( 1, length( time ) );
    for partial = 1 : harmonics
        x = x + (1/(partial^1.2))*sin( 2 * pi * freq * partial * time);
    end
    
    in = (0:1/fs:t/5);
    env = in*(5/t);
    middle = ones(1,length(x)-(2*length(env)));
    
    env = [env middle (1-env)];
    
    out=x.*env;
    out=out';
    
end