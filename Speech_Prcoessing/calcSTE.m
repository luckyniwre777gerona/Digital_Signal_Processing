%% Digital Speech Processing - calcSTE.m
% DSP Application Process - 2nd Semester AY 2018-2019
% Submitted by: GERONA, Lucky Niwre M. 2015-00532
% Submitted on: 24 March 2019
% Created with: MATLAB R2018b

function [speech, fs, speech_STE] = calcSTE(filename, win_length, win_overlap, win_type)

[y,fs] = audioread(filename);                     % open file
max_y = max(abs(y));                              % normalize by dividing by the maximum
y = y ./ max_y;
[m,n] = size(y);

if n ~=1
    y = sum(sig,2)./2;                            % if column is not 1, convert to 1 column only
    % sig(:) concatenates column 2 at the end of column 1                   
    % sig(:,1) gets the first column
    % sig(:,2) gets the second column
    % sum(sig,2)./2 gets the mean of the vector at each row
end

n_length = win_length * fs * 0.001;                % length of window is computed by multiplying time(s) and frequency (samples/s)
n_overlap = win_overlap * fs * 0.001;              % overlap is compputed the same
n_jump = n_length - n_overlap;                     % the jump is computed by subtracting the length of the window and the overlap

if  strcmp(win_type,'rectangular') == 1

    win_vec = rectwin(n_length);                   % rectwin for rectangular window with length n

elseif strcmp(win_type,'Hamming') == 1
    
    win_vec = hamming(n_length);                   % Hamming for hamming window with length n
    
end

% zero-padding
rem = mod(length(y), n_jump);                      % get remainder when length of vector is divided by jump length
iter = floor(length(y)/n_jump);                    % quotient is the number of iterations
n_zeros = n_length - rem;                          % subtract remainder from the window length to get the number of zeroes needed
Z = zeros(n_zeros,1);                              % Z is th zero vector
y = [y ; Z];                                       % concatenate the zero vector
STE = [];                                          % create empty STE

for i = 0:(iter-1)
    temp = 0; 
    lb = 1+(i*n_jump);                             % find lower bound of the window at current iteration
    ub = n_length + (i*n_jump);                    % find upper bound by adding window length to window
    window = y(lb:ub) .* win_vec;                  % the values are multiplied to the win_vec (rect or hamm)
    for j = window'
        temp = temp + abs(j*j);                    % iterate through vector and get energy by getting the sum of squares
    end
    STE = [STE; temp];                             % concatenate to the STE vector 
end

speech = y;                                        % re-assign for proper outputting
speech_STE = STE;

end

