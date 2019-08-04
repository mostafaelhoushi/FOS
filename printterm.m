function str = printterm( lags)
%PRINTTERM prints polynomial term
%   Prints and returns string representation
%   of a polynomial term as a product of
%   lags

str = ''

for i=1:length(lags.x)
    k = lags.x(i);
    if k == 0
        str = str + 'x[n]'
    else
        str = str + 'x[n - ' + num2str(k) + ']'
    end
    
    if i < length(lags.x)
        str = str + '*'
    end
end

for i=1:length(lags.y)
    l = lags.y(i);
    if l == 0 % this condition should never happen
        str = str + 'y[n]'
    else
        str = str + 'y[n - ' + num2str(l) + ']'
    end
    
    if i < length(lags.y)
        str = str + '*'
    end
end

print(str)

end

