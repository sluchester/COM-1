clear all; close all; clc;

f= 100;
T= 1/f;

fs = 60 * f;
ts = 1/fs;
phi = 0;

t = 0 : ts : 1;

s1_t = 10*cos(2*pi*f*t) + cos(2*pi*2*f*t) + 4*cos(2*pi*3*f*t);
s2_t = 2 + 6*cos(2*pi*f*t);
s3_t = 10*cos(2*pi*f*t) + 5*cos(2*pi*2*f*t);

# calculando a potencia media dos sinais acima
pot_med1 = 1/length(t)*sum((s1_t.^2))
pot_med2 = 1/length(t)*sum((s2_t.^2))
pot_med3 = 1/length(t)*sum((s3_t.^2))

# calculo da média = Potencia DC
media2 = mean(s2_t)
# calculo da variancia = Potencia AC
var2 = var(s2_t)

subplot(2,1,1); hold on; grid on;
plot(t, s1_t);
xlim([0 T]);

subplot(2,1,2); hold on; grid on;
plot(t, pot_med1);
xlim([0 T]);
# figure; hold on; grid on;
# plot(t,pot_med1);
# xlim([0 T]);

# figure(2); hold on; grid on;
# plot(t,pot_med2);
# xlim([0 T]);