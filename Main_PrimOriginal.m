
clc;
clear;
grid on
figure(1) % Hold figure 1
hold on
box on
xlabel (' Length (m)') % X-label of the output plot
ylabel (' Width (m)') % Y-label of the output plot
title (' Simulator') % Title of the plot

% Making Network
%R is communication range
R = 11;
% % 
% n = 30;
% % % 
% range_min_x = 1;
% range_max_x = 30;
% 
% range_min_y = 1;
% range_max_y = 22;
% 
% x = randi([range_min_x, range_max_x], n, 1);
% y = randi([range_min_y, range_max_y], n, 1);

[x, y, n] = coordinate();

matrix = zeros(n,n);

adj_matrix = zeros(n,n);

node(1,n) = Nodes();
s = [];
t = [];

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

% check_neighbor
neighbor = [];
ID = [];
for i = 1:n
%     Node Id 
    ID = [ID,i];
    node(i).ID = i;
    node(i).x = x(i);
    node(i).y = y(i);
    node(i).R = R;
    for j = 1:n
%     Node neighbor;
     if(adj_matrix(i,j) == 1)
        neighbor = [neighbor, j];
        node(i).neighbor = neighbor;
     end
    end
    neighbor = [];
end

    % Edge weight 
% distance
d = [];
linkQuality = [];
for i = 1 : n
         neighbor = node(i).neighbor;
         for j = 1 : n
             if (ismember(j,neighbor))
                 d = [d, matrix(i,j)];
                 node(i).d = d;
             end
         end
         d = [];
end

% % Link quality
%     
%     for i = 1 : n
%         node(i).update_LinkQuality;
%         array_index = find(i == s);
%         m = t(array_index);
%         for j = 1 : length(m);
%             if(ismember(m(j),node(i).neighbor))
%                 index = find(m(j) == node(i).neighbor);
%                 linkQuality = [linkQuality, node(i).link(index)];
%             end 
%         end
%     end
   
    

%% Simulation

time_start = 1;
time_end = 1000;
sensor_node = [16,11];
% node(1).E_intial = 10;
% for i = 2:n
%     if (mod(i,2) == 0)
%         sensor_node = [sensor_node, i];
%     end
% end

high_energy_threshold = 1.5;
medium_energy_threshold = 0.5;
node_critical_1 = [];
index1 = [];
E1_residual = [];
E1_consumption = [];
cycle_life = [];
dead_node = [];
green_node = [];
yellow_node = [];
red_node = [];
fileID = fopen('data.txt', 'w');


        for i1 = time_start:time_end  
            try
                residual_2 = 0;
                consumption_2 = 0;
                node_critical_1 = detect_criticalNode(node,n,medium_energy_threshold);
                Re_routing(node_critical_1,n,node);

            if(~isempty(node_critical_1) || i1 == 1 || mod(i1, 10) == 0)
                     MST_global_1 = Re_Prim(node_critical_1,1,n,node);
            end

         plot_figure(s, t, x, y, MST_global_1, linkQuality,high_energy_threshold,medium_energy_threshold,node);
         Check_parent(MST_global_1,node);
%          Energy(x,y,node,n);
%          pause(0.5);
            for j = 1:length(sensor_node)
                    Packet_transmission(sensor_node(j),node);
                    plot_path(s,t,x,y,sensor_node(j),high_energy_threshold,medium_energy_threshold,node);
                    Energy(x,y,node,n);
                    node_critical_1 = detect_criticalNode(node,n,medium_energy_threshold);
                    Re_routing(node_critical_1,n,node);
                    pause(0.1);
            end
            
           disp(i1);
           index1 = [index1, i1];
           fprintf(fileID, '%d ', i1);
           [consumption_2, residual_2] = Energy_residual(node, n);      
           %% Print in txt file
           fprintf(fileID, '%d ', residual_2);
           fprintf(fileID, '%d ', consumption_2);
           fprintf(fileID, '\n');
               disp(residual_2);
               E1_residual =  [E1_residual, residual_2];
               disp(consumption_2);
               E1_consumption = [E1_consumption, consumption_2];
              [cycle_life, dead_node] = life_time(n,node_critical_1,i1, cycle_life, dead_node);    
            catch
        fclose(fileID);
        break;
            end
        end
           disp('lan 1');
           [green_node, yellow_node, red_node] = analysisc_node(node, n);
           allNodes = [green_node, yellow_node, red_node];
           figure(1);
           plot_figure(s, t, x, y, MST_global_1, linkQuality,high_energy_threshold,medium_energy_threshold,node);
%            p_1 = figure(1);
%            saveas(p_1,'image/critical-node-path/Prim-original/30-sensor-Nodes-original-transmission-critical.png')
%             test_BarGraph(allNodes);
%             saveas(gcf, 'image/50-bar-graph-Prim-original.png'); 