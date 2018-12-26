function [ x1 ] = delay( x, k )
%DELAY Summary of this function goes here
%   Detailed explanation goes here

x1 = [zeros(k,size(x,2)); x(1:end-k)];

end

