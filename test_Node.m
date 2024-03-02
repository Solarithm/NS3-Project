clc;
clear;


grid on
figure(1) % Hold figure 1
hold on
box on
xlabel (' Length (m)') % X-label of the output plot
ylabel (' Width (m)') % Y-label of the output plot
title (' Simulator') % Title of the plot


n = 15; 
R = 11; % Radius in range of sensor Nodes

x = [-5,3,4,7,12,12,17,22,27,33,31,35,37,46,51];
y = [20,23,18,21,27,12,17,28,21,25,26,24,26,26,30];

matrix = zeros(15,15);

adj_matrix = zeros(15,15);

node(1,15) = Nodes();
s = [];
t = [];

plot (x,y,'mo',... % Plot all the nodes in 2 dimension
    'LineWidth',1.5,... % Size of the line
    'MarkerEdgeColor','k',... % The color of the outer surface of the node. Currently it is set to black color. "k" stand for black.
    'MarkerFaceColor', [1 1 0],... % The color of the inside of the node. Currently it is set to yellow color. " [1 1 0]" is a code of yellow color
    'MarkerSize',10)
hold on

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

%check_neighbor
neighbor = [];
ID = [];
for i = 1:15
    %Node Id 
    ID = [ID,i];
    node(i).ID = i;
    node(i).d0 = sqrt(node(i).Efs/node(i).Emp);
    for j = 1:15
    %Node neighbor;
     if(adj_matrix(i,j) == 1)
       neighbor = [neighbor, j];
       node(i).neighbor = neighbor;
        end
    end
    neighbor = [];
end

%distance
d = [];
for i = 1 : 15
         neighbor = node(i).neighbor;
         for j = 1 : 15
             if (ismember(j,neighbor))
                 d = [d, matrix(i,j)];
                 node(i).d = d;
             end
         end
         d = [];
end

G = digraph(s,t);
p = G;
figure = plot(p,'XData',x,'YData',y)
figure.NodeColor = 'r';



%% Add energy 
Energy(x,y,node);

%%


% G1 = graph(s,t);
% T1 = minspantree(G1);
% figure1 =  plot(T1,'XData',x,'YData',y)
% figure1.LineStyle = '-';
% figure1.LineWidth = 2;
% figure1.NodeColor = 'r';
        
      
%% Prim_local

MST_local = Prim(8,13,node);

s8_13 = MST_local(:,1);
t8_13 = MST_local(:,2);
for i = 1 : size(MST_local,1)
        x1 = x(MST_local(i, 1));
        y1 = y(MST_local(i, 1));
        x2 = x(MST_local(i, 2));
        y2 = y(MST_local(i, 2));
        h = line([x1, x2], [y1, y2],'LineStyle','-','LineWidth',2,'Color', 'y');
end

               



