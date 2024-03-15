function plot_figure(s, t, x, y, MST, link,high_energy_threshold,medium_energy_threshold, node)
        clf;
        grid on;
        hold on;
        
        G = graph(s,t);
        
        figure = plot(G,'XData',x,'YData',y, 'EdgeLabel', link);
        
        
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
           

        for i = 1 : size(MST,1)
        x1 = x(MST(i, 1));
        y1 = y(MST(i, 1));
        x2 = x(MST(i, 2));
        y2 = y(MST(i, 2));
        h = line([x1, x2], [y1, y2]);
        h.LineStyle = '-';
        h.LineWidth = 2;
        h.Color = [0.9290 0.6940 0.1250];
        pause(0.1);
        end
         
end
