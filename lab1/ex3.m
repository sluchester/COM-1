close all; clear all; clc;

fs = 10000;       % Frequência de amostragem de 10 kHz
T = 1 / fs;       % Tempo de amostragem
duracao = 1;      % Duração de 1 segundo
num_amostras = fs * duracao; % Número de amostras = fs * duração

var_n = 1;
ruido = sqrt(var_n)*randn(1, num_amostras); % Gera ruído com 10.000 amostras

% plotando o ruído no domínio do tempo
tempo = 0 : T : (duracao - T); % Cria o vetor de tempo com 10.000 pontos

plot(tempo, ruido);
title('Ruído com Distribuição Normal');
xlabel('Tempo (s)');
ylabel('Amplitude');


# Pot_ruido = (1/length(ruido))*sum(ruido.^2)
# Pot_sinal = (1/length(sinal_t))*sum(sinal_t.^2)
# SNR_dB = 10*log10(Pot_sinal/Pot_ruido)