clear all; close all; clc;
pkg load signal;

f= 1000;
T= 1/f;

fc = 10000;

fs = 60 * f;
ts = 1/fs;
t = 0 : ts : 1;

An = 1;
Ac = 1;

n_t = An * cos(2*pi*f*t);
c_t = Ac * cos(2*pi*fc*t);

sinal_modulado = n_t .* c_t;

% gráficos do domínio do tempo
figure;
subplot(3,1,1); hold on; grid on;
plot(t, n_t);
xlim([0 3*T]);
title('Sinal Modulador');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(3,1,2); hold on; grid on;
plot(t, c_t);
xlim([0 3*T]);
title('Sinal da Portadora');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(3,1,3); hold on; grid on;
plot(t, sinal_modulado);
xlim([0 3*T]);
title('Sinal Modulado');
xlabel('Tempo (s)');
ylabel('Amplitude');

# dominio da frequencia
passo_f = length(t)/(fs+1);
f_axis = -fs/2 : passo_f : fs/2;

Xf_n = fft(n_t)/length(n_t);
Xf_n = fftshift(Xf_n);

Xf_c = fft(c_t)/length(c_t);
Xf_c = fftshift(Xf_c);

Xf_sinalMod = fft(sinal_modulado)/length(sinal_modulado);
Xf_sinalMod = fftshift(Xf_sinalMod);

figure;
subplot(3,1,1); hold on; grid on;
plot(f_axis, abs(Xf_n));
xlim([-3000 3000]);
title('Espectro de Frequência Sinal Modulador');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

subplot(3,1,2); hold on; grid on;
plot(f_axis, abs(Xf_c));
xlim([-11000 11000]);
title('Espectro de Frequência Sinal da Portadora');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

subplot(3,1,3); hold on; grid on;
plot(f_axis, abs(Xf_sinalMod));
xlim([-13000 13000]);
title('Espectro de Frequência Sinal Modulado');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

#demodulacao
sinal_demodulado = sinal_modulado .* c_t;
Xf_sinalDemod = fft(sinal_demodulado)/length(sinal_demodulado);
Xf_sinalDemod = fftshift(Xf_sinalDemod);

figure;
subplot(2,1,1); hold on; grid on;
plot(t, sinal_demodulado);
xlim([0 3*T]);
title('Sinal Demodulado');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(2,1,2); hold on; grid on;
plot(f_axis, abs(Xf_sinalDemod));
xlim([-22000 22000]);
title('Espectro de Frequência Sinal Demodulado');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

% Filtro passa-baixa FIR para recuperar a mensagem
fcutoff = 1000; % Frequência de corte do filtro passa-baixa
order = 500; % Ordem do filtro FIR (quanto maior, mais acentuada a transição)
b = fir1(order, (fcutoff*2)/fs); % Coeficientes do filtro FIR
sinal_recuperado = filter(b, 1, sinal_demodulado);

sinal_recuperado_freq = fft(sinal_recuperado)/length(sinal_recuperado);
sinal_recuperado_freq= fftshift(sinal_recuperado_freq);

figure;
subplot(4,1,1); hold on; grid on;
plot(t, sinal_modulado);
xlim([0 3*T]);
title('Sinal Modulador Original');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(4,1,2); hold on; grid on;
plot(f_axis, abs(Xf_n));
xlim([-3000 3000]);
title('Espectro de Frequência Sinal Modulador');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

subplot(4,1,3); hold on; grid on;
plot(t, sinal_recuperado);
xlim([0 60*T]);
title('Sinal Recuperado');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(4,1,4); hold on; grid on;
plot(f_axis, abs(sinal_recuperado_freq));
xlim([-3000 3000]);
title('Espectro de Frequência Recuperado');
xlabel('Frequência (Hz)');
ylabel('Magnitude');