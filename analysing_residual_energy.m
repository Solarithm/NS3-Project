% Read the data from the text file
dataAODV = importdata('dataAODV.tr');
dataEAODV = importdata('dataEAODV.tr');
dataPrim = importdata('dataPrim.tr');
dataEPrim = importdata('dataEPrim.tr');

% Extract time step and residual energy from the data
timeStepAODV = dataAODV(:, 1);
residualEnergyAODV = dataAODV(:, 2);

timeStepEAODV = dataEAODV(:, 1);
residualEnergyEAODV = dataEAODV(:, 2);

timeStepPrim = dataPrim(:, 1);
residualEnergyPrim = dataPrim(:, 2);

timeStepEPrim = dataEPrim(:, 1);
residualEnergyEPrim = dataEPrim(:, 2);

% Plot the data in a new figure
figure; % Create a new figure
hold on; % Hold the current plot
plot(timeStepAODV, residualEnergyAODV, '-', 'DisplayName', 'AODV');
plot(timeStepEAODV, residualEnergyEAODV, '-', 'DisplayName', 'EAODV');
plot(timeStepPrim, residualEnergyPrim, '-', 'DisplayName', 'Prim');
plot(timeStepEPrim, residualEnergyEPrim, '-', 'DisplayName', 'EPrim');
hold off; % Release the hold
xlabel('Lifetime');
ylabel('Residual Energy');
title('Residual Energy vs. Lifetime');
grid on;
legend('Location', 'best');
