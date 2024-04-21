classdef DSDV
    properties
        nodes % Array of Node objects
    end
    
    methods
        function network = DSDV(nodes)
            network.nodes = nodes;
        end
        % Do at start
        function route_discovery(network, source, destination)
            path = Routing(network.nodes, source, destination);
            if (~any(path == destination))
                return;
            end
            % Path found
            disp(['Done routing for node ', num2str(source), ' to node ', num2str(destination)]);
            % Update routing tables along the path
            arr_line = [];
            for i = 2:length(path)
                curr_node = path(i-1);
                prev_node = path(i);
                destination_found = any([network.nodes(curr_node).routingTable.Destination] == destination);
                if ~destination_found              
                    network.update_routing_table(prev_node, curr_node, destination);                   
                end        
            end
            % Draw back with a different color
            for i = length(arr_line):-1:1
                set(arr_line(i), 'Color', [1 0 0]); % Set color using 'set' function
                pause(0.05);
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
        
        function route_maintenance(network, source, destination)
            disp(['Performing route maintenance at Node ', num2str(source)]);
            path = Routing(network.nodes, source, destination);
            if (~any(path == destination))
                return;
            end
            % Path found
            disp(['Done maintainance for node ', num2str(source), ' to node ', num2str(destination)]);
            % Update routing tables along the path
            arr_line = [];
            for i = 2:length(path)
                curr_node = path(i-1);
                prev_node = path(i);
                destination_found = any([network.nodes(curr_node).routingTable.Destination] == destination);
                if ~destination_found
                    energy_RREQ(network.nodes(curr_node));     
                    energy_RREP(network.nodes(prev_node));
                    idx = find(network.nodes(curr_node).neighbor == prev_node);
                    network.nodes(curr_node).E_initial = network.nodes(curr_node).E_initial - network.nodes(curr_node).E_tx(idx); 
                    network.nodes(prev_node).E_initial = network.nodes(prev_node).E_initial - network.nodes(prev_node).E_rx;               
                    network.update_routing_table(prev_node, curr_node, destination);                   
                    % Plot routing line
%                     h = line([network.nodes(curr_node).x, network.nodes(prev_node).x], [network.nodes(curr_node).y, network.nodes(prev_node).y]);
%                     h.LineStyle = '-';
%                     h.LineWidth = 2;
%                     h.Color = [0 1 1];
%                     arr_line(end+1) = h; % Store handle to the line object
%                     h.HandleVisibility = 'off';
%                     plot_energy_info(network.nodes);
%                     pause(0.01);
%                     drawnow;
                end        
            end
            % Draw back with a different color
            for i = length(arr_line):-1:1
                set(arr_line(i), 'Color', [1 0 0]); % Set color using 'set' function
                pause(0.05);
                drawnow;
            end
            % Clear the previous lines
            for i = 1:numel(arr_line)
                delete(arr_line(i)); % Delete the line object
            end
            %.......
        end
        
        function display_routing_table(network, node_id)
            if ~isempty(network.nodes(node_id).routingTable)
                network.nodes(node_id).display_routing_table();
            else
                fprintf('Routing table for Node %d:\n', node_id);
                disp('No information of routing table. Please do route discovery! ');
            end
        end
    end
end