classdef AODV
    properties
        nodes % Array of Node objects
    end
    
    methods
        function network = AODV(nodes)
            network.nodes = nodes;
        end
        
        function route_discovery(network, source, destination)
            path = findShortestPath(network.nodes, source, destination);
            % Path found
            disp(['Done routing for node ', num2str(source), ' to node ', num2str(destination)]);
            % Update routing tables along the path
            arr_line = [];
            for i = 2:length(path)
                curr_node = path(i-1);
                prev_node = path(i);
                network.update_routing_table(prev_node, curr_node, destination);
                % Plot routing line
                h = line([network.nodes(curr_node).x, network.nodes(prev_node).x], [network.nodes(curr_node).y, network.nodes(prev_node).y]);
                h.LineStyle = '-';
                h.LineWidth = 2;
                h.Color = [0 1 1];
                arr_line(end+1) = h; % Store handle to the line object
                pause(0.2);
                drawnow;
            end
            % Draw back with a different color
            for i = length(arr_line):-1:1
                set(arr_line(i), 'Color', [1 0 0]); % Set color using 'set' function
                pause(0.2);
                drawnow;
            end
            % Clear the previous lines
            for i = 1:numel(arr_line)
                delete(arr_line(i)); % Delete the line object
            end        
        end
        
        function update_routing_table(network, prev_node, curr_node, destination)
            next_hop = prev_node;
            cost = 1; % Assuming uniform cost for simplicity
            
            if ~isempty(network.nodes(curr_node).routingTable)
                % Check if there is available destination
                destination_found = any([network.nodes(curr_node).routingTable.Destination] == destination);
                if ~destination_found
                    % if no, add
                    network.nodes(curr_node).add_route(destination, next_hop, cost);
                end
            else
                % if no routing, add
                network.nodes(curr_node).add_route(destination, next_hop, cost);
            end
        end

        function route_maintenance(network, node)
            disp(['Performing route maintenance at Node ', num2str(node)]);
            %.......
        end
        
        function display_routing_table(network, node_id)
            if ~isempty(network.nodes(node_id).routingTable)
                network.nodes(node_id).display_routing_table();
            else
                fprintf(' NO INFORMATION OF NODE %d ROUTING TABLE', node_id);
            end
        end
    end
end