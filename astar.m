function [shortest_distance, path] = astar(nodes, start, finish)
    n = length(nodes);
    dist = Inf(1, n);
    prev = -ones(1, n);
    pq = PriorityQueue();

    dist(start) = 0;
    pq.insert(start, 0);

    while ~pq.isEmpty
        u = pq.pop();
        if u == finish
            break;
        end
        neighbors = nodes(u).neighbor;
        for i = 1 : length(neighbors)
            v = neighbors(i);
            w = nodes(u).distance(i); 
            if dist(u) + w < dist(v)
                dist(v) = dist(u) + w;
                prev(v) = u;
                pq.insert(v, dist(v));
            end
        end
    end

    path = [];
    current = finish;
    while current ~= -1
        path = [path, current];
        current = prev(current);
    end
    path = fliplr(path);

    shortest_distance = dist(finish);
end


