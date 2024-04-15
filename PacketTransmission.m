function [trigger] = PacketTransmission(sensor_node, destination, network)    
    if ~any([network.nodes(sensor_node).routingTable.Destination] == destination)
        route_discovery(network, sensor_node, destination);
    end
    px = [];
    py = []; 
    iter = 1;
    px(iter) = network.nodes(sensor_node).x;
    py(iter) = network.nodes(sensor_node).y;
    iter = 2;
    shortest_path_nodes = [];
    trigger = 0;
    while(sensor_node > 1)
        % Get next hop from routing table
        idex_arr = [network.nodes(sensor_node).routingTable.Destination];
        idx = find(idex_arr == destination);
        next_hop = network.nodes(sensor_node).routingTable(idx).NextHop;
        network.nodes(sensor_node).change_energy_Tx();
        if(network.nodes(next_hop).E_initial > 0)
            for i = 1:length(network.nodes(sensor_node).neighbor)
                % Check energy Tx
                if(next_hop == network.nodes(sensor_node).neighbor(i))
                    network.nodes(sensor_node).E_initial = network.nodes(sensor_node).E_initial - network.nodes(sensor_node).E_tx(i);                
                end
            end
            network.nodes(next_hop).change_energy_Rx();
            network.nodes(next_hop).E_initial = network.nodes(next_hop).E_initial - network.nodes(next_hop).E_rx;
            px(iter) = network.nodes(next_hop).x;
            py(iter) = network.nodes(next_hop).y;                      
            iter = iter + 1;
            sensor_node = next_hop;  
        else
            % Remove the dead node from neighbors of other nodes
            for i = 1 : length(network.nodes(sensor_node).neighbor)
                if (network.nodes(sensor_node).neighbor(i) == next_hop)
                    network.nodes(sensor_node).neighbor(i) = [];
                    break;
                end
            end
            % Find the shortest path to any node with lower ID
            shortest_path_nodes = findShortestPath(network.nodes, sensor_node, 1);
            for i = 2 : length(shortest_path_nodes)
                px(iter) = network.nodes(shortest_path_nodes(i)).x;
                py(iter) = network.nodes(shortest_path_nodes(i)).y;
                iter = iter + 1;
            end
            trigger = 1;
            break;
        end    
    end 
    

    % Draw transmission line
    arr_line = [];
    for i = 1 : length(px) - 1
        h = line([px(i), px(i+1)], [py(i), py(i+1)]);
        h.LineStyle = '-';
        h.LineWidth = 2;
        h.Color = [0 0 1];
        arr_line(end+1) = h; % Store handle to the line object
        pause(0.5);        
        drawnow;
    end
    % Clear the previous lines
    for i = 1:numel(arr_line)
        delete(arr_line(i)); % Delete the line object
    end
end
