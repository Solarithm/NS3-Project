function plot_Node(x, y, high_energy_threshold, medium_energy_threshold, node)
    clf;
    grid on;
    hold on;

    for i = 1:15
        if (node(i).E_intial > high_energy_threshold)
            % Node có n?ng l??ng cao: màu xanh
            plot_node = plot(x(i), y(i), 'o', 'LineWidth', 1.5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
        elseif (node(i).E_intial <= high_energy_threshold && node(i).E_intial > medium_energy_threshold)
            % Node có n?ng l??ng trung bình: màu vàng
            plot_node = plot(x(i), y(i), 'o', 'LineWidth', 1.5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'y', 'MarkerSize', 10);
        else
            % Node có n?ng l??ng th?p: màu ??
            plot_node = plot(x(i), y(i), 'o', 'LineWidth', 1.5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
        end
    end
end

