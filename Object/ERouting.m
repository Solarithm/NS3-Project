function path = ERouting(nodes, source, destination)
    [shortest_distance, path] = EBroadCasting(nodes, source, destination);

    if isinf(shortest_distance)
%         fprintf('ROUTING FAILED FROM %d TO %d \n', source, destination);
        return;
    end
end