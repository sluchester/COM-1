clear all; close all; clc;
pkg load signal;

filename = 'audioquantizacao2.wav';

% Carregar os sinais de áudio e ajustá-los para o mesmo comprimento
[y1, fs] = audioread(filename1);
y1 = y1';

% Período de amostragem
ts = 1/fs;