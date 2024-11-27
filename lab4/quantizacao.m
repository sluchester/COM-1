clear all; close all; clc;
pkg load signal;
pkg load communication;

filename = 'audio_quantizacao2.wav';

% Carregar os sinais de áudio e ajustá-los para o mesmo comprimento
[sinal, fs] = audioread(filename);
sinal = sinal';

% Número de níveis de quantização (2^3bits = 8 níveis)
niveis = 8;
% Determinar os limites de cada nível
passo_quantizacao = 2 / niveis; % Passo entre níveis (delta)
% offset
sinal_offset = sinal + 1;

steps = sinal_offset/passo_quantizacao;
valores = round(steps);

i=0;
for i = length(valores)
    if (valores(i)>(niveis-1))
        valores = niveis-1;
    endif
endfor

matrix_bin = de2bi(valores);
binary_vector = reshape(matrix_bin);