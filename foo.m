function return_val = foo(argA)
    
<<<<<<< HEAD

=======
    argA=3*argA; %Modified by V
>>>>>>> 6cb1df5a77f59c4a75c4a48745ed08d0e1b40fae
    for i=1:10
        argA+i
    end
    
    %Added by Jonathan
    plot(argA)
    
    return_val=argA;
end