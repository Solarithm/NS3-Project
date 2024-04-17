
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
    

%% Simulation
time_start = 1;
time_end = 1000;
sensor_node = [16,11];

high_energy_threshold = 1.8;
medium_energy_threshold = 0.8;
node_critical_1 = [];
index1 = [];
E1 = [];
fileID = fopen('data.txt', 'w');

    for i1 = time_start:time_end  
            try
         Energy_total_1 = 0;
     hirechical(node,n);
    node_critical_1 = detect_criticalNode(node,n,medium_energy_threshold);
    Re_routing(node_critical_1,n,node);

%       MST_global = Re_Prim(node_critical,1,n,node);
    if(~isempty(node_critical_1) || i1 == 1 || mod(i1, 10) == 0)
             MST_global_1 = Re_Prim(node_critical_1,1,n,node);
    end

%          plot_figure(s, t, x, y, MST_global_1, linkQuality,high_energy_threshold,medium_energy_threshold,node);
         Check_parent(MST_global_1,node);
         Energy(x,y,node);
            for j = 1:length(sensor_node)
                    Packet_transmission(sensor_node(j),node);
%                     plot_path(s,t,x,y,sensor_node(j),high_energy_threshold,medium_energy_threshold,node);
                    Energy(x,y,node);
%                     pause(1);
            end
           disp(i1);
           index1 = [index1, i1];
           fprintf(fileID, '%d ', i1);
           Energy_total_1 = Energy_residual(node, n,sensor_node);
           E1 = [E1, Energy_total_1];
           fprintf(fileID, '%d ', Energy_total_1);
           fprintf(fileID, '\n'); % Xu?ng dòng
           disp(Energy_total_1);
            catch
        fclose(fileID);
        break;
            end     
    end
    
    figure(1);
    plot_figure(s, t, x, y, MST_global_1, linkQuality,high_energy_threshold,medium_energy_threshold,node);

    disp('lan 1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Lan 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%% Simulation
time_start = 1;
time_end = 1000;
sensor_node = [16,11];

high_energy_threshold = 1.8;
medium_energy_threshold = 0.8;
node_critical_1 = [];
index1 = [];
E1 = [];
fileID = fopen('data1.txt', 'w');


        for i1 = time_start:time_end  
            try
         Energy_total_1 = 0;
     hirechical(node,n);
    node_critical_1 = detect_criticalNode(node,n,medium_energy_threshold);
    Re_routing(node_critical_1,n,node);

%       MST_global = Re_Prim(node_critical,1,n,node);
    if(~isempty(node_critical_1) || i1 == 1 || mod(i1, 10) == 0)
             MST_global_1 = Prim_hirechical(node_critical_1,1,n,node);
    end

%          plot_figure(s, t, x, y, MST_global_1, linkQuality,high_energy_threshold,medium_energy_threshold,node);
         Check_parent(MST_global_1,node);
         Energy(x,y,node);
            for j = 1:length(sensor_node)
                    Packet_transmission(sensor_node(j),node);
%                     plot_path(s,t,x,y,sensor_node(j),high_energy_threshold,medium_energy_threshold,node);
                    Energy(x,y,node);
%                     pause(1);
            end
           disp(i1);
           index1 = [index1, i1];
           fprintf(fileID, '%d ', i1);
           Energy_total_1 = Energy_residual(node, n,sensor_node);
           E1 = [E1, Energy_total_1];
           fprintf(fileID, '%d ', Energy_total_1);
           fprintf(fileID, '\n'); % Xu?ng dòng
           disp(Energy_total_1);
            catch
        fclose(fileID);
        break;
            end
    end
     disp('lan 2');
           figure(2);
      plot_figure(s, t, x, y, MST_global_1, linkQuality,high_energy_threshold,medium_energy_threshold,node);

     
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% simulation


% M? file ?? ??c
data = fopen('data.txt', 'r');
data1 = fopen('data1.txt', 'r');

E1 = textscan(data, '%*f %f');
E2 = textscan(data1, '%*f %f');

e1 = E1{1};
e2 = E2{1};

% ?óng file
fclose(data);
fclose(data1);

data = fopen('data.txt', 'r');
data1 = fopen('data1.txt', 'r');

% ??c d? li?u t? file
round1 = textscan(data, '%f %*[^\n]');
round2 = textscan(data1, '%f %*[^\n]');

r1 = round1{1};
r2 = round2{1};

% ?óng file
fclose(data);
fclose(data1);

% Hi?n th? d? li?u
round_number = 1:500; % 
energy_number = 1:200; % 

figure(3);

number_round = linspace(0,500);
number_energy = linspace(0,300);

plot(r1,e1);

hold on 
y2 = cos(2*x);
plot(r2,e2)

hold off;
xlabel('number of round');
ylabel('Energy residual');
title('Energy consumption');
legend('Prim Original','Prim Hirechical')
     
   




