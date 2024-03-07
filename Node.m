classdef Node < handle  
    properties
        x;
        y;
        radious;
        E_initial = 2;
        E_tx;
        E_rx;
        Packet_Size = 500; %bytes
        Elec = 50 * 0.000000001; % J/bit
        Eamp = 100 * 0.000000000001; %J
        Efs = 10 * 0.000000000001; % J/bit/m^2
        Emp = 0.0013 * 0.000000000001; %J/bit/m^4
        distance = []; %distance
        d0; %thresh hold
        B = 500 * 1024; %bit 
        neighbor = [];
        ID;
        parent;
        child;
        link = []; %connection to node neighbor
        status = 3; %live node. If dead, status = 0 
    end  
    methods
        function node = Node(x, y)
            node.x = x;
            node.y = y;
        end

        function change_energy_Tx(node)
            for i = 1 : length(node.neighbor)
                if(node.distance(i) < node.d0)
                     node.E_tx(i) = (node.B * node.Elec) + (node.B * node.Efs * (node.distance(i)^2));
                else
                     node.E_tx(i) = (node.B * node.Elec) + (node.B * node.Efs * (node.distance(i)^4));
                end              
            end
        end

        function change_energy_Rx(obj)
            obj.E_rx = obj.B*obj.Elec;
        end
        
        function update_routing(obj, node_critical) 
            
        end
    end
end
