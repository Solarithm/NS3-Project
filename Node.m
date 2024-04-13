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
        status = 3; %live node. If dead, status = 0 
        routingTable;
    end  
    methods
        %Constructor
        function node = Node(id, x, y, radious)
            node.ID = id;
            node.x = x;
            node.y = y;
            node.radious = radious;
            node.routingTable = struct('Destination', {}, 'NextHop', {}, 'Cost', {});
        end
        function Distance(nodes)
            for i = 1 : length(nodes)
                for j = 1 : length(nodes(i).neighbor)
                    nodes(i).distance(j) = sqrt((nodes(i).x - nodes(nodes(i).neighbor(j)).x)^2 ...
                        + (nodes(i).y - nodes(nodes(i).neighbor(j)).y)^2);
                end
            end
        end

        function adj_matrix = AdjMatrix(nodes)
            adj_matrix = zeros(length(nodes), length(nodes));
            for i = 1 : length(nodes)
                for j = 1 : length(nodes)
                    distance = sqrt((nodes(i).x - nodes(j).x)^2 ...
                        + (nodes(i).y - nodes(j).y)^2);
                    if (i == j)
                        adj_matrix(i,j) = 0;
                    elseif (i~=j && distance < nodes(i).radious && nodes(i).status > 0)
                        adj_matrix(i,j) = 1;
                    else
                        adj_matrix(i,j) = inf;
                    end
                end
            end
        end
        
        function [s, t] = Neighbor(nodes)
            adj_matrix = AdjMatrix(nodes);
            for i = 1 : length(nodes)
                neighborCount = 0;
                for j = 1 : length(nodes)
                    if(adj_matrix(i, j) == 1)
                        neighborCount = neighborCount + 1;
                        nodes(i).neighbor(neighborCount) = j;
                    end
                end
            end
            
            s = [];
            t = [];
            count = 2;
            for i = 1 : length(nodes)
                for j = count : length(nodes)
                    if(adj_matrix(i,j) == 1)
                       s = [s, i];
                       t = [t, j];
                    end
                end
                count = count + 1;
            end
            Distance(nodes);
        end
        %Add route
        function add_route(node, destination, next_hop, cost)
            % Add a new route to the routing table
            new_entry.Destination = destination;
            new_entry.NextHop = next_hop;
            new_entry.Cost = cost;
            node.routingTable(end+1) = new_entry;
        end

        function display_routing_table(node)
            % Display the routing table
            fprintf('Routing table for Node %d:\n', node.ID);
            for i = 1:length(node.routingTable)
                fprintf('Destination: %d, NextHop: %d, Cost: %f\n', ...
                    node.routingTable(i).Destination, ...
                    node.routingTable(i).NextHop, ...
                    node.routingTable(i).Cost);
            end
        end

        %Energy
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
        function ShowEnergy(nodes)
            n = 15; 
            x1 = zeros(1,n);
            y1 = zeros(1,n);    
            str = {};    
            for i = 1:n
                x1(i) = nodes(i).x + 0.7;
                y1(i) = nodes(i).y + 0.7;
                str{i} = num2str(nodes(i).E_initial);
                  text(x1(i), y1(i), str{i});
            end 
        end
    end
end
