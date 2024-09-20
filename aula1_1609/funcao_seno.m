clear all; close all; clc;

f= 1000;
T= 1/f;

fs = 40 * f;
ts = 1/fs;
phi = 0;

t = 0 : ts : 1;
x_t= sin(2*pi*f*t + phi);

figure;
subplot(2,1,1); hold on; grid on;
plot(t,x_t);
#stem - dá para usar essa também, pois mostra as amostras (sinal amostrado)
xlim([0 5*T]);
ylim([-2 2]);

# transformada de fourier - fourier fast transform
X_f = fft(x_t)/length(x_t);
X_f = fftshift(X_f);

passo_f = length(t)/(fs+1);
f = -fs/2 : passo_f : fs/2;

subplot(2,1,2); hold on; grid on;
plot(f, abs(X_f));

# gerar soma de 3 conssenos

# gerar uma onda quadrada