clear all; close all; clc;
pkg load signal;

filename= 'audio_com.wav';

% o novo sinal agora é y
% fs é a frequencia amostrada do sinal
[y, fs] = audioread(filename);

% Período de amostragem
ts = 1/fs;

% Gera o vetor de tempo com base no tamanho de y
t = (0:length(y')-1) * ts;

% portadora
fc = 10000;
tc = 1/fc;

st_c = cos(2*pi*fc*t);

% sinal_modulado = apos passar pela portadora
% sinal modulante = antes de passar portadora

sinal_modulado = st_c .* y';
plot(t,sinal_modulado);

% resposta em frequencia
passo_f = fs/length(t);
f_axis = -fs/2 : passo_f : ((fs/2)-passo_f);

Xf_sinalModulado = fft(sinal_modulado)/length(sinal_modulado);
Xf_sinalModulado = fftshift(Xf_sinalModulado);

% Encontra a maior magnitude e a frequência correspondente
[~, idx] = max(Xf_sinalModulado);  % Encontra o índice da maior magnitude
f_dominante = abs(f_axis(idx));  % A frequência dominante é a maior

figure; hold on; grid on;
plot(f_axis, abs(Xf_sinalModulado));

% sinal demodulador
st_carrier_demod = cos(2*pi*fc*t);
sinal_demodulado = st_carrier_demod .* sinal_modulado;

