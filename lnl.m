function [y, u] = lnl( g, a, k, x )
%LNL Summary of this function goes here
%   Detailed explanation goes here
u = filter(1, g, x);

v = zeros(size(u));
for i=1:length(a)
    v = v + a(i)*u.^i;
end

y = filter(1, k, v);

end

