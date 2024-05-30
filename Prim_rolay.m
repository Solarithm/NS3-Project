function MST = Prim_rolay (node_critical, start_point, end_point,node)

    number_Node = 16;
    n = end_point - start_point + 1 - length(node_critical);
    
    visted = true(1,number_Node);
    for i = start_point : end_point
        if(ismember(i,node_critical))
            continue;
        end
        visted(1,i) = false;
    end
    MST = zeros(n-1,2);

    visted(start_point) = true; 
    edge_count = 0;

%Vong lap quet den khi tat cac diem duoc quet ==> bang true
while(edge_count < n-1)
%      min = inf;
     max = 0;
     u = 0;
     v = 0;
    for i = start_point:end_point
          if(ismember(i,node_critical))
            continue;
          end
          
          if(visted(i))
            if(i == start_point)  
                for j = 1:length(node(i).neighbor)
                    if(~visted(node(i).neighbor(j)))
                  u = i;
                  v = node(i).neighbor(j);
                  visted(v) = true ;
                  edge_count = edge_count + 1;
                  MST(edge_count, :) = [u, v];
                    end
                end
            elseif(i ~= start_point)
                for j = 1:length(node(i).neighbor)
                    if(~visted(node(i).neighbor(j)) && node(i).link(j) > max)
                        max = node(i).link(j);
                        u = i;
                        v = node(i).neighbor(j);
                    end
                end
            end
          end
    end
                visted(v) = true ;
                edge_count = edge_count + 1;
                MST(edge_count, :) = [u, v];
end
end