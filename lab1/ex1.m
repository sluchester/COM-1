clear all; close all; clc;

f= 1000;
T= 1/f;

fs = 60 * f;
ts = 1/fs;
phi = 0;

t = 0 : ts : 1;

s1_t = 6*sin(2*pi*f*t);
s2_t = 2*sin(2*pi*3*f*t);
s3_t = 4*sin(2*pi*5*f*t);

sinal_somado = s1_t + s2_t + s3_t;

figure;
subplot(4,1,1); hold on; grid on;
plot(t, s1_t);
xlim([0 3*T]);

subplot(4,1,2); hold on; grid on;
plot(t, s2_t);
xlim([0 3*T]);

subplot(4,1,3); hold on; grid on;
plot(t, s3_t);
xlim([0 3*T]);

subplot(4,1,4); hold on; grid on;
plot(t, sinal_somado);
xlim([0 3*T]);


# dominio da frequencia
passo_f = length(t)/(fs+1);
f_axis = -fs/2 : passo_f : fs/2;

X_fs1 = fft(s1_t)/length(s1_t);
X_fs1 = fftshift(X_fs1);

X_fs2 = fft(s2_t)/length(s2_t);
X_fs2 = fftshift(X_fs2);

X_fs3 = fft(s3_t)/length(s3_t);
X_fs3 = fftshift(X_fs3);

X_fst = fft(sinal_somado)/length(sinal_somado);
X_fst = fftshift(X_fst);

figure;
subplot(4,1,1); hold on; grid on;
plot(f_axis, abs(X_fs1));

subplot(4,1,2); hold on; grid on;
plot(f_axis, abs(X_fs2));

subplot(4,1,3); hold on; grid on;
plot(f_axis, abs(X_fs3));

subplot(4,1,4); hold on; grid on;
plot(f_axis, abs(X_fst));

# calculando a potencia
# pot_med = 1/length(t)*sum(soma_t.^2);


# norm do vetor ² da energia
# 1/length(t) * X²