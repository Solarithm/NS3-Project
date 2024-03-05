function [s, t] = Neighbor(nodes)
    adj_matrix = Adj_Matrix(nodes);
    for i = 1 : length(nodes)
        neighborCount = 0;
        for j = i + 1 : length(nodes)
            if(adj_matrix(i, j) == 1)
                neighborCount = neighborCount + 1;
                nodes(i).neighbor(neighborCount) = j;
            end
        end
    end
    
    s = [];
    t = [];
    count = 2;
    for i = 1 : length(nodes)
        for j = count : length(nodes)
            if(adj_matrix(i,j) == 1)
               s = [s, i];
               t = [t, j];
            end
        end
        count = count + 1;
    end

end