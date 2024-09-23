clear all; close all; clc;

f= 100;
T= 1/f;

fs = 60 * f;
ts = 1/fs;
phi = 0;

t = 0 : ts : 1;

s1_t = 10*cos(2*pi*f*t) + cos(2*pi*2*f*t) + 4*cos(2*pi*3*f*t);

figure; hold on; grid on;
plot(t,s1_t);
xlim([0 5*T]);