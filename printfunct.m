function str = printfunct( p, a )
%PRINTFUNCT Prints the symbolic function in text format
%   Given the coefficients a, and polynomials
%   terms p, print and return the function in text format,
%   e.g., "y1[n] = 0.5*x[n] + 0.2*x^2[n-1]*y{n]

str = ''
str = str + 'yest[n] = ' + num2str(a1);
for j=2:length(p)
    str = str + ' ' + num2str(a(j)) + '*' + printterm(p(j));
end

print(str)

end

