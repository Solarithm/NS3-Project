cla;
clf;
clc;
clear;
grid on
figure(1) % Hold figure 1
hold on
box on
xlabel (' Length (m)') % X-label of the output plot
ylabel (' Width (m)') % Y-label of the output plot
title (' Simulator') % Title of the plot
% Define legend labels and corresponding colors
legend_labels = {'Transmission Path'};
legend_colors = {'b'};

% Create a custom legend without actual plot data
for i = 1:numel(legend_labels)
    plot(NaN, NaN, 'Color', legend_colors{i}, 'DisplayName', legend_labels{i});
    hold on;
end
% Show legend
legend('Location', 'best');
%% Making Network
numNodes = 16; 
R = 11; % Radius in range of sensor Nodes
%    1  2   3   4   5   6   7   8   9   10  11  12  13  14  15  16
x = [0, 20, 20, 30, 30, 40, 45, 60, 60, 60, 60, 60, 80, 85, 90, 100];
y = [0, 0, 10, 20, -10, 0, -15, 0,  10,  20, 30, -20, 0, -10, -20,0];   
nodes = Node.empty(numNodes, 0);
for i = 1 : numNodes
    nodes(i) = Node(i, x(i), y(i), R);
end
plot (x, y, 'o');
%% Graph
s = [1, 2, 2, 2, 2, 3 ]
t = [2, 1, 5, 6, 3, 4
G = graph(s, t);
figure = plot(G, 'XData', x, 'YData', y);
plot_energy_info(nodes);


timeStart = 1;
timeEnd = 100;
for timeStep = timeStart : timeEnd
    
    pause(0.1);    
end