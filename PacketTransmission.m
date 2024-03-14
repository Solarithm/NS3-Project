function [trigger] = PacketTransmission(sensor_node, nodes, MST)
    px = [];
    py = []; 
    iter = 1;
    px(iter) = nodes(sensor_node).x;
    py(iter) = nodes(sensor_node).y;
    iter = 2;
    shortest_path_nodes = [];
    trigger = 0;
    while(sensor_node > 1)
        parent_1 = nodes(sensor_node).parent;
        nodes(sensor_node).change_energy_Tx();
        if(nodes(parent_1).E_initial > 0)
            for i = 1:length(nodes(sensor_node).neighbor)
            %Check energy Tx
                if(parent_1 == nodes(sensor_node).neighbor(i))
                    nodes(sensor_node).E_initial = nodes(sensor_node).E_initial - nodes(sensor_node).E_tx(i);                
                end
            end
            nodes(parent_1).change_energy_Rx();
            nodes(parent_1).E_initial = nodes(parent_1).E_initial - nodes(parent_1).E_rx;
            px(iter) = nodes(parent_1).x;
            py(iter) = nodes(parent_1).y;                      
            iter = iter + 1;
            sensor_node = parent_1;  
        else
            % xóa thằng chết ra khỏi neighbor của các thằng khác
            for i = 1 : length(nodes(sensor_node).neighbor)
                if (nodes(sensor_node).neighbor(i) == parent_1)
                    nodes(sensor_node).neighbor(i) = [];
                    break;
                end
            end
            % tìm đường gần nhât đến nút bất kì có id thấp hơn 
            %
            shortest_path_nodes = findShortestPath(nodes, sensor_node, 1);
            for i = 2 : length(shortest_path_nodes)
                px(iter) = nodes(shortest_path_nodes(i)).x;
                py(iter) = nodes(shortest_path_nodes(i)).y;
                iter = iter + 1;
            end
            %
            trigger = 1;
            break;
        end    
    end 
    
    % So sánh path đã tìm được với path trên MST
    % Nếu khác nhau trả về 0, giống trả về 1

    
    %% Draw transmission line
    for i = 1 : length(px) - 1
        h = line([px(i), px(i+1)], [py(i), py(i+1)]);
        h.LineStyle = '-';
        h.LineWidth = 2;
        h.Color = [0 0 1];
        pause(0.5);        
        drawnow;
    end  
end