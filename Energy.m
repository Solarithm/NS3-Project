<<<<<<< HEAD
function Energy(x,y,node,n)
=======
function Energy(x,y,node)

    n = 16; 
>>>>>>> b6eb5148cb43f431b9ebacffd068f6ee182fa942
    x1 = zeros(1,n);
    y1 = zeros(1,n);
    
    str = {};
    
    for i = 1:n
<<<<<<< HEAD
        x1(i) = x(i) + 0.5;
        y1(i) = y(i) + 0.6  ;
=======
        x1(i) = x(i) + 0.3;
        y1(i) = y(i) + 0.3  ;
>>>>>>> b6eb5148cb43f431b9ebacffd068f6ee182fa942
        str{i} = num2str(node(i).E_intial);
          text(x1(i), y1(i), str{i});
    end
    
end
