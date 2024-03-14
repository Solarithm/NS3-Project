function DeleteNodesFromNeighbor(node, nodes)
    for i = 1 : length(nodes)
        for j = 1 : length(nodes(i).neighbor)
            if nodes(i).neighbor(j) == node
                nodes(i).neighbor(j) = [];
                break;
            end           
        end
        if nodes(i).child == node
            nodes(i).child = [];
        end
        
        if nodes(i).parent == node
            nodes(i).parent = [];
        end
    end
    
end