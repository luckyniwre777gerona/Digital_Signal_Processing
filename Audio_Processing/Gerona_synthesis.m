%% Gerona, Lucky Niwre M.
% 2015-00532
% Audio Exercise

%% 1.

fs = 16000;                                                % initialize sampling freq
 
t1 = [0:1/fs:5];                                           % create time vector for exponential
tau1 = 5;                                                  % time constant set to 5
envelope_1 = exp(t1./tau1);                                % input time vector to create exponential increase 

t2 = [0:1/fs:3];                                           % time vector similar to eariler
envelope_2 = max(envelope_1) .* ones(1,length(t2));        % generate 3 seconds of the max value from eariler exponential

t3 = [0:1/fs:5];                                           % generate vetor for exponential
t3 = fliplr(t3);                                           % exponential decay, thus flip the vector to high to low
envelope_3 = exp(t3./tau1);                                % generate exponential decay

signal_envelope = [envelope_1 envelope_2 envelope_3];      % concatenate envelopes
signal_envelope = signal_envelope ./ max(signal_envelope); % normalize envelope

%% 2. 

% use fmmod to generate harmonics for first frequency
tone1 = fmmod(signal_envelope,0,fs,1*580);                  
tone2 = fmmod(signal_envelope,0,fs,2*580);
tone3 = fmmod(signal_envelope,0,fs,3*580);
tone4 = fmmod(signal_envelope,0,fs,4*580);
tone5 = fmmod(signal_envelope,0,fs,5*580);
tone6 = fmmod(signal_envelope,0,fs,6*580);

sound1 = tone1 + tone2 + tone3 + tone4 + tone5 + tone6;

% use fmmod to generate harmonics for second frequency
tone7 = fmmod(signal_envelope,0,fs,1*690);
tone8 = fmmod(signal_envelope,0,fs,2*690);
tone9 = fmmod(signal_envelope,0,fs,3*690);
tone10 = fmmod(signal_envelope,0,fs,4*690);
tone11 = fmmod(signal_envelope,0,fs,5*690);
tone12 = fmmod(signal_envelope,0,fs,6*690);

sound2 = tone7 + tone8 + tone9 + tone10 + tone11 + tone12;

% add concatenate, and normalize sound 
sound_tot = sound1 + sound2;
sound_tot = sound_tot ./ max(sound_tot);

% lowpass filter to shape higher frequencies
synth_sound = lowpass(sound_tot,3000,fs);

% normalise
max1 = max(abs(synth_sound));
synth_sound = synth_sound ./ max1;

% play generated vector
sound(synth_sound,fs);

audiowrite('Gerona_synthesis.wav',synth_sound,fs);