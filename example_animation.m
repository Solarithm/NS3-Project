% Tạo GUI
fig = uifigure('Name', 'Thông số', 'Position', [100 100 300 200]);

% Tạo một đối tượng Static Text
txt = uilabel(fig, 'Position', [20 150 300 30], 'Text', 'Dữ liệu:');

% Tạo một biến để lưu trữ dữ liệu
data = 0;

% Cập nhật dữ liệu và hiển thị trên giao diện
for i = 1:10
    % Giả định bạn có một hàm hoặc quy trình để cập nhật dữ liệu
    data = data + rand();
    
    % Cập nhật nội dung của đối tượng Static Text
    txt.Text = sprintf('Dữ liệu: %.2f', data);
    
    % Dừng một chút để quan sát
    pause(1);
end
