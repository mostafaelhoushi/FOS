function [ y1 ] = evalfunct( x, y, p, a )
%EVALFUNCT Summary of this function goes here
%   Detailed explanation goes here

y1 = ones(length(x),1);
y1 = y1 * a(1);
for j=2:length(p)
    y1 = y1 + a(j) * evalterm(x, y, p(j));
end

end

