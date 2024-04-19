function PacketTransmission(source, destination, network) 
    if (network.nodes(source).E_initial < 1)
        fprintf("Node %d turn on sleep mode\n", source);
        return;
    end
    if ~any([network.nodes(source).routingTable.Destination] == destination)
        route_discovery(network, source, destination);
    end
    px = [];
    py = []; 
    iter = 1;
    px(iter) = network.nodes(source).x;
    py(iter) = network.nodes(source).y;
    iter = 2;
    arr_line = [];
    fprintf("Transmitting data from node %d to node %d\n", source, destination);
    while(source ~= destination)   
        % Get next hop from routing table
        idex_arr = [network.nodes(source).routingTable.Destination];
        des_idx = find(idex_arr == destination);
        if (isempty(des_idx))
            return;
        end
        next_hop = network.nodes(source).routingTable(des_idx).NextHop;
        change_energy_Tx(network.nodes(source));
        if(network.nodes(next_hop).E_initial > network.nodes(next_hop).critical_level) % transmission to node's energy > critcal level
            idx = find(network.nodes(source).neighbor == next_hop);
            network.nodes(source).E_initial = network.nodes(source).E_initial - network.nodes(source).E_tx(idx);                
            change_energy_Rx(network.nodes(next_hop));
            network.nodes(next_hop).E_initial = network.nodes(next_hop).E_initial - network.nodes(next_hop).E_rx;
            px(iter) = network.nodes(next_hop).x;
            py(iter) = network.nodes(next_hop).y;
            %draw transmission line
%             h = line([px(iter - 1), px(iter)], [py(iter - 1), py(iter)]);
%             h.LineStyle = '-';
%             h.LineWidth = 2;
%             h.Color = [0 0 1];
%             arr_line(end+1) = h; % Store handle to the line object
%             h.HandleVisibility = 'off';
%             plot_energy_info(network.nodes);
%             pause(0.05); 
%             drawnow;
            %end draw
            
            iter = iter + 1;
            source = next_hop;  
        else
            % Find rows where the Destination field matches the given value
            rowsToDelete = [network.nodes(source).routingTable.Destination] == destination;
            % Delete rows from the struct array
            network.nodes(source).routingTable(rowsToDelete) = [];
            route_maintenance(network, source, destination);
            continue;
        end    
    end   
    plot_energy_info(network.nodes);
    % Clear the previous lines
    for i = 1:numel(arr_line)
        delete(arr_line(i)); % Delete the line object
    end
    
end
