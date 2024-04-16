function path = findShortestPath(nodes, start, finish)
    [shortest_distance, path] = BroadCasting(nodes, start, finish);

    if isinf(shortest_distance)
        fprintf('FINDING NO SHORTEST PATH FROM %d TO %d \n', start, finish);
    end
end