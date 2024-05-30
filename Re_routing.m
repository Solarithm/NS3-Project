function Re_routing(node_critical, n, node)
<<<<<<< HEAD
    
    for i = 1: n
        for j = 1: length(node(i).neighbor)
            node(i).link(j) = node(node(i).neighbor(j)).E_intial * exp(-node(i).d(j));
        end
=======
    for i = 1: n
        node(i).update_LinkQuality;
>>>>>>> b6eb5148cb43f431b9ebacffd068f6ee182fa942
        node(i).update_routing(node_critical);
    end
end