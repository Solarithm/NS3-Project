
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
n = 16; 
R = 11; % Radius in range of sensor Nodes

x = [2,3,4,7,12,12,17,22,24,31,31,22,37,41,46,51];
y = [20,23,18,21,27,12,17,28,21,23,30,17,26,34,26,30];

matrix = zeros(n,n);

adj_matrix = zeros(n,n);

node(1,n) = Nodes();
s = [];
t = [];
node(1).E_intial = 100;

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
for i = 1:n
    %Node Id 
    ID = [ID,i];
    node(i).ID = i;
    %Threshhold distance
    node(i).d0 = sqrt(node(i).Efs/node(i).Emp);
    for j = 1:n
    %Node neighbor;
     if(adj_matrix(i,j) == 1)
        neighbor = [neighbor, j];
        node(i).neighbor = neighbor;
     end
    end
    neighbor = [];
end

    %% Edge Weights

%distance
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

%Link quality
    
%     for i = 1 : n
%         node(i).update_LinkQuality;
%         array_index = find(i == s);
%         m = t(array_index);
%         for j = 1 : length(m);
%             if(ismember(m(j),node(i).neighbor))
%                 index = find(m(j) == node(i).neighbor);
%                 linkQuality = [linkQuality, node(i).link(index)];
%             end. 
%         end
%     end
   
    

%% Simulation
time_start = 1;
time_end = 30;
sensor_node = [16,14,11];

high_energy_threshold = 1.8;
medium_energy_threshold = 0.8;
node_critical = [];

    for i = time_start:time_end  
    node_critical = detect_criticalNode(node,n,medium_energy_threshold);
    Re_routing(node_critical,n,node);
    MST_global = Re_Prim(node_critical,1,16,node);

         plot_figure(s, t, x, y, MST_global, linkQuality,high_energy_threshold,medium_energy_threshold,node);
         Check_parent(MST_global,node);
         Energy(x,y,node);
            for j = 1:length(sensor_node)
                    Packet_transmission(sensor_node(j),node);
                    plot_path(s,t,x,y,sensor_node(j),high_energy_threshold,medium_energy_threshold,node);
                    Energy(x,y,node);
                    pause(2);
            end
    end
     
   




