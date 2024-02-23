% Define node positions
x = [0 1.5 3.5 7 3.5 6.5 7.5 5 9.5 10];
y = [5 4.5 4 6 7 2.5 4.5 5 5 5.5];

% Plot nodes
scatter(x, y, 'filled');
hold on;
text(x, y, cellstr(num2str((1:numel(x))')), 'VerticalAlignment','bottom', 'HorizontalAlignment','right'); % Label nodes
xlabel('X');
ylabel('Y');
title('Nodes with Positions');
grid on;

% Iterate over all pairs of nodes
for i = 1:numel(x)
    for j = 1:numel(x)
        if i ~= j % Avoid connecting a node to itself
            % Calculate distance between nodes i and j
            distance = sqrt((x(i) - x(j))^2 + (y(i) - y(j))^2);

            % If distance is smaller than 1.5, draw a line to represent the connection
            if distance < 1.5
                line([x(i) x(j)], [y(i) y(j)], 'Color', 'b');
            end
        end
    end
end
