function Re_routing(node_critical, n, node)
    
    for i = 1: n
        for j = 1: length(node(i).neighbor)
            node(i).link(j) = node(node(i).neighbor(j)).E_intial * exp(-node(i).d(j));
        end
        node(i).update_routing(node_critical);
    end
end