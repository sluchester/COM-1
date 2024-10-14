clear all; close all; clc;

pkg load signal;

filename= 'audio_com.wav';

[y, fs] = audioread(filename);

t = (0:length(y)-1)/fs;
plot(t,y);

