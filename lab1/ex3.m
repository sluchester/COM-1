close all; clear all; clc;

fs = 10000;       % Frequência de amostragem de 10 kHz
T = 1 / fs;       % Tempo de amostragem
duracao = 1;      % Duração de 1 segundo
num_amostras = fs * duracao; % Número de amostras = fs * duração

var_n = 1;
ruido = sqrt(var_n)*randn(1,1000000);

sinal_t = 5;
sinal_r = sinal_t + ruido;

subplot(2,1,1); hold on; grid on;
hist(ruido, 100);

subplot(2,1,2);
hist(sinal_r, 100);

Pot_ruido = (1/length(ruido))*sum(ruido.^2)
Pot_sinal = (1/length(sinal_t))*sum(sinal_t.^2)
SNR_dB = 10*log10(Pot_sinal/Pot_ruido)