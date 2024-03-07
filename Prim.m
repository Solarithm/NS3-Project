function MST = Prim (startNode, endNode, nodes)
    numNode = endNode - startNode + 1;
    visited = true(1,15);
    for i = startNode : endNode  
        visited(1, i) = false;
    end
    MST = zeros(numNode - 1,2);   
    visited(startNode) = true; 
    edgeCount = 0;
    
    %Vong lap quet den khi tat cac diem duoc quet ==> bang true
    while(edgeCount < numNode - 1)
        max = 0;
        u = 0;
        v = 0;
        for i = startNode:endNode
            if(visited(i))
                for j = 1:length(nodes(i).neighbor)
                    if(~visited(nodes(i).neighbor(j)) && nodes(i).link(j) > max)
                        max = nodes(i).link(j);
                        u = i;
                        v = nodes(i).neighbor(j);
                    end
                end
            end
        end
        visited(v) = true ;
        edgeCount = edgeCount + 1;
        MST(edgeCount, :) = [u, v];
    end
    
    
end