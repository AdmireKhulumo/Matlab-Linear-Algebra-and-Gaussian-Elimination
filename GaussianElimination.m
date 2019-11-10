%Naive Gauss-Jordan Elimination: Solving Ax=b, where A is an nxn matrix, b and x are vectors
pause('on');

%Get size of matrix from user
m=input('Enter m for your m*n matrix: ');
n=input('Enter n of your m*n matrix: ');

%Getting matrix A 
A=input('\nEnter Matrix A in square brackets. \nSeparate elements using a comma and rows using a semi-colon: ');
disp(A);
%Getting column vector b 
b=input('Enter column vector b. \nSeparate rows using a semi-colon: ');
disp(b);

if m<n
    disp('INFINTE SOLUTIONS.');
    pause(600);
end

%creating augmented matrix 
Ab=[A,b];


% %changing leading r1 entry to 1
% Ab(1,:)=Ab(1,:)/Ab(1,1);
% %chaning entries below it to 0
% Ab(2,:)=Ab(2,:)-(Ab(2,1)*Ab(1,:));
% Ab(3,:)=Ab(3,:)-(Ab(3,1)*Ab(1,:));
% 
% %changing R2 entry to 1
% Ab(2,:)=Ab(2,:)/Ab(2,2);
% %chaning entries below it to 0
% Ab(3,:)=Ab(3,:)-(Ab(3,2)*Ab(2,:));
% 
% %changing R3 entry to 1
% Ab(3,:)=Ab(3,:)/Ab(3,3);

for col=1:n
    
    checkInfiniteSolution(Ab,col);
    checkNoSolution(Ab,col,n);
    
    %if leading entry is 0, and row is not the last row, try swap with below row to prevent /0
    if (Ab(col,col)==0) & (col~=m)
        C=Ab(col,:);
        Ab(col,:)=Ab(col+1,:);
        Ab(col+1,:)=C;
    end
    
    checkNoSolution(Ab,col,n);
    checkInfiniteSolution(Ab,col);
    
    %changing leading entry to 1 in that row
    %eg (-1/5)R2 --> R2
    Ab(col,:)=Ab(col,:)/Ab(col,col);
    
    %chaging rows underneath to 0
    for row=col+1:n
        %eg (-3)R1 + R3 --> R3
        Ab(row,:)=Ab(row,:)+(-Ab(row,col)*Ab(col,:));
    end
    
    checkInfiniteSolution(Ab,col);
end    

disp('Reduced Row Echelon Form is:');
disp(Ab);

%checking for no solutions after GE
for row=1:m
    %if row has all zeros and last digit is a non-zero
    NaN=isnan(Ab(row,:));
    if Ab(row,1:n)==0 | ismember(1,NaN)==1 & Ab(row,n+1)~=0
        disp('NO SOLUTIONS');
        pause(600);
    end    
end


%%Back Substitution, provided stopProgram is false

%initialising column vector of solutions
x=zeros(n,1);
for i=n:-1:1
  %x(i)=( Ab(i,end)-Ab(i,i+1:n)*x(i+1:n) )/Ab(i,i);
  x(i)=( Ab(i,end)- Ab(i,i+1:n)*x(i+1:n) )/Ab(i,i);
end

disp('Solutions to vector x are:');
disp(x);

function checkNoSolution(Ab,col,n)
     %checking for row that causes no solutions
    if (Ab(col,1:n)==0) & (Ab(col,n+1)~=0)
        disp("NO SOLUTIONS.");
        pause(600);
    end
end

function checkInfiniteSolution(Ab,col)
    %checking for row with all zeros, leading to m<n
    NaN=isnan(Ab); %checks for Not a Number elements, typically occur when x/0, efect of naive GE
    if Ab(col,:)==0 | ismember(1,NaN)==1
        disp('INFINTE SOLUTIONS.');
        pause(600);
    end
end

