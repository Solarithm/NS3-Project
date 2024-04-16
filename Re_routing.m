function Re_routing(node_critical, n, node)
    for i = 1: n
        node(i).update_LinkQuality;
        node(i).update_routing(node_critical);
    end
end