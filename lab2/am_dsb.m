clear all; close all; clc;

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
ka = 0.25;
% fator modulante
mi = ka*An;

sinal_modulado = (1 + mi*n_t) .* c_t;

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
title('Sinal Modulado para \mu=0.25');
xlabel('Tempo (s)');
ylabel('Amplitude');

# frequencia
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
xlim([-5000 5000]);
title('Espectro de Frequência Sinal Modulador');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

subplot(3,1,2); hold on; grid on;
plot(f_axis, abs(Xf_c));
xlim([-13000 13000]);
title('Espectro de Frequência da Portadora');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

subplot(3,1,3); hold on; grid on;
plot(f_axis, abs(Xf_sinalMod));
xlim([-13000 13000]);
title('Espectro de Frequência Sinal Modulado');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

subplot(5,1,1); hold on; grid on;
plot(t, sinal_modulado);
xlim([0 3*T]);
title('Sinal Modulado para \mu=0.5');
xlabel('Tempo (s)');
ylabel('Amplitude');

ka = 0.5;
% fator modulante
mi = ka*An;

sinal_modulado = (1 + mi*n_t) .* c_t;
subplot(5,1,2); hold on; grid on;
plot(t, sinal_modulado);
xlim([0 3*T]);
title('Sinal Modulado para \mu=0.5');
xlabel('Tempo (s)');
ylabel('Amplitude');

ka = 0.75;
% fator modulante
mi = ka*An;

sinal_modulado = (1 + mi*n_t) .* c_t;
subplot(5,1,3); hold on; grid on;
plot(t, sinal_modulado);
xlim([0 3*T]);
title('Sinal Modulado para \mu=0.75');
xlabel('Tempo (s)');
ylabel('Amplitude');

ka = 1.0;
% fator modulante
mi = ka*An;

sinal_modulado = (1 + mi*n_t) .* c_t;
subplot(5,1,4); hold on; grid on;
plot(t, sinal_modulado);
xlim([0 3*T]);
title('Sinal Modulado para \mu=1.0');
xlabel('Tempo (s)');
ylabel('Amplitude');

ka = 1.5;
% fator modulante
mi = ka*An;

sinal_modulado = (1 + mi*n_t) .* c_t;
subplot(5,1,5); hold on; grid on;
plot(t, sinal_modulado);
xlim([0 3*T]);
title('Sinal Modulado para \mu=1.5');
xlabel('Tempo (s)');
ylabel('Amplitude');