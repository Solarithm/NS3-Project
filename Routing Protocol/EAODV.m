classdef EAODV
    properties
        nodes % Array of Node objects
    end
    
    methods
        function network = EAODV(nodes)
            network.nodes = nodes;
        end
        
        function route_posible = route_discovery(network, source, destination)
            route_posible = 0;
            path = OptimizePath(network.nodes, source, destination);
            
            if (~any(path == destination)) 
                return;
            end
            % Path found
%             disp(['Done routing for node ', num2str(source), ' to node ', num2str(destination)]);
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
                    network.nodes(curr_node).E_initial = network.nodes(curr_node).E_initial - network.nodes(curr_node).E_tx(idx)*0.1; 
                    network.nodes(prev_node).E_initial = network.nodes(prev_node).E_initial - network.nodes(prev_node).E_rx*0.1;               
                    network.update_routing_table(prev_node, curr_node, destination);
                    
                    % Plot routing line
%                     h = line([network.nodes(curr_node).x, network.nodes(prev_node).x], [network.nodes(curr_node).y, network.nodes(prev_node).y]);
%                     h.LineStyle = '--';
%                     h.LineWidth = 2;
%                     h.Color = [0 1 1];
%                     arr_line(end+1) = h; % Store handle to the line object
%                     h.HandleVisibility = 'off';
%                     plot_energy_info(network.nodes);
%                     drawnow;
                    %end draw
                end        
            end
            % Draw back with a different color
%             for i = length(arr_line):-1:1
%                 set(arr_line(i), 'Color', [1 0 0]); % Set color using 'set' function
%                 drawnow;
%             end
%             if ~isempty(arr_line)
%                 delete(arr_line); % Delete the line object
%             end        
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

        function rp = route_maintenance(network, source, destination)
            rp = route_discovery(network, source, destination);
            %.......
        end
        
        function display_routing_table(network, node_id)
            if ~isempty(network.nodes(node_id).routingTable)
                network.nodes(node_id).display_routing_table();
            else
%                 fprintf(' NO INFORMATION OF NODE %d ROUTING TABLE', node_id);
            end
        end
    end
end