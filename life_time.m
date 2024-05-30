function [round,dead_node]= life_time(n, CN, index, round, dead_node)
    
    pertencege = 1;
    phan_tram = pertencege * length(CN); 
    phan_tram = (100/n)*length(CN);

    if (length(CN) < n)
            round = [round, index];
            dead_node = [dead_node, phan_tram];
    end
         
end 
    

    