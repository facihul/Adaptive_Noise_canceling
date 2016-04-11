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
is = 281*fs+1;
ie = is+16000;
range = is:ie;

% get the signals
c = y1(range); % input signal
v = y2(range); % input signal
s = y3(range); % desired signal
%lamda=0.994:0.0005:1;
lamda=0.999;
for j=1:length(lamda);
 err = rls(lamda(j),v,s,M);
  ase(j)=ASE(c,err);
end 
 
% plot(lamda,ase);grid on;
% title('lamda vs avagaresquared error (data set 3)')
% xlabel('lamda')
% ylabel('Avarage squred error')

% Error estimation
 plot(c, 'b'); hold on;
plot(err,'r'); hold off;
title('error estimation');
ylabel('audio data');
xlabel('time(t)');
legend('blue for c','red for err');





% k
