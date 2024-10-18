clear all; close all; clc;

pkg load signal;

filename= 'audio_com.wav';

% o novo sinal agora é y
% fs é a frequencia amostrada do sinal
[y, fs] = audioread(filename);

% Período de amostragem
ts = 1/fs;

% Vetor de tempo
t = (0:length(y)-1)/fs;

% Normalizar o sinal para amplitude máxima de 1
y_norm = y / max(abs(y));

% Calcular a FFT do sinal para encontrar a frequência dominante
Y = fft(y_norm);
Y_mag = abs(Y(1:floor(length(Y)/2)));  % Pega metade do espectro (somente parte positiva)

% Criar o eixo de frequência (apenas parte positiva)
f_axis = (0:length(Y_mag)-1)*(fs/length(Y));

% Encontrar a frequência dominante
[~, idx] = max(Y_mag);  % Índice da frequência dominante
f_dominante = f_axis(idx);  % Valor da frequência dominante

% Plotar o espectro
# figure;
# plot(f_axis, Y_mag);
# title('Magnitude do Espectro de Frequência');
# xlabel('Frequência (Hz)');
# ylabel('Amplitude');

% criacao do sinal para 