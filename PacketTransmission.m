function PacketTransmission(sendNode, nodes)
    parent_1 = nodes(sendNode).parent;
    while(parent_1 ~= 0)
        nodes(sendNode).change_energy_Tx();
        for i = 1:length(nodes(sendNode).neighbor)
            %Check energy Tx
            if(parent_1 == nodes(sendNode).neighbor(i))
                nodes(sendNode).E_initial = nodes(sendNode).E_initial - nodes(sendNode).E_tx(i); 
            end
        end
        %Check_energy_parent Tx and Rx
        %Check - Rx
         nodes(parent_1).change_energy_Rx();
         nodes(parent_1).E_initial = nodes(parent_1).E_initial - nodes(parent_1).E_rx;
         if(parent_1 == 0)
             break;
         else
              sendNode = parent_1;
         end
         parent_1 = nodes(parent_1).parent;
    end  
end