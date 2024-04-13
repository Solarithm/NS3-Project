function DeleteNodesFromNeighbor(nodes, node_id)
    for i = 1 : length(nodes)
        for j = 1 : length(nodes(i).neighbor)
            if nodes(i).neighbor(j) == node_id
                nodes(i).neighbor(j) = [];
                break;
            end           
        end
        if nodes(i).child == node_id
            nodes(i).child = [];
        end
        
        if nodes(i).parent == node_id
            nodes(i).parent = [];
        end
    end 
end