clear all; close all; clc;

fm= 1000;
Tm= 1/fm;

fc= 100000;
Tc= 1/fc;

fs = 60 * f;
ts = 1/fs;

t = 0 : ts : 1;

m_t = cos(2*pi*fm*t);
%usar fc e não 10*f
c_t = cos(2*pi*fc*t);
Ao = 2;

% m = 0.5
sinal_modulado = (m_t.*c_t) + (Ao.*c_t);

% m = 1
m_t = 2*cos(2*pi*fm*t);
sinal_modulado2 = (m_t.*c_t) + (Ao.*c_t);

% m = 1.5
m_t = 3*cos(2*pi*fm*t);
sinal_modulado3 = (m_t.*c_t) + (Ao.*c_t);

figure;
subplot(3,1,1); hold on; grid on;
plot(t, sinal_modulado);
xlim([0 5*T]);

subplot(3,1,2); hold on; grid on;
plot(t, sinal_modulado2);
xlim([0 5*T]);

subplot(3,1,3); hold on; grid on;
plot(t, sinal_modulado3);
xlim([0 5*T]);