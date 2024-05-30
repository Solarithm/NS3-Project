function plot_path(s,t, x, y,sensor_node,high_energy_threshold,medium_energy_threshold, node)
        clf;
        grid on;
        hold on;
        
        G = graph(s,t);
        
        figure = plot(G,'XData',x,'YData',y);
        
        
            for i = 1:size(node,2)
<<<<<<< HEAD
        if(i == 1)
            plot_node = plot(x(i), y(i), 'o', 'LineWidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 13);        
        elseif (node(i).E_intial > high_energy_threshold)
=======
        if (node(i).E_intial > high_energy_threshold)
>>>>>>> b6eb5148cb43f431b9ebacffd068f6ee182fa942
            % Node có n?ng l??ng cao: màu xanh
            plot_node = plot(x(i), y(i), 'o', 'LineWidth', 1.5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 10);
        elseif (node(i).E_intial <= high_energy_threshold && node(i).E_intial > medium_energy_threshold)
            % Node có n?ng l??ng trung bình: màu vàng
            plot_node = plot(x(i), y(i), 'o', 'LineWidth', 1.5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'y', 'MarkerSize', 10);
        else
            % Node có n?ng l??ng th?p: màu ??
            plot_node = plot(x(i), y(i), 'o', 'LineWidth', 1.5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
        end
<<<<<<< HEAD
    end
=======
            end  
>>>>>>> b6eb5148cb43f431b9ebacffd068f6ee182fa942
    
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
<<<<<<< HEAD
        pause(0.3);
        sensor_node = node(sensor_node).parent;   
%         pause(0.8);
=======
        pause(0.2);
        sensor_node = node(sensor_node).parent;    
>>>>>>> b6eb5148cb43f431b9ebacffd068f6ee182fa942
        end   
end
