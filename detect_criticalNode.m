function node_critical = detect_criticalNode(node,number_Node,medium_energy) 
        node_critical = [];
        for i = 1: number_Node
            if( node(i).E_intial < medium_energy  && i > 1)
                node_critical = [node_critical, i];
            end
        end
         
        
end