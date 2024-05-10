function trigger = PacketTransmission(source, destination, network)
    trigger = 0;
    check_status(network.nodes);
    if (network.nodes(source).E_initial < network.nodes(source).critical_level)
        trigger = 1;
        return;
    end
    
    if ~any([network.nodes(source).routingTable.Destination] == destination)
        route_discovery(network, source, destination);
    end
    
    px = network.nodes(source).x;
    py = network.nodes(source).y;
    
    arr_line = [];
    
    while (source ~= destination && network.nodes(source).status == 0)
        idex_arr = [network.nodes(source).routingTable.Destination];
        des_idx = find(idex_arr == destination);
        
        if (isempty(des_idx))
            network.nodes(source).status = 1;
            delete(arr_line);
            break;
        end
        
        next_hop = network.nodes(source).routingTable(des_idx).NextHop;
        
        if network.nodes(next_hop).status == 1
            delete(arr_line);
            break;
        end
        
        change_energy_Tx(network.nodes(source));
        
        if(network.nodes(next_hop).E_initial > network.nodes(next_hop).critical_level)
            idx = find(network.nodes(source).neighbor == next_hop);
            network.nodes(source).E_initial = network.nodes(source).E_initial - network.nodes(source).E_tx(idx);                
            change_energy_Rx(network.nodes(next_hop));
            network.nodes(next_hop).E_initial = network.nodes(next_hop).E_initial - network.nodes(next_hop).E_rx;
            
            px(end+1) = network.nodes(next_hop).x;
            py(end+1) = network.nodes(next_hop).y;
            
            h = line([px(end-1), px(end)], [py(end-1), py(end)]);
            h.LineStyle = '--';
            h.LineWidth = 2;
            h.Color = [0 0 1];
            arr_line(end+1) = h;
            h.HandleVisibility = 'off';
            plot_energy_info(network.nodes);
            drawnow;
            
            source = next_hop;  
        else
            network.nodes(source).routingTable(des_idx) = [];
            route_maintenance(network, source, destination);
        end 
    end   
    
    delete(arr_line);
end
