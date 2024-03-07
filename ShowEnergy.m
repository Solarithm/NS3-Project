function ShowEnergy(x, y, nodes)

    n = 15; 
    x1 = zeros(1,n);
    y1 = zeros(1,n);    
    str = {};
    
    for i = 1:n
        x1(i) = x(i) + 0.7;
        y1(i) = y(i) + 0.7;
        str{i} = num2str(nodes(i).E_initial);
          text(x1(i), y1(i), str{i});
    end
    
end