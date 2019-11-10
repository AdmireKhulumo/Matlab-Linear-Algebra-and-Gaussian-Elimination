M=[1 -1 2;-1 2 -1;1 -3 1];

[m,n] = size(M);
A = [M, eye([m, n])];
for row = 1:m
    A(row,row:end) = A(row,row:end)/A(row,row);
    A([1:row-1,row+1:end],row:end) = ...
                    A([1:row-1,row+1:end],row:end) - A([1:row-1,row+1:end],row)*A(row,row:end);
end
disp(A(:,n+1:end));