function path = Routing(nodes, source, destination)
    [shortest_distance, path] = BroadCasting(nodes, source, destination);

    if isinf(shortest_distance)
        fprintf('FINDING NO SHORTEST PATH FROM %d TO %d \n', source, destination);
    end
end