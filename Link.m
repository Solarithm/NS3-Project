function Link(nodes)
    for i = 1 : length(nodes)
        for j = 1 : length(nodes(i).neighbor)
            nodes(i).link(j) = nodes(i).E_initial * exp(-nodes(i).distance(j));
        end
    end
end