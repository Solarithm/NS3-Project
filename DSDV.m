classdef DSDV
    properties
        nodes % Array of Node objects
    end
    
    methods
        function network = DSDV(nodes)
            network.nodes = nodes;
        end
        
        function route_discovery(network, source, destination)
            path = findShortestPath(network.nodes, source, destination);
            % Path found
            disp(['Done routing for node ', num2str(source), ' to node ', num2str(destination)]);
            % Update routing tables along the path
            for i = 2:length(path)
                curr_node = path(i-1);
                prev_node = path(i);
                network.update_routing_table(prev_node, curr_node, destination);
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
        
        function init_DSDV_routing(network)
            fprintf('START DSDV ROUTING... \n');
            for i = 1 : length(network.nodes)
                for j = 1 : 1 : length(network.nodes)
                    if i ~= j
                        route_discovery(network, i, j);
                    end
                end
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
                fprintf('Routing table for Node %d:\n', node_id);
                disp(['       No information of routing table. Please do route discovery! ']);
            end
        end
    end
end