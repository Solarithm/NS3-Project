function Link(nodes)
    for i = 1 : length(nodes)
        for j = 1 : length(nodes(i).neighbor)
            if (nodes(i).E_initial > 0)
                nodes(i).link(j) = nodes(i).E_initial * exp(-nodes(i).distance(j));
            else
                DisconnectedNode(nodes, nodes(i));
            end
            
        end
    end
end