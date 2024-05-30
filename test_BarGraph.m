function test_BarGraph(allNodes)
    colors = ['g', 'y', 'r']; % Define colors

    figure;
    hold on; % Prevent overwriting the plot

    % Iterate through the nodes
    for k = 1:2:length(allNodes)
        b = bar(k, allNodes(k), 'FaceColor', colors(mod((k-1)/2, length(colors)) + 1));
        if k+1 <= length(allNodes) % Ensure we don't exceed the length of allNodes
            a = bar(k+1, allNodes(k+1), 'FaceColor', colors(mod((k-1)/2, length(colors)) + 1));
        end
    end

    hold off; % Release the hold
    ylabel('Number of Nodes');
%     title('Bar Graph of Energy Nodes in 450 step - 50 Nodes'); % Add a title to the plot
end
