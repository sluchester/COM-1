# Exemple of page 174 of RTL-SDR Matlab book, showing sometimes is more efficient to see a signal in the
# frequency domain and not in the time domain.

clear all; close all; clc;

f= 100;
T= 1/f;

fs = 60 * f;
ts = 1/fs;
phi = 0;

t = 0 : ts : 1;
s1_t = 10*cos(2*pi*f*t) + cos(2*pi*2*f*t) + 4*cos(2*pi*3*f*t);

subplot(2,1,1); hold on; grid on;
plot(t,s1_t);
xlim([0 5*T]);

X_f = fft(s1_t/length(s1_t));
X_f = fftshift(X_f);

passo_f = length(t)/(fs+1);
f_axis = -fs/2 : passo_f : fs/2;

subplot(2,1,2); hold on; grid on;
plot(f_axis, X_f);