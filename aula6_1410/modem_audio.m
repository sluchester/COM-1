clear all; close all; clc;
pkg load signal;

filename= 'audio_com.wav';

% sinal_modulado = apos passar pela portadora
% sinal modulante = antes de passar portadora

% o novo sinal agora é y
% fs é a frequencia amostrada do sinal
[y, fs] = audioread(filename);
y = y';

% Período de amostragem
ts = 1/fs;

% Gera o vetor de tempo com base no tamanho de y
t = (0:length(y)-1) * ts;

Xf_y = fft(y);
Xf_y = fftshift(Xf_y);

% Vetor de frequências correspondente
f_axis = fs * (0:(length(y)/2)) / length(y);  % Frequências até Nyquist (fs/2)

% Calcula a magnitude do espectro
P2 = abs(Xf_y/length(y));  % Normaliza pela quantidade de amostras
P1 = P2(1:(length(y)/2)+1);  % Considera apenas a metade positiva do espectro
P1(2:end-1) = 2*P1(2:end-1);  % Ajusta a amplitude das frequências

% Identifica a frequência predominante
[~, idx] = max(P1);  % Encontra o índice da maior magnitude
f_dominante = f_axis(idx);  % Frequência dominante

figure;
plot(f_axis, P1);
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Espectro de Frequências do Sinal');
grid on;

% pesquisar o retorno da ifft para ver se não dá pra usar isso como uma nova função y(t)

% Calcula a amplitude associada à frequência dominante
A = max(y);  % Estima a amplitude como o valor máximo do sinal original

% Fase inicial (opcional - pode ser ajustada com base na FFT, mas vamos simplificar como 0)
phi = 0;

% Cria a função de onda senoidal baseada na frequência predominante
sinal_aproximado = A * cos(2 * pi * f_dominante * t + phi);

% Plota o sinal original e o sinal aproximado
figure;
subplot(2,1,1);
plot(t, y);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Original');

subplot(2,1,2);
plot(t, sinal_aproximado);
% xlim([0 20]);
xlabel('Tempo (s)');
ylabel('Amplitude');
title(['Sinal Aproximado com f = ', num2str(f_dominante), ' Hz']);

% fazer o sinal passar pela portadora
fc = 10000;
tc = 1/fc;

c_t = cos(2*pi*fc*t);

sinal_modulado = c_t .* sinal_aproximado;

% demodular o sinal