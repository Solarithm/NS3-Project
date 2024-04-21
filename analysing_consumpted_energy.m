% Read the data from the text files
dataAODV = importdata('dataAODV.tr');
dataEAODV = importdata('dataEAODV.tr');
dataPrim = importdata('dataPrim.tr');
dataEPrim = importdata('dataEPrim.tr');
dataDSDV = importdata('dataDSDV.tr');
dataEDSDV = importdata('dataEDSDV.tr');
% Extract time step and residual energy from the data
timeStepAODV = dataAODV(:, 1);
residualEnergyAODV = dataAODV(:, 3);

timeStepEAODV = dataEAODV(:, 1);
residualEnergyEAODV = dataEAODV(:, 3);

timeStepPrim = dataPrim(:, 1);
residualEnergyPrim = dataPrim(:, 3);

timeStepEPrim = dataEPrim(:, 1);
residualEnergyEPrim = dataEPrim(:, 3);

timeStepDSDV = dataDSDV(:, 1);
residualEnergyDSDV = dataDSDV(:, 3);

timeStepEDSDV = dataEDSDV(:, 1);
residualEnergyEDSDV = dataEDSDV(:, 3);
% Plot the data in a new figure
figure; % Create a new figure
hold on; % Hold the current plot
plot(timeStepAODV, residualEnergyAODV, '-', 'LineWidth', 2, 'DisplayName', 'AODV');
plot(timeStepEAODV, residualEnergyEAODV, '-', 'LineWidth', 2, 'DisplayName', 'EAODV');
plot(timeStepDSDV, residualEnergyDSDV, '-', 'LineWidth', 2, 'DisplayName', 'DSDV');
plot(timeStepEDSDV, residualEnergyEDSDV, '-', 'LineWidth', 2, 'DisplayName', 'EDSDV');
plot(timeStepPrim, residualEnergyPrim, '-', 'LineWidth', 2, 'DisplayName', 'Prim');
plot(timeStepEPrim, residualEnergyEPrim, '-', 'LineWidth', 2, 'DisplayName', 'EPrim');

hold off; % Release the hold
xlabel('Lifetime');
ylabel('Consumpted Energy');
title('Consumpted Energy vs. Lifetime');
grid on;
legend('Location', 'best');
