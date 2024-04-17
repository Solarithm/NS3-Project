classdef Prim
    properties
        nodes % Array of Node objects
    end
    
    methods
        function network = Prim(nodes)
            network.nodes = nodes;
        end
        function PrimTree(network, destination) 
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
                            if(~visited(network.nodes(i).neighbor(j)) && network.nodes(i).distance(j) < min)
                                min = network.nodes(i).distance(j);
                                u = i;
                                v = network.nodes(i).neighbor(j);
                            end
                        end
                    end
                end
                visited(v) = true ;
                edgeCount = edgeCount + 1;
                MST(edgeCount, :) = [u, v];
            end

            for i = 1 : (numNode - 1)
                next_node = MST(i, 1);
                cur_node = MST(i, 2);
                network.nodes(cur_node).add_route(destination, next_node, 1);
                h = line([network.nodes(next_node).x, network.nodes(cur_node).x], [network.nodes(next_node).y, network.nodes(cur_node).y]);    
                h.LineStyle = '-';
                h.LineWidth = 2;
                h.Color = [0 1 0];
                h.HandleVisibility = 'off';
            end   
        end

    end
end
