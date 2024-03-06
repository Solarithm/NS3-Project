function new_MST = Re_routing(node_critical, node)
    
%     low_energy = 1.8;
%     n = 15;
%  for i = 1:n
%      if(node(i).E_intial < low_energy)
%          node_critical = i;
%      end
%  end
     %broadcast for neighbor, remove Link for this node
     %Check neighbor node, remove link to node_critical
    for i = 1:length(node(node_critical).neighbor)
        if(i == 1)
            start_node = node(node_critical).neighbor(i);
        
        elseif (i == length(node(node_critical).neighbor))
            end_node = node(node_critical).neighbor(i);
        end
        neighbor_critical = node(node(node_critical).neighbor(i)).neighbor;
        neighbor_critical = setdiff(neighbor_critical, node_critical);
        node(node(node_critical).neighbor(i)).neighbor = neighbor_critical;
    end
 
 %Re - prim 
 new_MST = Re_Prim(node_critical, start_node, end_node, node);
    
end