function path = findShortestPath(nodes, start, finish)
    [shortest_distance, path] = astar(nodes, start, finish);

    if isinf(shortest_distance)
        fprintf('FINDING NO SHORTEST PATH FROM %d TO %d', start, finish);
    end
end