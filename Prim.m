function MST = Prim (start_point, end_point,node)

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
     min = inf;
     u = 0;
     v = 0;
    for i = start_point:end_point
        if(visted(i))
        for j = 1:length(node(i).neighbor)
%             if(node(i).neighbor(j) > start_point && node(i).neighbor(j) < end_point + 1)
                 if(~visted(node(i).neighbor(j)) && node(i).d(j) < min)
                        min = node(i).d(j);
                        u = i;
                        v = node(i).neighbor(j);
                 end
%             end
         end
        end
    end
                visted(v) = true ;
                edge_count = edge_count + 1;
                MST(edge_count, :) = [u, v];
end
end