clear all; close all; clc;

filename = 'audio_quantizacao2.wav';

% Carregar os sinais de áudio e ajustá-los para o mesmo comprimento
[sinal, fs] = audioread(filename);
if size(sinal, 2) > 1
    sinal = mean(sinal, 2); % Converte para mono
end
sinal = sinal'; % Transpõe para linha

% Número de níveis de quantização (2^3bits = 8 níveis)
niveis = 8;
% Determinar os limites de cada nível
passo_quantizacao = 2 / niveis; % Passo entre níveis (delta)
% offset
sinal_offset = sinal + 1;
% periodo de amostragem
ts = 1/fs;
% construindo vetor t
t = 0 : ts : (length(sinal_offset)/fs) - ts;

steps = sinal_offset/passo_quantizacao;
sinal_quantizado = round(steps);
sinal_quantizado(sinal_quantizado > (niveis-1)) = niveis - 1;

matrix_bin = de2bi(sinal_quantizado);
binary_vector = reshape(matrix_bin, 1, []);

% Plot do audio processado
figure;
subplot(4,1,1);hold on; grid on;
plot(t, sinal);

subplot(4,1,2);hold on; grid on;
plot(t, sinal_offset);

subplot(4,1,3);hold on; grid on;
% Eixo Y representa os níveis de 0 à 7
plot(t, steps);

subplot(4,1,4);hold on; grid on;
plot(t, sinal_quantizado);

%%%%%%%%%%%%%%%%%%%
%% Modulação NRZ %%
%%%%%%%%%%%%%%%%%%%

% Número de amostras por bit no sinal NRZ
N = 10;
% Amplitude do sinal NRZ
A = 5;
% Variância do ruído adicionado ao sinal
var = 1;

% Converte os bits binários [0, 1] em níveis de amplitude NRZ
sinal_quantizado_NRZ = binary_vector * 2*A - A;
% Insere N-1 zeros entre cada amostra, criando uma versão de maior taxa de amostragem
sinal_quantizado_NRZ_up = upsample(sinal_quantizado_NRZ, N);

% Cria um filtro passa-baixas simples (vetor de N valores 1).
filtro_NRZ = ones(1,N);
% Aplica o filtro para suavizar o sinal info_NRZ_up, gerando o sinal NRZ contínuo
sinal_NRZ = filter(filtro_NRZ, 1, sinal_quantizado_NRZ_up);
% Cria um vetor de ruído branco Gaussiano com variância definida por var
ruido = sqrt(var)*randn(1, length(sinal_NRZ));
% Adiciona o ruído ao sinal NRZ
sinalNRZ_com_ruido = sinal_NRZ + ruido;
% Amostra o sinal ruidoso r_t no meio de cada bit (em passos de N)
amostra_ruido = sinalNRZ_com_ruido(N/2 : N : end);
%% Recupera os bits transmitidos com base no limiar:
% Se o valor amostrado for maior que 0 → bit 1.
% Caso contrário → bit 0.
recupera_bits = amostra_ruido > 0;
min_len = min(length(sinal_quantizado), length(recupera_bits));
recupera_bits = recupera_bits(1:min_len);
sinal_quantizado = sinal_quantizado(1:min_len);
% Conta o número de erros na detecção comparando info com info_hat
num_erro = sum(xor(sinal_quantizado, recupera_bits));

figure;
subplot(3,1,1); hold on; grid on;
stem(sinal_NRZ);

subplot(3,1,2); hold on; grid on;
plot(sinal_NRZ);

subplot(3,1,3); hold on; grid on;
plot(sinalNRZ_com_ruido);