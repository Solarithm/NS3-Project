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
        % Delete node
        function DeleteNodesFromNeighbor(nodes, node_id)
            for i = 1 : length(nodes)
                for j = 1 : length(nodes(i).neighbor)
                    if nodes(i).neighbor(j) == node_id
                        nodes(i).neighbor(j) = [];
                        break;
                    end           
                end
                if nodes(i).child == node_id
                    nodes(i).child = [];
                end

                if nodes(i).parent == node_id
                    nodes(i).parent = [];
                end
            end 
        end
        
        function DisconnectedNode(nodes, node_id)
            nodes(node_id).status = 0;
            nodes(node_id).E_initial = 0;
            DeleteNodesFromNeighbor(nodes, node_id);
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
        %Energy information on figure 
        function plot_energy_info(nodes)
            persistent prev_text_handles; % Persistent variable to store previous text handles
            n = numel(nodes); 
            x = zeros(1, n);
            y = zeros(1, n);
            str = cell(1, n);    
            % Get nodes' positions and energy information
            for i = 1:n
                x(i) = nodes(i).x;
                y(i) = nodes(i).y;
                str{i} = num2str(nodes(i).E_initial);
            end 
            % Delete previous energy information if handles are valid
            if ~isempty(prev_text_handles) && all(ishandle(prev_text_handles))
                delete(prev_text_handles);
            end
            % Plot energy information text
            text_handles = zeros(1, n);
            for i = 1:n
                text_handles(i) = text(x(i) + 0.7, y(i) + 0.7, str{i});
            end 
            % Store current text handles for future deletion
            prev_text_handles = text_handles;
            hold off;
        end

    end
end
