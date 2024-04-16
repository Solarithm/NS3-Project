function plot_path(s,t, x, y,sensor_node,high_energy_threshold,medium_energy_threshold, node)
        clf;
        grid on;
        hold on;
        
        G = graph(s,t);
        
        figure = plot(G,'XData',x,'YData',y);
        
        
            for i = 1:size(node,2)
        if (node(i).E_intial > high_energy_threshold)
            % Node có n?ng l??ng cao: màu xanh
            plot_node = plot(x(i), y(i), 'o', 'LineWidth', 1.5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 10);
        elseif (node(i).E_intial <= high_energy_threshold && node(i).E_intial > medium_energy_threshold)
            % Node có n?ng l??ng trung bình: màu vàng
            plot_node = plot(x(i), y(i), 'o', 'LineWidth', 1.5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'y', 'MarkerSize', 10);
        else
            % Node có n?ng l??ng th?p: màu ??
            plot_node = plot(x(i), y(i), 'o', 'LineWidth', 1.5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
        end
            end  
    
                %from sensor_node to source node
        while(node(sensor_node).parent ~= 0)
        x1 = x(sensor_node);
        y1 = y(sensor_node);
        x2 = x(node(sensor_node).parent);
        y2 = y(node(sensor_node).parent);
        h = line([x1, x2], [y1, y2]);
        h.LineStyle = '-';
        h.LineWidth = 2;
        h.Color = [0.9290 0.6940 0.3];
        pause(0.2);
        sensor_node = node(sensor_node).parent;    
        end   
end
