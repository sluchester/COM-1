clear all; close all; clc;

f= 1000;
T= 1/f;

fs = 60 * f;
ts = 1/fs;
phi = 0;

t = 0 : ts : 1;

# figure;
#subplot(2,1,1); hold on; grid on;
#plot(t,x_t);
#stem - dá para usar essa também, pois mostra as amostras (sinal amostrado)

# transformada de fourier - fourier fast transform
# gera um sinal de 0 até fs
# X_f = fft(x_t)/length(x_t);
# desloca a frequência 0 da transformada de fourier para o centro do array (ou da figura que sera gerada)
# gera um sinal de -fs/2 até fs/2
#X_f = fftshift(X_f);

#subplot(2,1,2); hold on; grid on;
#plot(f_axis, abs(X_f));

# gerar soma de 3 cossenos
#sinal fundamental
x_t= sin(2*pi*f*t + phi);

# sinal 1
f1 = 3*f;
w1 = 2*pi*f1;
x1_t = sin(w1*t);

# sinal 2
f2 = 5*f;
T2 = 1/f2;
# t2 = 0 : T2s : 1;
w2 = 2*pi*f2;
x2_t = sin(w2*t + phi);

#sinal 3
f3 = 7*f;
T3 = 1/f3;
# t3 = 0 : T3s : 1;
w3 = 2*pi*f3;
x3_t = sin(w3*t + phi);

# soma dos 3 cossenos
soma_t = x_t + (1/3)*x1_t + (1/5)*x2_t + (1/7)*x3_t;

figure;
subplot(5,1,1); hold on; grid on;
plot(t,x_t);
xlim([0 5*T]);
ylim([-2 2]);

subplot(5,1,2); hold on; grid on;
plot(t,x1_t);
xlim([0 5*T]);
ylim([-2 2]);

subplot(5,1,3); hold on; grid on;
plot(t,x2_t);
xlim([0 5*T]);
ylim([-2 2]);

subplot(5,1,4); hold on; grid on;
plot(t,x3_t);
xlim([0 5*T]);
ylim([-2 2]);

subplot(5,1,5); hold on; grid on;
plot(t,soma_t);
xlim([0 5*T]);
ylim([-2 2]);

# frequencia
passo_f = length(t)/(fs+1);
f_axis = -fs/2 : passo_f : fs/2;

X1_f = fft(x1_t)/length(x1_t);
X1_f = fftshift(X1_f);

X2_f = fft(x2_t)/length(x2_t);
X2_f = fftshift(X2_f);

X3_f = fft(x3_t)/length(x3_t);
X3_f = fftshift(X3_f);

Xsoma_f = fft(soma_t)/length(soma_t);
Xsoma_f = fftshift(Xsoma_f);

figure;
subplot(4,1,1); hold on; grid on;
plot(f_axis, abs(X1_f));

subplot(4,1,2); hold on; grid on;
plot(f_axis, abs(X2_f));

subplot(4,1,3); hold on; grid on;
plot(f_axis, abs(X3_f));

subplot(4,1,4); hold on; grid on;
plot(f_axis, abs(Xsoma_f));

# gerar uma onda quadrada - ?
# gera 100 pontos de vetores igualmente espaçados 