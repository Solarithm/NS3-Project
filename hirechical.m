function hirechical(node, n)
    node(1).hirechical = 1;
    for i = 2:n
       node(i).hirechical = round((node(i).x - 0)/5) + 1;      
    end
end