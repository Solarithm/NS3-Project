function [px, py] = Packet_transmission(sensor_node, nodes)
    px = [];
    py = [];
    parent_1 = nodes(sensor_node).parent;
    px(1) = nodes(sensor_node).x;
    py(1) = nodes(sensor_node).y;
    iter = 2;
    while(parent_1 ~= 0)
        
        nodes(sensor_node).change_energy_Tx();

        for i = 1:length(nodes(sensor_node).neighbor)
            %Check energy Tx
            if(parent_1 == nodes(sensor_node).neighbor(i))
                nodes(sensor_node).E_initial = nodes(sensor_node).E_initial - nodes(sensor_node).E_tx(i); 
                
            end
        end
        %Check_energy_parent Tx and Rx
        %Check - Rx
        nodes(parent_1).change_energy_Rx();
        nodes(parent_1).E_initial = nodes(parent_1).E_initial - nodes(parent_1).E_rx;
        if(nodes(parent_1).parent ~= 0)
              px(iter) = nodes(parent_1).x;
              py(iter) = nodes(parent_1).y;
              sensor_node = parent_1;            
              iter = iter + 1;
              
        else
              px(iter) = nodes(parent_1).x;
              py(iter) = nodes(parent_1).y;
              iter = iter + 1;
              break;
        end
        parent_1 = nodes(parent_1).parent;
    end    
end