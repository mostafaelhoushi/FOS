function [ p ] = evalterm( x, y, lags)
%GETFUNCTION Summary of this function goes here
%   Detailed explanation goes here

p = ones(length(x),1);

for i=1:length(lags.x)
    k = lags.x(i);
    p = p.*delay(x,k);
end

for i=1:length(lags.y)
    l = lags.y(i);
    p = p.*delay(y,l);
end

end

