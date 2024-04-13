function [trigger] = PacketTransmission(sensor_node, destination, nodes)
    px = [];
    py = []; 
    iter = 1;
    px(iter) = nodes(sensor_node).x;
    py(iter) = nodes(sensor_node).y;
    iter = 2;
    shortest_path_nodes = [];
    trigger = 0;
    while(sensor_node > 1)
        % Get next hop from routing table
        idex_arr = [nodes(sensor_node).routingTable.Destination];
        idx = find(idex_arr == destination);
        next_hop = nodes(sensor_node).routingTable(idx).NextHop;
        nodes(sensor_node).change_energy_Tx();
        if(nodes(next_hop).E_initial > 0)
            for i = 1:length(nodes(sensor_node).neighbor)
                % Check energy Tx
                if(next_hop == nodes(sensor_node).neighbor(i))
                    nodes(sensor_node).E_initial = nodes(sensor_node).E_initial - nodes(sensor_node).E_tx(i);                
                end
            end
            nodes(next_hop).change_energy_Rx();
            nodes(next_hop).E_initial = nodes(next_hop).E_initial - nodes(next_hop).E_rx;
            px(iter) = nodes(next_hop).x;
            py(iter) = nodes(next_hop).y;                      
            iter = iter + 1;
            sensor_node = next_hop;  
        else
            % Remove the dead node from neighbors of other nodes
            for i = 1 : length(nodes(sensor_node).neighbor)
                if (nodes(sensor_node).neighbor(i) == next_hop)
                    nodes(sensor_node).neighbor(i) = [];
                    break;
                end
            end
            % Find the shortest path to any node with lower ID
            shortest_path_nodes = findShortestPath(nodes, sensor_node, 1);
            for i = 2 : length(shortest_path_nodes)
                px(iter) = nodes(shortest_path_nodes(i)).x;
                py(iter) = nodes(shortest_path_nodes(i)).y;
                iter = iter + 1;
            end
            trigger = 1;
            break;
        end    
    end 
    
    % Compare the path found with the path on MST
    % If different return 0, same return 1

    % Draw transmission line
    for i = 1 : length(px) - 1
        h = line([px(i), px(i+1)], [py(i), py(i+1)]);
        h.LineStyle = '-';
        h.LineWidth = 2;
        h.Color = [0 0 1];
        pause(0.5);        
        drawnow;
    end  
end
