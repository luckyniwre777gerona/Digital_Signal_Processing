%% Gerona, Lucky Niwre M.
% 2015-00532
% Audio Exercise

%% 1.

[sound_part2, Fs] = audioread('Gerona.wav');
sound(sound_part2,Fs);

%% Vibrato   

% code referenced from http://users.cs.cf.ac.uk/Dave.Marshall/CM0268/PDF/10_CM0268_Audio_FX.pdf?fbclid=IwAR05o7OzdOk6opRMeM0TmGmnrcz-lOxMCUc3LrJhim7TNDSiJK3uFWmueLI

Modfreq = 6;                               % modulating frequency which regulates the delay                              
Width = 0.005;                             % amount of delay
Delay_sec = Width;                         % basic delay of input sample in sec
Delay_samp = round(Delay_sec*Fs);          % basic delay in # samples
Width_samp = round(Width*Fs);              % modulation width in # samples
Modfreq_samp = Modfreq/Fs;                 % modulation frequency in # samples
N = length(sound_part2);                   % # of samples in WAV-file
L = 2 + Delay_samp + Width_samp*2;         % length of the entire delay
Delayline = zeros(L,1);                    % memory allocation for delay
y = zeros(size(sound_part2));              % memory allocation for output vector

for n = 1:(N-1)
    
M = Modfreq_samp;                                        % number of samples delay
MOD = sin(M*2*pi*n);                                     % create modulating signal
quo = 1 + Delay_samp + Width_samp*MOD;                            % few lines of code to find the next sampling step based on the delay
i = floor(quo);
frac = quo-i;
Delayline = [sound_part2(n);Delayline(1:L-1)];           % follows the formula for a liner interpolation to generate the manipulated signal
y(n,1) = Delayline(i+1)*frac + Delayline(i)*(1-frac);
end

vib_mod = y;
% normalization
max_1 = max(abs(vib_mod));
vib_mod = vib_mod ./ max_1;

% play sound vector
sound(vib_mod,Fs);
audiowrite('Gerona_Tone1.wav',vib_mod,Fs);

%% Tremolo  
% tremolo is done by simple Amplitude Modulation
% Using the formula of AM

n_trem = 1:length(sound_part2);                   % get length of signal
Fc = 3;                                           
amp_coeff = 0.5;                                  % amplitude coefficient
trem = (1 + amp_coeff*sin(2*pi*n_trem*(Fc/Fs)));  % AM Formula 
trem_mod = trem'.*sound_part2;                    % multiplication of sound and the Modulated signal

% play sound vector
sound(trem_mod,Fs);
audiowrite('Gerona_Tone2.wav',trem_mod,Fs);

%% Reverb (Convolution Reverb)
% done by convolving the audio signal to a signal with reverb effects
rev_cat_rvrb = audioread('impulse_revcathedral.wav');  % read from a sample impulse response sound
rev_mod = conv(rev_cat_rvrb,sound_part2);              % simple convolution with the spatial sound to create reverb

% normalize
max1 = max(abs(rev_mod));
rev_mod = rev_mod ./ max1;

% play sound vector
sound(rev_mod,Fs);
audiowrite('Gerona_Tone3.wav',rev_mod,Fs);