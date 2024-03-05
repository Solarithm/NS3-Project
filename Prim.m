function MST = Prim (start_point, end_point, nodes)
    n = end_point - start_point + 1;
    visted = true(1,15);
    for i = start_point : end_point
        visted(1,i) = false;
    end
    MST = zeros(n-1,2);   
    visted(start_point) = true; 
    edge_count = 0;
    
    %Vong lap quet den khi tat cac diem duoc quet ==> bang true
    while(edge_count < n-1)
        max = 0;
        u = 0;
        v = 0;
        for i = start_point:end_point
            if(visted(i))
                for j = 1:length(nodes(i).neighbor)
                    if(~visted(nodes(i).neighbor(j)) && nodes(i).link(j) > max)
                        max = nodes(i).link(j);
                        u = i;
                        v = nodes(i).neighbor(j);
                    end
                end
            end
        end
        visted(v) = true ;
        edge_count = edge_count + 1;
        MST(edge_count, :) = [u, v];
    end
end