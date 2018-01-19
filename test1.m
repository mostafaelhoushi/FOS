%% Initialize
set(0,'DefaultFigureWindowStyle','docked');
close all;
clear all;
clc;
P = 0;
N = 1000;

K = 6;
L = 5;
order = 2;

N0 = max(K,L);
%% Generate x
% Uniformly distributed pseudorandom numbers [0,1] 
rng(0);
x = rand(N, 1);

%% Generate y
y = zeros(N, 1);
for n = 3:N
    y(n) = sin(x(n-1))*cos(x(n)) + exp(-3*x(n))*sqrt(abs(x(n))) + 0.1*log(abs(y(n-2)+0.01))*y(n-1);
end

%% Apply FOS
tic
[a, p] = fos( x(1:N), y(1:N), K, L, order );
toc
y1 = evalfunct( x(1:N), y(1:N), p, a );
e = y1 - y(1:N);
MSEpercent = mean(e(N0+1:N).^2)/var(y(N0+1:N)) *100;
