clear;
n = 15;
R = 15; % Radius in range of sensor Nodes

x = [-10,-5,-4,7,15,12,17,22,25,32,30,35,37,42,46];
y = [20,27,16,21,27.5,12,17,28,24,27,34,20,32,24,30];

matrix = zeros(n,n);

adj_matrix = zeros(n,n);

x1 = zeros(1,n);
y1 = zeros(1,n);

nodes = Nodes.empty(n, 0); % Khai báo một mảng các đối tượng Nodes

s = [];
t = [];

plot(x, y, 'mo',... % Plot all the nodes in 2 dimension
    'LineWidth',1.5,... % Size of the line
    'MarkerEdgeColor','k',... % The color of the outer surface of the node. Currently it is set to black color. "k" stand for black.
    'MarkerFaceColor', [1 1 0],... % The color of the inside of the node. Currently it is set to yellow color. " [1 1 0]" is a code of yellow color
    'MarkerSize',10)
hold on
numEdges = 0;
distances = [];
for i = 1 : n
    nodes(i) = Nodes(x(i), y(i)); % Khởi tạo đối tượng Nodes và thêm vào mảng
    for j = 1 : n
        distance = sqrt((x(i) - x(j))^2 + (y(i) - y(j))^2);
        matrix(i,j) = distance;
        if (i == j)
            adj_matrix(i,j) = 0;
        elseif (i ~= j && distance < R) 
            adj_matrix(i,j) = 1;
            numEdges = numEdges + 1;

        else
            adj_matrix(i,j) = inf;
        end
    end
end

weight = 0
for i = 1 : n
    for j = (i+1) : n 
        if matrix(i,j) < R
            weight = weight + 1;
            distances(weight) = matrix(i,j)
        end
    end
end


numEdges = numEdges/2;
count = 2;
for i = 1 : n
    for j = count : n
        if(adj_matrix(i,j) == 1)
            s = [s, i];
            t = [t, j];
        end
    end
    count = count + 1;
end

% INITIAL GRAPH
G = digraph(s, t, distances);
subplot(2,2,1);
p = plot(G,'XData',x,'YData',y,'EdgeLabel', G.Edges.Weight);
grid on;
title (' INITIAL GRAPH'); % Title of the plot

%PRIM GRAPH
G1 = graph(s,t,distances);
subplot(2,2,2);
p1 = plot(G1,'XData',x,'YData',y,'EdgeLabel', G1.Edges.Weight);
[T,pred] = minspantree(G1);
highlight(p1,T,'NodeColor','g','EdgeColor','r','LineWidth',1.5);
grid on;
xlabel (' Length (m)'); % X-label of the output plot
ylabel (' Width (m)'); % Y-label of the output plot
title (' PRIM'); % Title of the plot
% path = shortestpath(G,1,15);

% Packet transmission
% path2 = shortestpath(G,1,15);

% check_neighbor
for i = 1:n
    array_index = find(s == i);
    neighbor = t(array_index);
    nodes(i).neighbor = neighbor;
end

% distance
for i = 1 : n
    array_index = find(s == i);
    neighbor = t(array_index);
    for j = 1 : n
        if (ismember(j, neighbor))
            nodes(i).distance = matrix(i,j);
        end
    end
end
