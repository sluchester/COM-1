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
# gera um sinal de 0 até fs
X_f = fft(x_t)/length(x_t);
# desloca a frequência 0 da transformada de fourier para o centro do array (ou da figura que sera gerada)
# gera um sinal de -fs/2 até fs/2
X_f = fftshift(X_f);

passo_f = length(t)/(fs+1);
f = -fs/2 : passo_f : fs/2;

subplot(2,1,2); hold on; grid on;
plot(f, abs(X_f));

# gerar soma de 3 cossenos
# sinal 1
w1 = 2*pi*f;
x1_t = cos(w1*t + phi);

# sinal 2
f2 = 5*f;
T2 = 1/f2;
f2s = 30 * f2;
T2s = 1/f2s;
t2 = 0 : T2s : 1;
w2 = 2*pi*f2;

x2_t = cos(w2*t2 + phi);

figure;
subplot(3,1,1); hold on; grid on;
plot(t2,x2_t);
xlim([0 5*T2]);
ylim([-2 2]);

X2_f = fft(x2_t)/length(x2_t);
X2_f = fftshift(X2_f);

passo2_f = length(t2)/(f2s+1);
f2 = -f2s/2 : passo2_f : f2s/2;

subplot(3,1,2); hold on; grid on;
plot(f2, abs(X2_f));

#sinal 3
f3 = 15*f;
T3 = 1/f3;
f3s = 30 * f3;
T3s = 1/f3s;
t3 = 0 : T3s : 1;
w3 = 2*pi*f3;

x3_t = cos(w3*t3 + phi);

figure;
subplot(4,1,1); hold on; grid on;
plot(t3,x3_t);
xlim([0 5*T3]);
ylim([-2 2]);

X3_f = fft(x3_t)/length(x3_t);
X3_f = fftshift(X3_f);

passo3_f = length(t3)/(f3s+1);
f3 = -f3s/2 : passo3_f : f3s/2;

subplot(4,1,2); hold on; grid on;
plot(f3, abs(X3_f));

# soma dos 3 cossenos
soma_t = x1_t + x2_t + x3_t;

figure;
subplot(5,1,1); hold on; grid on;
plot(t1 + t2 + t3,soma_t);

# gerar uma onda quadrada - ?
# gera 100 pontos de vetores igualmente espaçados 
t = linspace(0,3*pi)';
Xsq_t = square(t);
plot(t/pi,Xsq_t,'.-',t/pi,sin(t));
xlabel('t / \pi');
grid on;