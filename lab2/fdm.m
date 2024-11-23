clear all; close all; clc;
pkg load signal;

filename1 = 'audio1.wav';
filename2 = 'audio2.wav';
filename3 = 'audio3.wav';

% Carregar os sinais de áudio e ajustá-los para o mesmo comprimento
[y1, fs] = audioread(filename1);
y1 = y1';
[y2, fs] = audioread(filename2);
y2 = y2';
[y3, fs] = audioread(filename3);
y3 = y3';

% Período de amostragem
ts = 1/fs;

% Ajustar todos os sinais para o mesmo comprimento (o comprimento de y2)
target_length = length(y2);
y1 = [y1, zeros(1, target_length - length(y1))];
y3 = [y3, zeros(1, target_length - length(y3))];

% Vetores de tempo para cada sinal
t1 = (0:length(y1)-1)*ts;
t2 = (0:length(y2)-1)*ts;
t3 = (0:length(y3)-1)*ts;

% Definir as frequências das portadoras
fc1 = 6000;
fc2 = 10000;
fc3 = 14000;

% Modulação dos sinais com as portadoras
m1_t = cos(2 * pi * fc1 * t1);
m2_t = cos(2 * pi * fc2 * t2);
m3_t = cos(2 * pi * fc3 * t3);

sig_m1c1 = y1 .* m1_t;
sig_m2c2 = y2 .* m2_t;
sig_m3c3 = y3 .* m3_t;

% Parâmetros do filtro passa-faixa
order = 500;  % Ordem do filtro

% Faixas de frequência para cada sinal, normalizadas por fs/2
% Definimos uma largura de banda para permitir as frequências próximas das portadoras
band1 = [fc1 + 1500, fc1 + 3000] / (fs / 2);
band2 = [fc2 + 1500, fc2 + 3000] / (fs / 2);
band3 = [fc3 + 1500, fc3 + 3000] / (fs / 2);

% Criar filtros passa-faixa usando fir1
b1 = fir1(order, band1, 'bandpass');
b2 = fir1(order, band2, 'bandpass');
b3 = fir1(order, band3, 'bandpass');

% Aplicar os filtros nos sinais modulados
filtered_sig_m1c1 = filter(b1, 1, sig_m1c1);
filtered_sig_m2c2 = filter(b2, 1, sig_m2c2);
filtered_sig_m3c3 = filter(b3, 1, sig_m3c3);

% Exibir os sinais filtrados para ver o resultado
figure;
subplot(3, 1, 1);
plot(t1, filtered_sig_m1c1);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Filtrado - sig\\_m1c1');

subplot(3, 1, 2);
plot(t2, filtered_sig_m2c2);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Filtrado - sig\\_m2c2');

subplot(3, 1, 3);
plot(t3, filtered_sig_m3c3);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Filtrado - sig\\_m3c3');

% somar todos os sinais

sinal_somado = filtered_sig_m1c1 + filtered_sig_m2c2 + filtered_sig_m3c3;

% usar filtro passa faixa para efetuar a regeneração de cada sinal

unfiltering_sig_m1c1 = filter(b1, 1, sinal_somado);
unfiltering_sig_m2c2 = filter(b2, 1, sinal_somado);
unfiltering_sig_m3c3 = filter(b3, 1, sinal_somado);

% multiplicar pelas portadoras novamente

recovered_sig1 = unfiltering_sig_m1c1 .* cos(2 * pi * fc1 * t1);
recovered_sig2 = unfiltering_sig_m2c2 .* cos(2 * pi * fc2 * t2);
recovered_sig3 = unfiltering_sig_m3c3 .* cos(2 * pi * fc3 * t3);

% usar filtro passa baixa para regenerar o sinal

lowpass_cutoff = 3000 / (fs / 2);  % Corte de 3 kHz, normalizado
b_lp = fir1(order, lowpass_cutoff, 'low');

recovered_sig1 = filter(b_lp, 1, recovered_sig1);
recovered_sig2 = filter(b_lp, 1, recovered_sig2);
recovered_sig3 = filter(b_lp, 1, recovered_sig3);

% Normalizar os sinais recuperados para evitar distorção na reprodução
recovered_sig1 = recovered_sig1 / max(abs(recovered_sig1));
recovered_sig2 = recovered_sig2 / max(abs(recovered_sig2));
recovered_sig3 = recovered_sig3 / max(abs(recovered_sig3));

% Exibir os sinais recuperados para ver o resultado
figure;
subplot(3, 1, 1);
plot(t1, recovered_sig1);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Recuperado - sig1');

subplot(3, 1, 2);
plot(t2, recovered_sig2);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Recuperado - sig2');

subplot(3, 1, 3);
plot(t3, recovered_sig3);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Recuperado - sig3');