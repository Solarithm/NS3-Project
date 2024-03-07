function new_MST = Re_routing(node_critical, nodes)
    
%     low_energy = 1.8;
%     n = 15;
%  for i = 1:n
%      if(node(i).E_intial < low_energy)
%          node_critical = i;
%      end
%  end
     %broadcast for neighbor, remove Link for this node
     %Check neighbor node, remove link to node_critical
%     for i = 1:length(nodes(node_critical).neighbor)
%         if(i == 1)
%             start_node = nodes(node_critical).neighbor(i);
%         
%         elseif (i == length(nodes(node_critical).neighbor))
%             end_node = nodes(node_critical).neighbor(i);
%         end
%         neighbor_critical = nodes(nodes(node_critical).neighbor(i)).neighbor;
%         neighbor_critical = setdiff(neighbor_critical, node_critical);
%         nodes(nodes(node_critical).neighbor(i)).neighbor = neighbor_critical;
%     end
%  

    start_node = 1;
    end_node = 15;

 %Re - prim 
 new_MST = Prim(node_critical, start_node, end_node, nodes);    
end