%% Initialize
set(0,'DefaultFigureWindowStyle','docked');
close all;
clc;

s=dbstatus;
save('myBreakpoints.mat', 's');
clear all;
load('myBreakpoints.mat');
dbstop(s);
delete('myBreakpoints.mat');

P = 0;
N = 1000;

K = 3;
L = 3;
order = 3;

N0 = max(K,L);
%% Generate x
% Uniformly distributed pseudorandom numbers [0,1]
rng(1);
x1 = rand(N, 1);
rng(2);
x2 = rand(N, 1);

%% Generate y
y1 = zeros(N, 1);
y2 = zeros(N, 1);
for n = 3:N
    y1(n) = 0.75 + 0.9*x1(n-2)*x2(n-1)*x1(n) + 3.2*x1(n) + 2.8*x2(n-2)^2 + 0.8*x2(n-1)*y2(n-1);
    y2(n) = 0.9 + 0.3*x2(n-1)*x1(n-2)*y1(n-1) + 5*x2(n-1) + 1.4*x1(n-1)^2 + 0.1*x1(n-2)*y2(n-2);
end

%% Apply FOS
tic
[a, p, Q] = fos( [x1 x2], [y1 y2], K, L, order );
toc

figure; hold on;
plot(0:length(a{1})-1, Q(1, 1:length(a{1})), 'g');
plot(0:length(a{2})-1, Q(2, 1:length(a{2})), 'y');
ylabel('Q[m]'); xlabel('m'); legend('y1', 'y2');

yest = evalfunct( [x1 x2], [y1 y2], p, a );
y1est = yest(:,1);
y2est = yest(:,2);
e1 = y1est - y1;
MSEpercent1 = mean(e1(N0+1:N).^2)/var(y1(N0+1:N)) *100;
e2 = y2est - y2;
MSEpercent2 = mean(e2(N0+1:N).^2)/var(y2(N0+1:N)) *100;

figure; plot(y1, 'b'); hold on; plot(y1est, 'r'); legend('y1', 'y1est'); xlabel('n'); ylabel('y[n]');
figure; plot(y2, 'b'); hold on; plot(y2est, 'r'); legend('y2', 'y2est'); xlabel('n'); ylabel('y[n]');