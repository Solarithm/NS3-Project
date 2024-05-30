function Energy(x,y,node,n)
    x1 = zeros(1,n);
    y1 = zeros(1,n);
    
    str = {};
    
    for i = 1:n
        x1(i) = x(i) + 0.5;
        y1(i) = y(i) + 0.6  ;
        str{i} = num2str(node(i).E_intial);
          text(x1(i), y1(i), str{i});
    end
    
end
