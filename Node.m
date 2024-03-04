classdef Node < handle
    
    properties
        E_initial = 2;
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
        link; %connection to node neighbor
    end
  
    
    methods
        function change_energy_Tx(obj)
            for i = length(obj.neighbor)
                if(obj.d(i) < obj.d0)
                     obj.E_tx = (obj.B * obj.Elec) + (obj.B * obj.Efs * (obj.d(i)^2));
                else
                     obj.E_tx = (obj.B * obj.Elec) + (obj.B * obj.Efs * (obj.d(i)^4));
                end              
            end
        end
    
        function change_energy_Rx(obj)
                obj.E_rx = obj.B*obj.Elec;
        end
    end
end