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
% %R is communication range
R = 11;
% % 
% % Ph?m vi c?a t?a ?? x (ví d? t? -10 ??n 10)
% xmin = 0;
% xmax = 30;
% 
% ymin = 0;
% ymax = 30;
% 
% % T?o m?ng ch?a các t?a ?? x ng?u nhiên
% x = randi([xmin, xmax], 1, n);
% y = randi([ymin, ymax], 1, n);

% 16 node
% n = 16
% x = [2,3,4,11,12,12,17,22,18,28,31,22,37,41,46,51];
% y = [20,23,18,21,27,18,17,28,25,23,30,17,26,34,26,30]; 

% n = 16;
% x = [2,3,4,11,12,12,17,18,18,24,27,22,25,22,25,30];
% y = [20,23,18,21,27,18,17,28,23,23,27,17,26,22,18,22]; 

%30 node
n = 30; 
x = [25,22,27,10,20,30,14,18,12,9,8,23,30,5,24,6,30,24,13,22,15,25,11,0,18,28,6,13,23,21];
y = [0,29,23,17,5,15,16,20,26,29,21,12,28,14,7,12,21,17,23,30,29,16,29,3,1,9,17,16,27,16];

% n = 30; 
% x = [16,9,23,5,21,5,11,19,24,2,28,24,15,13,13,9,15,15,25,24,19,11,25,16,10,29,27,17,19,18];
% y = [6,9,14,7,26,6,7,5,7,13,9,28,13,5,28,30,13,3,8,12,18,8,18,22,6,3,9,9,13,15];


%40 node
% n = 40; 
% x = [3,4,5,6,9,9,6,7,27,21,17,5,6,2,28,21,17,9,5,19,30,5,7,12,2,21,12,30,12,19,4,11,4,23,27,10,21,9,16,25];
% y = [18,10,9,14,13,11,17,23,13,13,3,0,8,9,20,29,29,14,7,23,23,22,23,3,21,14,6,3,25,5,5,20,27,16,21,4,29,16,21,1];

% n = 40; 
% x = [25,23,3,16,10,16,12,12,5,7,0,28,20,28,5,28,24,17,13,7,23,7,1,23,20,22,19,12,12,25,9,25,24,26,15,19,29,13,1,26];
% y = [19,11,30,6,20,18,12,4,0,13,5,22,11,26,22,17,5,29,8,28,6,11,2,19,5,1,22,10,20,11,19,0,28,24,23,25,11,19,17,16];

%50 node
% x = [8,7,14,7,24,30,0,16,2,24,30,2,29,0,21,24,16,27,27,19,4,6,5,1,3,19,29,10,12,30,29,20,30,23,10,20,7,9,21,16,12,18,23,18,17,18,15,2,22,30];
% y = [10,30,10,27,14,12,6,3,9,22,24,21,0,26,28,23,1,11,21,22,6,8,20,14,19,7,5,25,23,28,3,5,3,15,5,27,3,1,17,23,9,5,10,6,15,28,19,3,12,1];

% x = [21,19,17,6,23,7,11,27,26,12,9,18,28,28,18,10,26,13,28,1,16,22,5,10,5,9,12,17,1,17,8,7,7,4,29,29,25,22,5,11,5,0,9,21,19,16,13,8,15,23];
% y = [23,17,23,20,3,15,10,2,4,6,20,13,21,7,0,16,8,29,28,12,0,20,25,30,1,13,18,21,22,20,22,11,18,3,1,30,8,18,29,5,5,10,28,12,8,4,12,11,4,13];

matrix = zeros(n,n);

adj_matrix = zeros(n,n);

node(1,n) = Nodes();
s = [];
t = [];
node(1).E_intial = 100;
node(16).E_intial = 100;

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
    node(i).x = x(i);
    node(i).y = y(i);
    node(i).R = R;
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

    %% Edge weight 
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

% Link quality
    
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
%    
    

%% Phan cap cac node
for i = 1:n
   if(i == 1)
      node(i).hirechical = i;
      node(i).child = i + 1;
   end
   
end

%% Simulation
time_start = 1;
time_end = 500;
sensor_node = [16];

high_energy_threshold = 1.8;
medium_energy_threshold = 0.8;
node_critical_1 = [];
node_critical_2 = [];
index1 = [];
index2 = [];
E1 = [];
E2 = [];

%     for i1 = time_start:time_end  
%             try
%          Energy_total_1 = 0;
%      hirechical(node,n);
%     node_critical_1 = detect_criticalNode(node,n,medium_energy_threshold);
%     Re_routing(node_critical_1,n,node);
% 
% %       MST_global = Re_Prim(node_critical,1,n,node);
%     if(~isempty(node_critical_1) || i == 1 || i == 10 ||i == 20 || i == 30)
%              MST_global_1 = Re_Prim(node_critical_1,1,n,node);
%     end
% 
% %          plot_figure(s, t, x, y, MST_global_1, linkQuality,high_energy_threshold,medium_energy_threshold,node);
%          Check_parent(MST_global_1,node);
%          Energy(x,y,node);
%             for j = 1:length(sensor_node)
%                     Packet_transmission(sensor_node(j),node);
% %                     plot_path(s,t,x,y,sensor_node(j),high_energy_threshold,medium_energy_threshold,node);
%                     Energy(x,y,node);
% %                     pause(1);
%             end
%            disp(i1);
%            index1 = [index1, i1];
%            Energy_total_1 = Energy_residual(node, n);
%            E1 = [E1, Energy_total_1];       
%            disp(Energy_total_1);
%     catch
%         break;
%             end
%     end
%     disp('lan 1');
  
    
       for i2 = time_start:time_end  
     try
         Energy_total_1 = 0;
     hirechical(node,n);
    node_critical_2 = detect_criticalNode(node,n,medium_energy_threshold);
    Re_routing(node_critical_2,n,node);

%       MST_global = Re_Prim(node_critical,1,n,node);
    if(~isempty(node_critical_2) || i == 1 || i == 10 ||i == 20 || i == 30)
             MST_global_2 = Prim_hirechical(node_critical_2,1,n,node);
    end

%          plot_figure(s, t, x, y, MST_global_1, linkQuality,high_energy_threshold,medium_energy_threshold,node);
         Check_parent(MST_global_2,node);
         Energy(x,y,node);
            for j = 1:length(sensor_node)
                    Packet_transmission(sensor_node(j),node);
%                     plot_path(s,t,x,y,sensor_node(j),high_energy_threshold,medium_energy_threshold,node);
                    Energy(x,y,node);
%                     pause(1);
            end
           disp(i2);
           index2 = [index2, i1];
           Energy_total_1 = Energy_residual(node, n);
           E2 = [E2, Energy_total_1];       
           disp(Energy_total_1);
    catch
        break;
            end
    end
    
     disp('lan 2');