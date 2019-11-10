%Using Naive GE on m*n matrix A to find if its column vectors are LI or DI
pause('on');
counter=0;

%Get size of matrix from user
m=input('Enter m for your m*n matrix: ');
n=input('Enter n of your m*n matrix: ');

%Getting matrix A made up of the vectors
A=input('\nEnter Matrix of column vectors A in square brackets. \nSeparate elements using a comma and rows using a semi-colon: ');
disp(A);

%if rows<columns then LD
if m<n
    disp('LINEARLY DEPENDENT.');
    pause(600);
end

%checking if matrix is square and invertible
if m==n & det(A)~=0
    disp('LINEARLY INDEPENDENT.');
    pause(600);
%if sqaure and determinant is 0
elseif m==n & det(A)==0
    disp('LINEARLY DEPENDENT')
    pause(600);
end


for col=1:n
    
    %if leading entry is 0, and row is not the last row, try swap with below row to prevent /0
    if (A(col,col)==0) & (col~=m)
        C=A(col,:);
        A(col,:)=A(col+1,:);
        A(col+1,:)=C;
    end
    
    %changing leading entry to 1 in that row
    %eg (-1/5)R2 --> R2
    A(col,:)=A(col,:)/A(col,col);
    
    %chaging rows underneath to 0
    for row=col+1:n
        %eg (-3)R1 + R3 --> R3
        A(row,:)=A(row,:)+(-A(row,col)*A(col,:));
    end    
    
    checkRowOfZeros(A,col);
end  

disp('Reduced Row Echelon Form is:');
disp(A);
 
% %checking number of non-zero rows
% for row=1:m
%     if A(row,:)~=0 | A(row,:)~isNaN(A(row,:))
%         counter=counter+1;
%     end    
% end    

%if number of non-zero rows is less than n then LD
if (m-counter)<n
   disp('LINEARLY DEPENDENT');
else
    disp('LINEARLY INDEPENDENT');
end


function checkRowOfZeros(A,col)
    %checking for row with all zeros, leading to m<n
    NaN=isnan(A(col,:));
    if (A(col,:)==0) | ismember(1,NaN)==1  | isinf(A(col,:))
        counter=counter+1
        pause(600);
    end
end

