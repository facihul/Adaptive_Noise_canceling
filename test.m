close all;
clear all;
clc;

dataset = [1,2,3]; % Select the dataset using this variable

%% Read input the data from a .wav file
[y1, fs, nbits1] = wavread('Edgar Allan Poe - The Raven.wav');
[y2, fs, nbits2] = wavread('Quake III Arena - Gameplay.wav');
[y3, fs, nbits3] = wavread(['Edgar Allan Poe - The Raven + Loud Quake III - ', num2str(dataset) ,'.wav']);
[y3, fs, nbits3] = wavread(['Edgar Allan Poe - The Raven + Loud Quake III - ', num2str(dataset) ,'.wav']);

% set the length of the filter
vec_M = [80 200 200];
M = vec_M(dataset);

% interval from input data to analyze
is = 281*fs+1;
ie = 282*fs;
range = is:ie;

% get the signals
c = y1(range); % original signal
v = y2(range); % input signal
s = y3(range); % desired signal
mu=0.05:0.05:1.95;

%% Task (I): Implement the NLMS algorithm.
tic;
[res_nlms,y] = NLMS(s, v, mu, M, 1); % update NLMS function
toc;

% Visual comparison of the signals
% figure(1); 
% hold on;
% plot(c, 'r');
% plot(res_nlms, 'b');
% hold off
% legend('Original signal', 'Recovered signal (NLMS)');
% xlabel('time (t)');
% ylabel('audio data');

figure(2); 

subplot(1,2,1);
plot(mu,res_nmls);
title('data set 2');
xlabel('mu');
ylabel('squred error');
subplot(1,2,2);
plot(mu,res_nmls);
title('data set 3');
xlabel('mu');
ylabel('squred error');



%% Task (II): noise .

% plot(mu,emean);grid on;
% title('mu vs mean squared error');
% xlabel('adaptation constant');
% ylabel('mean squared error');




