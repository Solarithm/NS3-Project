function p = PathFromPrim(sensor_node, MST)
    p = [];
    while (sensor_node ~= 0)
        for i = 1 : find(MST(:, 2) == sensor_node)
            cnt = 1;
            if MST(i, 2) == sensor_node
                p(cnt) = sensor_node;
                sensor_node = MST(i, 1);
                cnt=cnt+1;
            end
        end
    end
end