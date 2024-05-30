function Leach = (node, n, r)
        for i = 1:n
            node(i).P_leach = rand(i);
            node(i).T_leach = 0.05 / (1 - (0.05 * mod(r,1/0.05)));
        end
           
end