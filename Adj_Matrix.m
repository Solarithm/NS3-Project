function adj_matrix = Adj_Matrix(nodes)
    adj_matrix = zeros(length(nodes), length(nodes));    
    for i = 1 : length(nodes)
        for j = 1 : length(nodes)
            distance = sqrt((nodes(i).x - nodes(j).x)^2 ...
                          + (nodes(i).y - nodes(j).y)^2);
            if (i == j)
                adj_matrix(i,j) = 0;
            elseif (i~=j && distance < 11) 
                adj_matrix(i,j) = 1;
            else
                adj_matrix(i,j) = inf;
            end       
        end
    end
end