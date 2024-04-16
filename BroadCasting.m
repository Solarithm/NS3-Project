function [shortest_distance, path] = BroadCasting(nodes, start, finish)
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
            % Check energy constraint for each neighbor
            if nodes(v).E_initial <= nodes(v).critical_level
                continue; % Skip this neighbor if energy constraint is not met
            end
            if dist(u) + w < dist(v)
                dist(v) = dist(u) + w;
                prev(v) = u;
                pq.insert(v, dist(v));
            end
        end
        % If no neighbor meets the energy constraint, choose the neighbor with the highest initial energy
        if all([nodes(neighbors).E_initial] <= [nodes(neighbors).critical_level])
            [~, max_E_index] = max([nodes(neighbors).E_initial]);
            v = neighbors(max_E_index);
            w = nodes(u).distance(max_E_index);
            if dist(u) + w < dist(v)
                dist(v) = dist(u) + w;
                prev(v) = u;
                pq.insert(v, dist(v));
            end
        end
    end

    % Reconstruct path
    path = [];
    current = finish;
    while current ~= -1
        path = [path, current];
        current = prev(current);
    end
    path = fliplr(path);

    shortest_distance = dist(finish);
end
