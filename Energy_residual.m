function energy = Energy_residual(node, n, sensor_node)
    energy = 0;
    for i = 1:n
            energy = energy + node(i).E_intial;
    end
end