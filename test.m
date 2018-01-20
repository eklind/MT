

A=rand(100);
A=reshape(A,1,[]);


for i=1:length(A)
    if A(i)>A(i+1)
        temp[i]=A(i)
        A(i+1) 
    end
end