function PrimPacketTransmission(source, destination, network) 
    if (network.nodes(source).E_initial < 1 || network.nodes(destination).E_initial < 1)
%         fprintf("Node %d turn on sleep mode\n", source);
        return;
    end
    if (DetectCriticalNode(network.nodes) == 1)
        ClearRoutingTable(network.nodes);
        PrimTree(network, destination);
    end 
    if ~any([network.nodes(source).routingTable.Destination] == destination)
        PrimTree(network, destination);           
    end   
    
    px = [];
    py = []; 
    iter = 1;
    px(iter) = network.nodes(source).x;
    py(iter) = network.nodes(source).y;
    iter = 2;
    arr_line = [];
%     fprintf("Transmitting data from node %d to node %d\n", source, destination);
    while(source ~= destination)   
        % Get next hop from routing table
        idex_arr = [network.nodes(source).routingTable.Destination];
        des_idx = find(idex_arr == destination);
        if (isempty(des_idx))
            return;
        end
        next_hop = network.nodes(source).routingTable(des_idx).NextHop;
        change_energy_Tx(network.nodes(source));
        idx = find(network.nodes(source).neighbor == next_hop);
        network.nodes(source).E_initial = network.nodes(source).E_initial - network.nodes(source).E_tx(idx);                
        change_energy_Rx(network.nodes(next_hop));
        network.nodes(next_hop).E_initial = network.nodes(next_hop).E_initial - network.nodes(next_hop).E_rx;
        px(iter) = network.nodes(next_hop).x;
        py(iter) = network.nodes(next_hop).y;
        %draw transmission line
%         h = line([px(iter - 1), px(iter)], [py(iter - 1), py(iter)]);
%         h.LineStyle = '-';
%         h.LineWidth = 2;
%         h.Color = [0 0 1];
%         arr_line(end+1) = h; % Store handle to the line object
%         h.HandleVisibility = 'off';
%         plot_energy_info(network.nodes);
%         pause(0.05); 
%         drawnow;
        %end draw          
        iter = iter + 1;
        source = next_hop;  
    end   
    plot_energy_info(network.nodes);
    % Clear the previous lines
    for i = 1:numel(arr_line)
        delete(arr_line(i)); % Delete the line object
    end
    
end
