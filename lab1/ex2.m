pkg load signal;

clear all; close all; clc;
f= 1000;
T= 1/f;

fs = 60 * 5*f;
ts = 1/fs;
phi = 0;

t = 0 : ts : 1;
% t = 0 : ts : (300000)*ts;

s1_t = 5*sin(2*pi*f*t);
s2_t = (5/3)*sin(2*pi*3*f*t);
s3_t = 1*sin(2*pi*5*f*t);

s_t = s1_t + s2_t + s3_t;

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
plot(t, s_t);
xlim([0 3*T]);

% dominio da frequencia
# passo_f = length(t)/(fs+1);
passo_f = fs / length(t);
f_axis = -fs/2 : passo_f : fs/2 - passo_f;

% Certifique-se de que o comprimento de f_axis corresponde ao de t
% if length(f_axis) > length(t)
%    f_axis = f_axis(1:end-1); % Remove o último elemento se necessário
% end

X_fs1 = fft(s1_t)/length(s1_t);
X_fs1 = fftshift(X_fs1);

X_fs2 = fft(s2_t)/length(s2_t);
X_fs2 = fftshift(X_fs2);

X_fs3 = fft(s3_t)/length(s3_t);
X_fs3 = fftshift(X_fs3);

X_fst = fft(s_t)/length(s_t);
X_fst = fftshift(X_fst);

% falta colocar label
figure;
subplot(4,1,1); hold on; grid on;
plot(f_axis, abs(X_fs1));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Domínio da Frequência');
xlim([-3000 3000]);

subplot(4,1,2); hold on; grid on;
plot(f_axis, abs(X_fs2));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
xlim([-5000 5000])

subplot(4,1,3); hold on; grid on;
plot(f_axis, abs(X_fs3));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
xlim([-6000 6000])

subplot(4,1,4); hold on; grid on;
plot(f_axis, abs(X_fst));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
xlim([-6000 6000])

% filtros no domínio do tempo
filtro_pb = [zeros(1,148000) ones(1,4001) zeros(1,148000)];
filtro_pa = [ones(1,146000) zeros(1,8001) ones(1,146000)];
filtro_pf = [zeros(1,146000) ones(1,2000) zeros(1,4001) ones(1,2000) zeros(1,146000)];

st_pb = X_fst .* filtro_pb;
figure;
subplot(3,1,1); hold on; grid on;
plot(f_axis, st_pb);
xlim([-4000 4000])

st_pa = X_fst .* filtro_pa;
subplot(3,1,2); hold on; grid on;
plot(f_axis, st_pa);
xlim([-6000 6000])

st_pf = X_fst .* filtro_pf;
subplot(3,1,3); hold on; grid on;
plot(f_axis, st_pf);
xlim([-4000 4000])

st_pb_filtrado = ifft(ifftshift(st_pb));
st_pa_filtrado = ifft(ifftshift(st_pa));
st_pf_filtrado = ifft(ifftshift(st_pf));

figure;
subplot(4,1,1); hold on; grid on;
plot(t, st_pb_filtrado);
xlim([0 3*T]);

subplot(4,1,2); hold on; grid on;
plot(t, st_pf_filtrado);
xlim([0 3*T]);

subplot(4,1,3); hold on; grid on;
plot(t, st_pa_filtrado);
xlim([0 3*T]);