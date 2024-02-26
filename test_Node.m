clear;
n = 15;
R = 1.5; % Radius in range of sensor Nodes

x = [-1,-0.5,-0.4,0.7,1.5,1.2,1.7,2.2,2.5,3.2,3.0,3.5,3.7,4.2,4.6];
y = [2,2.7,1.6,2.1,2.75,1.2,1.7,2.8,2.4,2.7,3.4,2.0,3.2,2.4,3.0];

matrix = zeros(15,15);

adj_matrix = zeros(15,15);

x1 = zeros(1,15);
y1 = zeros(1,15);

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


for i = 1 : 15
    for j = (i+1) : 15
        
    end
end

G = digraph(s, t);
G1 = graph(s,t,distances);
p = plot(G,'XData',x,'YData',y);
p1 = plot(G1,'XData',x,'YData',y);
[T,pred] = minspantree(G1);
highlight(p1,T);

% path = shortestpath(p,1,15);

% Packet transmission
% path2 = shortestpath(p,1,15);

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

grid on;
xlabel (' Length (m)'); % X-label of the output plot
ylabel (' Width (m)'); % Y-label of the output plot
title (' Simulator'); % Title of the plot
