%Naive GE: Finding inverse of n*n matrix if it exists.
pause('on');

%Get size of matrix from user
n=input('Enter size of your n*n matrix: ');

%Getting matrix A
A=input('\nEnter Matrix A in square brackets. \nSeparate elements using a comma and rows using a semi-colon: ');
disp(A);

%creating identity matrix of size n
I=eye(n);
% for col=1:n
%     IdentityMatrix(col,col)=1;
% end    

if det(A)==0
    disp("INVERSE DOES NOT EXIST.");
    pause(600);
end

%creating augmented matrix 
Ab=[A,I];

for col=1:n

    %if leading entry is 0, and row is not the last row, try swap with below row to prevent /0
    if (Ab(col,col)==0) & (col~=n)
        C=Ab(col,:); %temporary matrix to use in swapping
        Ab(col,:)=Ab(col+1,:);
        Ab(col+1,:)=C;
    end
    
    %changing leading entry to 1 in that row
    %eg (-1/5)R2 --> R2
    Ab(col,:)=Ab(col,:)/Ab(col,col);
    
    %chaging rows underneath to 0
    for row=col+1:n
        %eg (-3)R1 + R3 --> R3
        Ab(row,:)=Ab(row,:)+(-Ab(row,col)*Ab(col,:));
    end
    
    %changing entries above it to zero, provided row isn't the first row
    if col~=1
        for row=col-1:-1:1
            Ab(row,:)=Ab(row,:)+(-Ab(row,col)*Ab(col,:));
            %making sure leading entry in those rows is still 1
            Ab(row,:)=Ab(row,:)/Ab(row,row);
        end
    end  
end  


%checking for NaN row or row of zeros
for row=1:n
    NaN=isnan(Ab(col,:));
    if ismember(1,NaN)==1
        disp('INVERSE DOES NOT EXIST.');
        pause(600);
    end
end    

disp('Reduced Row Echelon Form is:');
disp(Ab);

disp('inverse of matrix is: ');
disp(Ab(:,n+1:end));


