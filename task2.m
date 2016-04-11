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

%dataset = 1; % Select the dataset using this variable

% Read input the data from a .wav file
[y1, fs, nbits1] = wavread('Edgar Allan Poe - The Raven.wav');
[y2, fs, nbits2] = wavread('Quake III Arena - Gameplay.wav');

vec_M = [80 200 200]; % length of filter


% interval from input data to analyze
is = 281*fs+1;
ie = 291*fs;
range = is:ie;
c = y1(range); % original signal
v = y2(range)'; % input signal
tri=[1 2 4 8 10];% number of segments
for dataset=1:3

    [y3, fs, nbits3] = wavread(['Edgar Allan Poe - The Raven + Loud Quake III - ', num2str(dataset) ,'.wav']);

% set the length of the filter

M = vec_M(dataset);



% get the signals

s = y3(range)'; % desired signal

for trail=1:length(tri)
    segment=tri(trail);
    
col=length(s)/segment;
W=zeros(M,segment);
e=zeros(1,col);
errtotal=zeros(col,segment);

v_seg=reshape(v,segment,col); % segmantation 
s_seg=reshape(s,segment,col); % segmantation


% estimating per segment

for seg=1:segment
    u=v_seg(seg,:)';
    d=s_seg(seg,:);
    A=prewin(u,M,col); % pre windowing
    w=pinv(A)*d'; % LS solution
    W(:,seg)=w;
    
   % error calculation
    for n = 1:col
     uu=A(n,:);
     y = uu*w;
     e(n) = d(n) - y;
    end
    errtotal(:,seg)=e;
   
    
end

error=reshape(errtotal,1,segment*col)';
ase(trail)=ASE(c,error);
end

ave(dataset,:)=ase;

end


plot(tri,ave(1,:),'-or',tri,ave(2,:),'-ob',tri,ave(3,:),'-og'); grid on ;

title('number of segments vs avarage squared error');
xlabel('number of segments');
ylabel('avarage squared error');
legend('red =dataset 1','blue=dataset 2','green=dataset 3');


