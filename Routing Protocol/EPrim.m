classdef EPrim
    properties
        nodes % Array of Node objects
    end
    
    methods
        function network = EPrim(nodes)
            network.nodes = nodes;
        end
        
        function MST = PrimTree(network, destination) 
            UpdateLinkQuality(network.nodes);
            numNode = length(network.nodes);
            dead = [];
            visited = false(1, numNode); 
            MST = zeros(numNode - 1, 2);   
            edgeCount = 0;

            for i = 1 : length(dead)
                visited(dead(i)) = true;
            end
            visited(1) = true;  

            while(edgeCount < numNode - 1)
                min = 10000000;
                u = 0;
                v = 0;

                for i = 1:numNode
                    if(visited(i))
                        for j = 1:length(network.nodes(i).neighbor)
                            % Check if neighbor has enough initial energy
                            neighbor_index = network.nodes(i).neighbor(j);
                            if(~visited(neighbor_index) && network.nodes(neighbor_index).E_initial > network.nodes(neighbor_index).critical_level && network.nodes(i).distance(j) < min)
                                min = 1 / network.nodes(i).link(j);
                                u = i;
                                v = neighbor_index;
                            end
                        end
                    end
                end

                if v == 0
                    break; % No more nodes with enough energy to connect
                end

                visited(v) = true;
                edgeCount = edgeCount + 1;
                MST(edgeCount, :) = [u, v];
            end
            
            for i = 1 : edgeCount
                next_hop = MST(i, 1);
                curr_node = MST(i, 2);
                if ~isempty(network.nodes(curr_node).routingTable)
                    % Check if there is available destination
                    destination_found = any([network.nodes(curr_node).routingTable.Destination] == destination);
                    if ~destination_found
                        % if no, add
                        network.nodes(curr_node).add_route(destination, next_hop, 1);
                    end
                else
                    % if no routing, add
                    network.nodes(curr_node).add_route(destination, next_hop, 1);
                end
                
                h = line([network.nodes(next_hop).x, network.nodes(curr_node).x], [network.nodes(next_hop).y, network.nodes(curr_node).y]);    
                h.LineStyle = '-';
                h.LineWidth = 2;
                h.Color = [0 1 0];
                h.HandleVisibility = 'off';
            end         
        end     
    end
end
