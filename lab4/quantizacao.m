clear all; close all; clc;
pkg load signal;
pkg load communications;

filename = 'audio_quantizacao2.wav';

% Carrega o sinai de áudio e ajusta para mono
[sinal, fs] = audioread(filename);
if size(sinal, 2) > 1
    sinal = mean(sinal, 2); % Converte para mono
end
sinal = sinal'; % Transpõe para linha

bits = 10;
% Número de níveis de quantização (2^3bits = 8 níveis)
niveis = 2^bits;
% Determinar os limites de cada nível
passo_quantizacao = 2 / niveis; % Passo entre níveis (delta)
% offset
sinal_offset = sinal + 1;
% periodo de amostragem
ts = 1/fs;
% construindo vetor t
t = (0 : length(sinal_offset)-1)/fs;

% Inicialização do vetor de quantização
sinal_quantizado = zeros(1, length(sinal));
% normalização do sinal
steps = sinal_offset/passo_quantizacao;
sinal_quantizado = round(steps);
sinal_quantizado(sinal_quantizado > (niveis-1)) = niveis - 1;

% len_quant = length(sinal_quantizado);
% num_bits = bits;
% rem = mod(len_quant, num_bits);

% if rem ~= 0
    % Ajusta o comprimento removendo elementos excedentes
 %   sinal_quantizado = sinal_quantizado(1:end-rem);
% end
matrix_bin = de2bi(sinal_quantizado, bits, 2, 'left-msb');
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
ruido = sqrt(var)*randn(1, length(sinal_quantizado_NRZ_up));

% Adiciona o ruído ao sinal NRZ
sinalNRZ_com_ruido = sinal_NRZ + ruido;

figure;
subplot(2,1,1); hold on; grid on;
plot(sinal_NRZ);
xlim([2500*N 3600*N])

subplot(2,1,2); hold on; grid on;
plot(sinalNRZ_com_ruido);
ylim([-8 8]);
xlim([2500*N 3600*N])

%%%%%%%%%%%%%%%%%%%%%%%%
%%RECUPERAÇÃO DO SINAL%%
%%%%%%%%%%%%%%%%%%%%%%%%
% Amostra o sinal ruidoso r_t no meio de cada bit (em passos de N)
amostra_ruido = sinalNRZ_com_ruido(N/2 : N : end);
%% Recupera os bits transmitidos com base no limiar:
% Se o valor amostrado for maior que 0 → bit 1.
% Caso contrário → bit 0.
recupera_bits = amostra_ruido > 0;
% sinal_quantizado e recupera_bits devem ter o mesmo comprimento. Caso contrário, ocorre erro de dimensão.
% min_len = min(length(sinal_quantizado), length(recupera_bits));
% recupera_bits = recupera_bits(1:min_len);
% sinal_quantizado = sinal_quantizado(1:min_len);
% Conta o número de erros na detecção comparando info com info_hat
num_erros = sum(xor(binary_vector, recupera_bits));

% matriz de bits convertidos
converted_bits = reshape(recupera_bits, [], bits);
% conversão de bits para dec
sinal_binario_decimal = bi2de(converted_bits, 'left-msb');

% recuperando o sinal para o original
sinal_desquantizado = sinal_binario_decimal * passo_quantizacao;
% normalização do sinal para reprodução e remoção do offset colocado no início
sinal_desquantizado = sinal_desquantizado - abs(min(sinal));

sound(sinal_desquantizado, fs);