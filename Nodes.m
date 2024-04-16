classdef Nodes < handle
    
    properties
        x;
        y;
        E_intial = 2;
        E_tx;
        E_rx;
        Packet_Size = 500; %bytes
        Elec = 50 * 0.000000001; % J/bit
        Eamp = 100 * 0.000000000001; %J
        Efs = 10 * 0.000000000001; % J/bit/m^2
        Emp = 0.0013 * 0.000000000001; %J/bit/m^4
        d; %distance
        d0; %thresh hold
        B = 500 * 1024; %bit 
        neighbor ;
        ID;
        parent;
        child;
        link;
        hirechical;
        
    end
  
    
    methods
        function change_energy_Tx(obj)
            for i = 1:length(obj.neighbor)
                if(obj.d(i) < obj.d0)
                     obj.E_tx(i) = (obj.B * obj.Elec) + (obj.B * obj.Efs * (obj.d(i)^2));
                else
                     obj.E_tx(i) = (obj.B * obj.Elec) + (obj.B * obj.Efs * (obj.d(i)^4));
                end
            end
        end
    
        function change_energy_Rx(obj)
                obj.E_rx = obj.B*obj.Elec;
        end
        
        function update_LinkQuality(obj)
            obj.link = [];
            for i = 1: length(obj.neighbor)
            obj.link(i) = obj.E_intial * exp(-obj.d(i));
            end
        end
        
        function update_routing(obj, node_critical)
            for i = 1:length(node_critical)
                 index_to_remove = find(obj.neighbor == node_critical(i));
                    if ~isempty(index_to_remove)
                obj.neighbor(index_to_remove) = [];
                obj.d(index_to_remove) = [];
                obj.link(index_to_remove) = [];
                if(isempty(obj.E_tx))
                    break;
                else
                obj.E_tx(index_to_remove) = [];
                end
                    
                    end
            update_LinkQuality(obj);
           end      
    end
    end
end