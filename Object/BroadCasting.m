function [shortest_distance, path] = BroadCasting(nodes, source, destination)
    n = length(nodes);
    dist = Inf(1, n);
    prev = -ones(1, n);
    pq = PriorityQueue();

    dist(source) = 0;
    pq.insert(source, 0);

    while ~pq.isEmpty
        u = pq.pop();
        if u == destination
            break;
        end
        neighbors = nodes(u).neighbor; 
        for i = 1 : length(neighbors)
            v = neighbors(i);
            w = nodes(u).distance(i);
            % Check energy constraint for each neighbor
            if nodes(v).E_initial <= nodes(v).critical_level
                continue;
            end
            if dist(u) + w < dist(v)
                dist(v) = dist(u) + w;
                prev(v) = u;
                pq.insert(v, dist(v));
            end
        end
        
    end

    % Reconstruct path
    path = [];
    current = destination;
    while current ~= -1
        path = [path, current];
        current = prev(current);
    end
    path = fliplr(path);

    shortest_distance = dist(destination);
end
