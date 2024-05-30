<<<<<<< HEAD
function [energy_consumption, energy_residual] = Energy_residual(node, n)
    energy_total =  2 * (n-1) + 10; 
    energy_residual = 0;
    for i = 1:n
        energy_residual = energy_residual + node(i).E_intial;
    end
    
    energy_consumption = energy_total - energy_residual;
end
=======
function energy = Energy_residual(node, n, sensor_node)
    energy = 0;
    for i = 1:n
            energy = energy + node(i).E_intial;
    end
end
>>>>>>> b6eb5148cb43f431b9ebacffd068f6ee182fa942
