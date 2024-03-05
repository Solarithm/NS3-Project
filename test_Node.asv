%%
clc;
clear;
grid on
figure(1) % Hold figure 1
hold on
box on
xlabel (' Length (m)') % X-label of the output plot
ylabel (' Width (m)') % Y-label of the output plot
title (' Simulator') % Title of the plot

%% Making Network
n = 15; 
R = 11; % Radius in range of sensor Nodes

x = [-5,3,4,7,12,12,17,22,27,33,31,35,37,46,51];
y = [20,23,18,21,27,12,17,28,21,25,26,24,26,26,30];
    
matrix = zeros(n,n);

adj_matrix = zeros(n,n);

nodes = Node.empty(n, 0);
for i = 1 : n
    nodes(i) = Node(x(i), y(i));
end
s = [];
t = [];

clf;
hold on;
plot (x,y,'mo',... % Plot all the nodes in 2 dimension
    'LineWidth',1.5,... % Size of the line
    'MarkerEdgeColor','k',... % The color of the outer surface of the node. Currently it is set to black color. "k" stand for black.
    'MarkerFaceColor', [1 1 0],... % The color of the inside of the node. Currently it is set to yellow color. " [1 1 0]" is a code of yellow color
    'MarkerSize',10)

for i = 1 : n
    for j = 1 : n
        distance = sqrt((x(i) - x(j))^2 + (y(i) - y(j))^2);
        matrix(i,j) = distance;
         if (i == j)
            adj_matrix(i,j) = 0;
         elseif (i~=j && distance < R) 
            adj_matrix(i,j) = 1;
         else
             adj_matrix(i,j) = inf;
         end       
     end
end

count =2;
for i = 1 : n
   for j = count : n
    if(adj_matrix(i,j) == 1)
       s = [s, i];
       t = [t, j];
    end
   end
       count = count + 1;
end

%% Simulation
timeStart = 1;
timeEnd = 100;
for timeStep = timeStart : timeEnd
    %% Check_neighbor
    neighbor = [];
    ID = [];
    for i = 1:n
        %Node Id 
        ID = [ID,i];
        nodes(i).ID = i;
        nodes(i).d0 = sqrt(nodes(i).Efs/nodes(i).Emp);
        for j = 1:n
        %Node neighbor;
         if(adj_matrix(i,j) == 1)
           neighbor = [neighbor, j];
           nodes(i).neighbor = neighbor;
            end
        end
        neighbor = [];
    end

    %% Edge Weights
    distances = [];
    linkQuality = [];
    weight = 0;
    for i = 1 : n
        for j = (i+1) : n 
            if matrix(i,j) < R
                weight = weight + 1;
                distances(weight) = matrix(i,j);
                linkQuality(weight) = nodes(i).E_initial*exp(-distances(weight));
                nodes(i).link = linkQuality(weight);
            end
        end
    end
    %distance
    d = [];
    link = [];
    for i = 1 : n
         neighbor = nodes(i).neighbor;
         for j = 1 : n
             if (ismember(j,neighbor))
                 d = [d, matrix(i,j)];
                 nodes(i).distance = d;
                 link = [link, matrix(i,j)];
                 nodes(i).link = nodes(i).E_initial*exp(-nodes(i).distance);
             end
         end
         d = [];
         link = [];
    end

    %% Graph    
    G = digraph(s,t);
    figure = plot(G,'XData',x,'YData',y, 'EdgeLabel', linkQuality)
    figure.NodeColor = 'r';
    
    %% Add energy 
    Energy(x,y,nodes);

    %% Prim_local
    MST_lobal = Prim(1, 13, nodes);
    for i = 1 : size(MST_lobal,1)
            x1 = x(MST_lobal(i, 1));
            y1 = y(MST_lobal(i, 1));
            x2 = x(MST_lobal(i, 2));
            y2 = y(MST_lobal(i, 2));
            h = line([x1, x2], [y1, y2]);
            h.LineStyle = '-';
            h.LineWidth = 2;
            r = rand(1, 1); 
            g = rand(1, 1); 
            b = rand(1,1);
            h.Color = [r g b];
            drawnow;
    end
    pause(0.1);
end