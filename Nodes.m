classdef Nodes < handle
    
    properties
        x;
        y;
        R;
        E_intial = 2;
        E_tx;
        E_rx;
        P_leach;
        T_leach;
        Elec = 50 * 10^-9; % J/bit
        Eamp = 0.013 * 10^-12; %J/bit/m^4
        Efriis = 10 * 10^-12; % J/bit/m^2
        d; %distance
        d0 = 86.1424; %thresh holdq
        B = 1024 * 8 * 400; 
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
                     obj.E_tx(i) = (obj.B * obj.Elec) + (obj.B * obj.Efriis * (obj.d(i)^2));
                else
                     obj.E_tx(i) = (obj.B * obj.Elec) + (obj.B * obj.Eamp * (obj.d(i)^4));
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