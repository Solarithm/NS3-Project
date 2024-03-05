function Distance(nodes)
    for i = 1 : length(nodes)
        for j = 1 : length(nodes(i).neighbor)
            nodes(i).distance(j) = sqrt((nodes(i).x - nodes(nodes(i).neighbor(j)).x)^2 ...
                                      + (nodes(i).y - nodes(nodes(i).neighbor(j)).y)^2);
        end
    end
end

