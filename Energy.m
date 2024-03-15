function Energy(x,y,node)

    n = 16; 
    x1 = zeros(1,n);
    y1 = zeros(1,n);
    
    str = {};
    
    for i = 1:n
        x1(i) = x(i) + 0.3;
        y1(i) = y(i) + 0.3  ;
        str{i} = num2str(node(i).E_intial);
          text(x1(i), y1(i), str{i});
    end
    
end
