function Packet_transmission(sensor_node,node)
parent_1 = node(sensor_node).parent;
while(parent_1 ~= 0)
    node(sensor_node).change_energy_Tx();
for i = 1:length(node(sensor_node).neighbor)
    %Check energy Tx
    if(parent_1 == node(sensor_node).neighbor(i))
        node(sensor_node).E_intial = node(sensor_node).E_intial - node(sensor_node).E_tx(i); 
    end
end
    %Check_energy_parent Tx and Rx
    %Check - Rx
     node(parent_1).change_energy_Rx();
     node(parent_1).E_intial = node(parent_1).E_intial - node(parent_1).E_rx;
     if(parent_1 == 0)
         break;
     else
          sensor_node = parent_1;
     end
     parent_1 = node(parent_1).parent;
end  
end