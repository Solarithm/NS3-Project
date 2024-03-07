function Parent(MST, nodes)
    for iter = 1 : size(MST(:, 1))
        nodes(MST(iter, 1)).child = MST(iter, 2);
        nodes(MST(iter, 2)).parent = MST(iter, 1);
    end
    nodes(1).parent = 0;
end