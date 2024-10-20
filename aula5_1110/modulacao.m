clear all; close all; clc;

f= 1000;
T= 1/f;

fs = 60 * f;
ts = 1/fs;
phi = 0;

t = 0 : ts : 1;

n_t = cos(2*pi*f*t);
c_t = cos(2*pi*10*f*t);

sinal_modulado = n_t.*c_t;

figure;
subplot(3,1,1); hold on; grid on;
plot(t, n_t);
xlim([0 3*T]);

subplot(3,1,2); hold on; grid on;
plot(t, c_t);
xlim([0 3*T]);

subplot(3,1,3); hold on; grid on;
plot(t, sinal_modulado);
xlim([0 3*T]);

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
subplot(4,1,1); hold on; grid on;
plot(f_axis, abs(Xf_n));

subplot(4,1,2); hold on; grid on;
plot(f_axis, abs(Xf_c));

subplot(4,1,3); hold on; grid on;
plot(f_axis, abs(Xf_sinalMod));

# demodulação

d_t = cos(cos(2*pi*f*t));

st_demod = d_t .* sinal_modulado;

figure;
subplot(4,1,1); hold on; grid on;
plot(t, n_t);
xlim([0 3*T]);

subplot(4,1,2); hold on; grid on;
plot(t, c_t);
xlim([0 3*T]);

subplot(4,1,3); hold on; grid on;
plot(t, sinal_modulado);
xlim([0 3*T]);

subplot(4,1,4); hold on; grid on;
plot(t, st_demod);
xlim([0 3*T]);