%% Digital Speech Processing - SilenceRemoval.m
% DSP Application Process - 2nd Semester AY 2018-2019
% Submitted by: GERONA, Lucky Niwre M. 2015-00532
% Submitted on: 24 March 2019
% Created with: MATLAB R2018b
%% Silence Removal Script

threshold = 0.01;
newSig = [];


[speech,fs] = audioread('lucky_00532.wav');          % read recording

n_length = 100 * fs * 0.001;                         % get number of samples
n_overlap = 0;
n_jump = n_length;                                   % since overlap = 0, jump = window
win_vec = rectwin(n_length);
% zero padding (similar to earlier)
rem = mod(length(speech), n_jump);                   % get remainder when length of vector is divided by jump length
iter = floor(length(speech)/n_jump);                 % quotient is the number of iterations
n_zeros = n_length - rem;
Z = zeros(n_zeros,1);                                % concatenate the zero vector
speech = [speech ; Z];

for i = 0:(iter-1)
    temp = 0;                                        % generate lowerbound by adding multiples of jump and 1
    lb = 1+(i*n_jump);
    ub = n_length + (i*n_jump);                      % generate lowerbound by adding multiples of jump and window length
    window = speech(lb:ub) .* win_vec;               % multiply the window and vector
    for j = window'
        temp = temp + abs(j*j);
    end
    if temp > threshold                              % concatenate only if above the energy threshold
        newSig = [newSig;window];                 
    end
end

audiowrite('SilenceRemoval.wav',newSig,fs);          % create .wav file for silence removal