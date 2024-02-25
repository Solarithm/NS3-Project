% Đọc dữ liệu từ file test_Node
load('test_Node.mat');

% Tính toán chỉ số độ trung tâm giữa
bc = betweenness_centrality(adjacencyMatrix);

% Chọn ngưỡng để xác định backbone
threshold = 0.2; % Điều chỉnh ngưỡng tùy theo nhu cầu

% Xác định các nút thuộc backbone dựa trên chỉ số độ trung tâm giữa
backboneNodes = find(bc >= threshold);

% Hiển thị các nút thuộc backbone
disp('Backbone Nodes:');
disp(backboneNodes);

% Vẽ đồ thị của backbone mạng
G = graph(adjacencyMatrix);
plot(G, 'Layout', 'force', 'MarkerSize', 10, 'NodeColor', 'r', 'EdgeColor', 'k', 'EdgeAlpha', 0.5);
title('Backbone Network Graph');
xlabel('X');
ylabel('Y');

% Đánh dấu các nút thuộc backbone trên đồ thị
hold on;
highlight(G, backboneNodes, 'NodeColor', 'g', 'MarkerSize', 15);
