%Naive GE to find Determinant of a square matrix
pause('on');

%counting number of row swaps, each swap changes det to multiply by -1
swap = 0;
determinant = 1;

%Get size of matrix from user
n=input('Enter size of your n*n matrix: ');

%Getting matrix A
A=input('\nEnter Matrix A in square brackets. \nSeparate elements using a comma and rows using a semi-colon: ');
disp(A);


for col=1:n

    %if leading entry is 0, and row is not the last row, try swap with below row to prevent /0
    if (A(col,col)==0) & (col~=n)
        C=A(col,:);
        A(col,:)=A(col+1,:);
        A(col+1,:)=C;
        swap=swap+1;
    end
    
    %chaging rows underneath leading entry to 0
    for row=col+1:n
        %eg (-3)R1 + R3 --> R3
        %den and numm are denominator and numerator. They help find what
        %number to multiply R1 by, in the above example
        num=A(row,col); %current element to turn to 0
        den=A(col,col); %diagonal element which must have zeros underneath
        A(row,:)=A(row,:)+(-num/den)*A(col,:);
        
    end
     
end

disp('Upper Triangular Matrix Is: ');
disp(A);

%multiplying diagonals of new triangular matrix
for col=1:n
   determinant = determinant * A(col, col);
end

%depending on total number of swaps, multiply determinant by -1
if mod(swap,2)==1 %if odd nummber of swaps
    dterminant = determinant*-1;
end

disp('Determinant is: ')
disp(determinant);