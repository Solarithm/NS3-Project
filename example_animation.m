% Define the range of x values
x = linspace(0, 2*pi, 100);

% Create a figure
figure;

% Start a loop for animation
for t = 1:100
    % Generate y values based on time t
    y = sin(x + t/10);
    
    % Plot the data
    plot(x, y);
    
    % Set axis limits
    xlim([0, 4*pi]);
    ylim([-2, 2]);
    
    % Add title and labels
    title('Sine Wave Animation');
    xlabel('x');
    ylabel('sin(x + t)');
    
    % Pause for a short duration to create animation effect
    pause(0.05);
    % If you want to capture frames for a video, you can use getframe function
    % frames(t) = getframe(gcf);
end
