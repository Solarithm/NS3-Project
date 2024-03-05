function linkEdge = GetLinkEdge(nodes)
    Link(nodes);
    
    link_matrix = zeros(length(nodes), length(nodes));
    for i = 1 : length(nodes)
        for j = 1 : length(nodes(i).neighbor)
            link_matrix(i, nodes(i).neighbor(j)) = nodes(i).link(j);
        end
    end
    linkEdge = [];
    linkCounter = 0;
    for i = 1 : length(nodes)
        for j = i + 1 : length(nodes)
            if(link_matrix(i, j) > 0)
                linkCounter = linkCounter + 1;
                linkEdge(linkCounter) = link_matrix(i, j);
            end
        end
    end
end