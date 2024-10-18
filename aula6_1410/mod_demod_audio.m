clear all; close all; clc;

pkg load signal;

filename= 'audio_com.wav';

# o novo sinal agora é y
[y, fs] = audioread(filename);

% periodo de amostragem
ts = 1/fs;

% vetor de tempo para plotagem
t = (0:length(y)-1)/fs;



plot(t,y);
