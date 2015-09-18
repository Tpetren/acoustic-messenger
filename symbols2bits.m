function y = symbols2bits(symbols)
%symbols2bits Does frame synchronization and converts symbols to bits.
%   symbols - The sequence of symbols.

[m,n]=size(symbols);
bits=[];

% An if statement makes sure that the symbols can be in the columns or rows
% in the symbol matrix

if n>m
    for i=1:n
        for j=1:m
            bits = [bits symbols(j,i)];
        end
    end
else
    for k=1:m
        for l=1:n
            bits = [bits symbols(k,l)];
        end
    end
end

y = bits;

end

