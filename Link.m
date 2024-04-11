function Link(nodes)
    for iterNode = 1 : length(nodes)
        for iterNeighbor = 1 : length(nodes(iterNode).neighbor)
            nodes(iterNode).link(iterNeighbor) = nodes(iterNode).distance(iterNeighbor));
            if(nodes(iterNode).link(length(iterNeighbor)) == 0)
                DisconnectedNode(nodes(iterNode));
            end
        end
    end
end