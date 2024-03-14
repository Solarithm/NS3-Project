function path = findShortestPath(nodes, start, finish)
    [shortest_distance, path] = astar(nodes, start, finish);

    if isinf(shortest_distance)
        % Xử lý trường hợp không tìm thấy đường đi ngắn nhất
        disp('Không tìm thấy đường đi ngắn nhất.');
    end
end