clear all; close all; clc;
pkg load signal;

% frequencias moduladoras
f1= 1000;
T= 1/f1;
f2=2*f1;
f3=3*f1;

% frequencias das portadoras
fc1= 10000;
fc2= 12000;
fc3= 14000;

fs = 60 * f1;
ts = 1/fs;
t = 0 : ts : 1;

% construindo os sinais moduladores
m1_t = cos(2 * pi * f1 * t);
m2_t = cos(2 * pi * f2 * t);
m3_t = cos(2 * pi * f3 * t);

t1 = (0:length(m1_t)-1)*ts;
t2 = (0:length(m2_t)-1)*ts;
t3 = (0:length(m3_t)-1)*ts;

% construindo as portadoras
c1_t = cos(2 * pi * fc1 * t1);
c2_t = cos(2 * pi * fc2 * t2);
c3_t = cos(2 * pi * fc3 * t3);

% multiplicação dos sinais pela portadora
sig_m1c1 = m1_t .* c1_t;
sig_m2c2 = m2_t .* c2_t;
sig_m3c3 = m3_t .* c3_t;

figure; hold on; grid on;
subplot(3, 1, 1);
plot(t1, sig_m1c1);
xlim([0 3*T]);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal 1');

subplot(3, 1, 2);
plot(t2, sig_m2c2);
xlim([0 3*T]);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal 2');

subplot(3, 1, 3);
plot(t3, sig_m3c3);
xlim([0 3*T]);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal 3');

% Parâmetros do filtro passa-faixa
order = 1500;  % Ordem do filtro

% Faixas de frequência para cada sinal, normalizadas por fs/2
% Definimos uma largura de banda para permitir as frequências próximas das portadoras
band1 = [fc1 - 500, fc1 + 500] / (fs / 2);
band2 = [fc2 - 500, fc2 + 500] / (fs / 2);
band3 = [fc3 - 500, fc3 + 500] / (fs / 2);

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
lowpass_cutoff1 = 1000 / (fs / 2);  % Corte de 1 kHz, normalizado
b_lp1 = fir1(order, lowpass_cutoff1, 'low');
lowpass_cutoff2 = 2000 / (fs / 2);  % Corte de 2 kHz, normalizado
b_lp2 = fir1(order, lowpass_cutoff2, 'low');
lowpass_cutoff3 = 3000 / (fs / 2);  % Corte de 3 kHz, normalizado
b_lp3 = fir1(order, lowpass_cutoff3, 'low');

recovered_sig1 = filter(b_lp1, 1, recovered_sig1);
recovered_sig2 = filter(b_lp2, 1, recovered_sig2);
recovered_sig3 = filter(b_lp3, 1, recovered_sig3);

% Normalizar os sinais recuperados para evitar distorção na reprodução
recovered_sig1 = recovered_sig1 / max(abs(recovered_sig1));
recovered_sig2 = recovered_sig2 / max(abs(recovered_sig2));
recovered_sig3 = recovered_sig3 / max(abs(recovered_sig3));

% Exibir os sinais recuperados para ver o resultado
figure;
subplot(3, 1, 1);
plot(t1, recovered_sig1);
xlim([0 3*T]);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Recuperado - sig1');

subplot(3, 1, 2);
plot(t2, recovered_sig2);
xlim([0 3*T]);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Recuperado - sig2');

subplot(3, 1, 3);
plot(t3, recovered_sig3);
xlim([0 3*T]);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Recuperado - sig3');