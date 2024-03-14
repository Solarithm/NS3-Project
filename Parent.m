function Parent(MST, nodes)
    max = 0;
    for i = 1 : size(MST(:, 2))
        if MST(i, 2) > max
            max = MST(i, 2);
        end
    end
    s = find(MST(:, 2) == max);
    for iter = 1 : s
        nodes(MST(iter, 1)).child = MST(iter, 2);
        nodes(MST(iter, 2)).parent = MST(iter, 1);
    end
    nodes(1).parent = 0;
end