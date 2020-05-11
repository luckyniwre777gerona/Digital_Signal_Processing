%% Digital Speech Processing - STEContour.m
% DSP Application Process - 2nd Semester AY 2018-2019
% Submitted by: GERONA, Lucky Niwre M. 2015-00532
% Submitted on: 24 March 2019
% Created with: MATLAB R2018b
%% Create Contour of Speech

% simply following instructions; hamming, window = 40msec, overlap = 0.75*40
[speech, fs, speech_STE] = calcSTE('lucky_00532.wav', 40, 30, 'Hamming');

figure
subplot(2,1,1)
plot(speech);
title('Original Input Signal');
xlabel('time in secs');
ylabel('signal magnitude');
subplot(2,1,2)
plot(speech_STE);
title('STE of Input Signal');
xlabel('time in secs');
ylabel('STE');

% I don't know what a Energy Contour is, so speech and the STE are plotted separately