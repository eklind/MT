function return_val = foo(argA)
    




    argA=3*argA; %Modified by V
    for i=1:10
        argA+i
    end
    
    % added this comment
    
    %Added by Jonathan
    plot(argA)
    
    return_val=argA;
end