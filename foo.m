function return_val = foo(argA)
    
    argA=2*argA; %Modified by V
    for i=1:10
        argA+i
    end
    
    %Added by Jonathan
    plot(argA)
    
    return_val=argA;
end