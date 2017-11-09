%% Initialize
set(0,'DefaultFigureWindowStyle','docked');
close all;
clear all;
clc;
P = 0;
N = 1000;

%% Generate x
% Uniformly distributed pseudorandom numbers [0,1] 
% rng(0);
% x = rand(3*N, 1);

% Uniform distribution 
% sigmax = 1;
% rng(0);
% x1 = rand(3*N, 1);
% x = x1 / std(x1) * sigmax;

% Normal distribution
% sigmax = 1;
% rng(0);
% x1 = randn(3*N, 1);
% x = x1 / std(x1) * sigmax;

% Sinusoidal
f = 1;
A = 1;
t = (1:3*N)';
x = A*sin(2*pi*f*t);

% Triangular
% width = 1;
% A = 1;
% t = (1:3*N)';
% x = A*sawtooth(t,width);

%% Generate y
% Simple Difference Equation 1
y = 1 +  0.6*x  + 0.3*delay(x,1) + 0.4*delay(x,2) + 0.7*delay(x,3);

% Simple Difference Equation 2
% y = zeros(3*N, 1);
% for n = 2:3*N
%     y(n) = 2 + 0.5*x(n)*y(n-1);
% end

% Complex Difference Equation
% y = zeros(3*N, 1);
% 
% a0 = 1;
% b0 = 0.7;
% b1 = 0.8;
% c1 = 0.1;
% c2 = 0.4;
% c4 = 0.2;
% 
% for n = 6:3*N
%     y(n) = a0 + b0*x(n) + b1*x(n-1) + c1*x(n-1)*y(n-1) - c2*x(n)*x(n-1)+ c4*x(n-4)*x(n-5);
% end

% LNL Cascade
% i = 1:5;
% g1 = exp(-i) + exp(-2*i);
% a1 = 0.5 + 2*exp(-i);
% k1 = 3*exp(-i);
% 
% g2 = exp(-i) + 3*exp(-2*i);
% a2 = 0.2 + 3*exp(-i);
% k2 = 0.1*exp(-i) + 0.9*exp(-2*i);
% 
% y = lnl(g1, a1, k1, x) + lnl(g2, a2, k2, x);

% Non-Polynomial Equation
% y = zeros(3*N, 1);
% for n = 3:3*N
%     y(n) = sin(x(n-1))*cos(x(n)) + exp(-3*x(n))*sqrt(abs(x(n))) + 0.1*log(abs(y(n-2)+0.01))*y(n-1);
% end

% Real Data 1 - Project 2
% load wz.mat;
% wzd = wden(wz, 'heursure', 's', 'one', 15, 'db4');
% x = (1:3*N)';
% y = wzd(1:3*N);
% w = wden(wz, 'heursure', 's', 'one', 14, 'db4'); w=w(1:length(x));
% r = w - y;
% P = 100 * var(r)/var(y);

% Real Data 2 - Project 3
% load 'C:\Data Logging\EE 517 Winter 2012\Project 3\Xbow_stat_data_other.mat';
% x = (1:3*N)';
% y = f.x(1:3*N);
% clear f w interp_info denoising_info denoising_info_ orig_data_info;

% Noise Insertion
% rng(1);
% r1 = wgn(3*N, 1, 0);
% r1 = r1 - mean(r1);
% r = r1 / std(r1) * sqrt(P/100) * std(y);
% w = r + y;

% K = 6;
% L = 5;
% order = 5;
% N0 = max(K,L);
% tic
% [a, p] = fos( x(1:N), y(1:N), K, L, order );
% toc
% y1 = evalfunct( x(1:N), y(1:N), p, a );
% e = y1 - y(1:N);
% MSEpercent = mean(e(N0+1:N).^2)/var(y(N0+1:N)) *100;


%% Training Phase
tic
% Apply FOS for 1st 1000 samples of data
rng(2);
K = randi([3,20], 10, 1);
rng(3);
L = randi([3,20], 10, 1);
for i = 1:length(K)
    order = 2;
    N0 = max(K(i),L(i));
    %tic
    [at{i}, pt{i}] = fos( x(1:N), w(1:N), K(i), L(i), order );
    %toc
    
    y1 = evalfunct( x(1:N), w(1:N), pt{i}, at{i} );
    e = y1 - w(1:N);
    MSEpercent(i) = mean(e(N0+1:N).^2)/var(w(N0+1:N)) *100;
end

%% Selection Phase
clear MSEpercent;
% Apply FOS for 2nd 1000 samples of data
for i = 1:1:length(K) 
    y1 = evalfunct( x(N+1:2*N), w(N+1:2*N), pt{i}, at{i} );
    e = y1 - w(N+1:2*N);
    MSEpercent(i) = mean(e(N0+1:N).^2)/var(w(N+N0+1:2*N)) *100;
end

% Choose the best model over the 2nd 1000 samples
index = find(MSEpercent == min(MSEpercent));
as = at{index(1)};
ps = pt{index(1)};


%% Evaluation Phase
clear MSEpercent;
% Apply FOS for 3nd 1000 samples of data
y1 = evalfunct( x(2*N+1:3*N), w(2*N+1:3*N), ps, as);
e = y1 - y(2*N+1:3*N);
MSEpercent = mean(e(N0+1:N).^2)/var(y(2*N+N0+1:3*N)) *100;
IdealMSEPercent = var(r) / var(w) * 100;

e = y1 - w(2*N+1:3*N);
MSEpercent1 = mean(e(N0+1:N).^2)/var(w(2*N+N0+1:3*N)) *100;


%% Plot
y1 = evalfunct( x, w, ps, as);
figure(1);
plot(y, 'b'); hold on;
plot(N0+1:3*N, y1(N0+1:3*N),'r');
xlabel('n');
ylabel('y[n]');
legend('y', 'y1');

figure(3);
Rw = xcorr(w - mean(w));
plot(-length(Rw)/2:length(Rw)/2-1 , Rw);
title('Auto-correlation of output w[n]');
xlabel('n');
ylabel('R(w)');

toc

%% Plot Q[m] for best K & L
order = 2;
N0 = max( K(index(1)) , L(index(1)) );
[a, p] = fos( x(1:N), y(1:N), K(index(1)), L(index(1)), order );