%%%%%%%%  Its a small Project of a course in advanced signal processing %%%%%%%%%%%%%%%%
%%%   Adaptive Noise cencelltion %%%%%%

% It implements Three adaptive algorithms : 
% 1. Normalized Least Mean Square (NLMS).....task1.m 
% 2. Least Square (RLS) .....................task2.m
% 3. Recurssive Least Square (RLS)...........task3.m
%
%
%%%   description of audio source %%%%%%%%%%%

% We have the files (that are available at http://www.cs.tut.fi/ ?helinp/advsp/project.zip):
% ? Edgar Allan Poe - The Raven.wav - the clear source c(t); some extra details can be found here http://en.wikipedia.org/wiki/The_Raven.
% ? Quake III Arena - Gameplay.wav - the noise source v(t);
% ? Edgar Allan Poe - The Raven + Loud Quake III - 1.wav - the measured signal s(t); this
% corresponds to the signal v(t) distorted by passing it through an FIR filter of length 80; the
% filter coefficients are constant.
% ? Edgar Allan Poe - The Raven + Loud Quake III - 2.wav - the measured signal s(t); this
% corresponds to the signal v(t) distorted by passing it through an FIR filter of length 200; the
% filter coefficients are constant.
% ? Edgar Allan Poe - The Raven + Loud Quake III - 3.wav - the measured signal s(t); this
% corresponds to the signal v(t) distorted by passing it through an FIR filter of length 200; the filter coefficients are constant until second 280 after which they change in a sinusoidal way.
% 


%%%



close all;
clear all;
clc;

dataset = 3; % Select the dataset using this variable

% Read input the data from a .wav file
[y1, fs, nbits1] = wavread('Edgar Allan Poe - The Raven.wav');
[y2, fs, nbits2] = wavread('Quake III Arena - Gameplay.wav');

[y3, fs, nbits3] = wavread(['Edgar Allan Poe - The Raven + Loud Quake III - ', num2str(dataset) ,'.wav']);

% set the length of the filter
vec_M = [80 200 200];
M = vec_M(dataset);

% interval from input data to analyze
is = 280*fs+1;
ie = 281*fs;
range = is:ie;

% get the signals
c = y1(range); % original signal
v = y2(range); % input signal
s = y3(range); % desired signal
mu=0.05:0.05:1.95;

% mu = 0.2;
%  Implement the NLMS algorithm.

for m=1:length(mu)
[res_nlms,y] = NLMS(s, v, mu(m), M, 0); % update NLMS function
 ave(m)=ASE(c,res_nlms);
end
% Visual comparison of the signals
 
% plot(c, 'r');
% hold on;
% plot(res_nlms', 'b');
% hold off
% legend('Original signal', 'Recovered signal (NLMS)');
% xlabel('time (t)');
% ylabel('audio data');



 
% average squred error ns mu
plot(mu,ave); grid on;
title('data set 3');
xlabel('mu');
ylabel('averaged squred error');






