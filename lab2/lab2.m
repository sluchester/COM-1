clear all; close all; clc;
pkg load signal;

filename1= 'audio1.wav';
filename2= 'audio2.wav';
filename3= 'audio3.wav';

% o novo sinal agora é y
% fs é a frequencia amostrada do sinal - igual para todos
[y1, fs] = audioread(filename1);
y1 = y1';
[y2, fs] = audioread(filename2);
y2 = y2';
[y3, fs] = audioread(filename3);
y3 = y3';

% periodo de amostragem
ts=1/fs;

% poderia fazer um if else para saber qual o maior sinal e preencher os outros
% mas como eu já sei qual é o maior (audio2), farei manualmente
% referência é o comprimento do audio2
target_length = length(y2);

% preenchendo os outros sinais com zeros
y1 = [y1, zeros(1, target_length - length(y1))];
y3 = [y3, zeros(1, target_length - length(y3))];

% vetor de tempo para cada sinal
t1=(0:length(y1)-1)*ts;
t2=(0:length(y2)-1)*ts;
t3=(0:length(y3)-1)*ts;

% usar filtro passa baixa - verificar função correta
% para tirar dúvida, poderia plotar o gráfico da frequência e verificar a partir 
  % de quais delas há maior necessidade de se considerar.
% Nesse caso, como é só um sinal de voz, iremos considerar a banda da nossa voz (3kHz)
fc_filter = 3000;
order = 50;

% construir o sinal para multiplicar 
m1_t = cos(2*pi*fc_filter*t1);
m2_t = cos(2*pi*fc_filter*t2);
m3_t = cos(2*pi*fc_filter*t3);

figure;
subplot(2,1,1);
plot(t, y);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinal Original');

subplot(2,1,2);
plot(t, sinal_aproximado);
% xlim([0 20]);
xlabel('Tempo (s)');
ylabel('Amplitude');
title(['Sinal Aproximado com f = ', num2str(f_dominante), ' Hz']);


% multiplicar pela portadora
fc1 = 6000;
fc2 = 10000;
fc1 = 14000;
phi = 0;

c1_t = cos(2*pi*fc1 + phi);
c2_t = cos(2*pi*fc2 + phi);
c3_t = cos(2*pi*fc3 + phi);

% usar filtro passa faixa - verificar função correta

% somar todos os sinais

% usar filtro passa faixa para efetuar a regeneração de cada sinal - verificar função correta

% multiplicar pelas portadoras novamente

% usar filtro passa baixa para regenerar o sinal