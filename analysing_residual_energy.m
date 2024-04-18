% Read the data from the text file
data = importdata('dataAODV.tr');

% Extract time step and residual energy from the data
timeStep = data(:, 1);
residualEnergy = data(:, 2);

% Plot the data
plot(timeStep, residualEnergy, '-');
xlabel('Time Step');
ylabel('Residual Energy');
title('Residual Energy vs. Time Step');
grid on;
