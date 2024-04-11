classdef DSDV
    properties
        nodes % Array of Node objects
    end
    
    methods
        function network = DSDV(nodes)
            network.nodes = nodes;
        end
        
        function route_discovery(network, source, destination)
            visited = false(1, length(network.nodes));
            queue = source;
            path = cell(1, length(network.nodes));
            while ~isempty(queue)
                node = queue(1);
                queue(1) = [];
                visited(node) = true;
                if node == destination
                    % Path found
                    disp(['Done routing for node ', num2str(source), ' to node ', num2str(destination)]);
                    % Update routing tables along the path
                    next_hop = path{destination}(1);
                    network.nodes(source).add_route(destination, next_hop, 1);
                    for i = 2:length(path{destination})
                        curr_node = path{destination}(i-1);
                        prev_node = path{destination}(i);
                        network.update_routing_table(prev_node, curr_node, destination);
                    end
                    return;
                end
                neighbors = network.nodes(node).neighbor;
                for i = 1:length(neighbors)
                    neighbor = neighbors(i);
                    if ~visited(neighbor)
                        queue = [queue, neighbor];
                        path{neighbor} = [path{node}, neighbor];
                    end
                end
            end
            disp(['Route from Node ', num2str(source), ' to Node ', num2str(destination), ' not found']);
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
                fprintf('Routing table for Node %d:\n', node_id);
                disp(['       No information of routing table. Please do route discovery! ']);
            end
        end
    end
end