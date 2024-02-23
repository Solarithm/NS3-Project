clear;
n=15; 
R = 15; % Radius in range of sensor Nodes

x = [-10,-5,-4,7,10,12,17,22,25,28,31,35,37,42,46];
y = [20,27,16,21,35,12,17,28,24,25,38,20,32,26,30];

matrix = zeros(15,15);

adj_matrix = zeros(15,15);

x1 = zeros(1,15);
y1 = zeros(1,15);

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
G = digraph(s,t);
p = G;
%p.LineWidth = 1.5;
%p.MarkerEdgeColor = k;
% p.MarkerSize = 10;
% p.MarkerFaceColor = [1 1 0];

figure = plot(p,'XData',x,'YData',y)
%     'LineWidth',1.5,... % Size of the line
%     'MarkerEdgeColor','k',... % The color of the outer surface of the node. Currently it is set to black color. "k" stand for black.
%     'MarkerFaceColor', [1 1 0],... % The color of the inside of the node. Currently it is set to yellow color. " [1 1 0]" is a code of yellow color
%     'MarkerSize',10

figure.NodeColor = 'r';


path = shortestpath(p,1,15);

% Packet transmission


path2 = shortestpath(p,1,15);

s_plot = [];
t_plot = [];
x_plot =[];
y_plot = [];

packet = 0;
num = [];
str = {};

% while(packet < 3)
% while(length(path) > 1)
%     for i = 1:15
%         num(i,packet+1) = node(i).E_intial;
%     if(i == path(1))
%         num(i,packet+1) = node(i).E_intial;
%         node(i).update_energy_Tx;
%         array_index = find(s == path(1));
%        for k = 1:length(array_index)
%         m = t(array_index(k));
%         node(m).update_energy_Rx;
%         num(m,packet+1) = node(m).E_intial;
%        end
% %         pause(1);
%         path = path(2:end);
%         break;
%     end  
%      
%     end 
% end
%     packet = packet + 1;
%     path = path2;
% end

%check_neighbor
for i = 1:15
    array_index = find(s == i);
    neighbor = t(array_index);
    node(i).neighbor = neighbor;
end

%distance
d = [];
for i = 1 : 15
         array_index = find(s == i);
         neighbor = t(array_index);
         for j = 1 : 15
             if (ismember(j,neighbor))
                 d = [d, matrix(i,j)];
                 node(i).d = d;
             end
         end
         d = [];
end


%     for i = 1 : 15   
%      x1(i) = x(i) + 1;
%      y1(i) = y(i) + 1;
%     
%      str{i,1} = num(i,packet)
%     end
    
text(x1,y1,str);


grid on
figure(1) % Hold figure 1
hold on
box on
xlabel (' Length (m)') % X-label of the output plot
ylabel (' Width (m)') % Y-label of the output plot
% zlabel (' Height (m)') % Z-label of the output plot
title (' Simulator') % Title of the plot
grid on % Activate the grid in background of the plot
% Hold figure 1
%Note: To change the color, just write "r" for red, "g" for green, "b" for
%blue, "m" for magenta, "c" for cyan and so on