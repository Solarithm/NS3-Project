function Create(num)
    cla;
    clf;
    clc;
    grid on
    figure(1) % Hold figure 1
    hold on
    box on
    xlabel (' Length (m)') % X-label of the output plot
    ylabel (' Width (m)') % Y-label of the output plot
    title (' Simulator') % Title of the plot
    % Define legend labels and corresponding colors
    if (num == 1)
        legend_labels = {'RREQ', 'RREP', 'Transmission Path'};
        legend_colors = {'c', 'r', 'b'};
    elseif (num == 2)
        legend_labels = {'PrimPath', 'Transmission Path'};
        legend_colors = {'g', 'b'};
    end
    % Create a custom legend without actual plot data
    for i = 1:numel(legend_labels)
        plot(NaN, NaN, 'Color', legend_colors{i}, 'LineWidth', 2, 'DisplayName', legend_labels{i});
        hold on;
    end
    % Show legend
    legend('Location', 'best');
    clear;
end