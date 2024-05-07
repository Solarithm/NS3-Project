% Read the data from the text files
dataAODV = importdata('dataAODV.tr');
dataEAODV = importdata('dataEAODV.tr');
dataPrim = importdata('dataPrim.tr');
dataEPrim = importdata('dataEPrim.tr');
dataDSDV = importdata('dataDSDV.tr');
dataEDSDV = importdata('dataEDSDV.tr');
%Extract data
timeStepAODV = dataAODV(:, 1);
consumptEnergyAODV = dataAODV(:, 3);
timeStepEAODV = dataEAODV(:, 1);
consumptEnergyEAODV = dataEAODV(:, 3);
timeStepPrim = dataPrim(:, 1);
consumptEnergyPrim = dataPrim(:, 3);
timeStepEPrim = dataEPrim(:, 1);
consumptEnergyEPrim = dataEPrim(:, 3);
timeStepDSDV = dataDSDV(:, 1);
consumptEnergyDSDV = dataDSDV(:, 3);
timeStepEDSDV = dataEDSDV(:, 1);
consumptEnergyEDSDV = dataEDSDV(:, 3);
% ??t các m?ng time step cu?i cùng
timeAODV = timeStepAODV(end);
timeEAODV = timeStepEAODV(end);
timePrim = timeStepPrim(end);
timeEPrim = timeStepEPrim(end);
timeDSDV = timeStepDSDV(end);
timeEDSDV = timeStepEDSDV(end);

consEnergyAODV = consumptEnergyAODV(end);
consEnergyEAODV = consumptEnergyEAODV(end);
consEnergyPrim = consumptEnergyPrim(end);
consEnergyEPrim = consumptEnergyEPrim(end);
consEnergyDSDV = consumptEnergyDSDV(end);
consEnergyEDSDV = consumptEnergyEDSDV(end);

protocols = {'AODV', 'EAODV', 'DSDV', 'EDSDV', 'Prim', 'EPrim'};
num_protocols = numel(protocols);
% Create a matrix of colors with each row representing a fixed color for each protocol
colors = [
    0.9290, 0.6940, 0.1250; % Yellow color for AODV
    0.4940, 0.1840, 0.5560; % Purple color for EAODV
    0.4660, 0.6740, 0.1880; % Green color for DSDV
    0.3010, 0.7450, 0.9330; % Sky blue color for EDSDV
    0.6350, 0.0780, 0.1840; % Red color for Prim
    0.8500, 0.3250, 0.0980  % Orange color for EPrim
];

figure; 
b1 = bar([timeAODV, timeEAODV, timeDSDV, timeEDSDV, timePrim, timeEPrim], 'stacked', 'facecolor', 'flat');
b1.CData = colors;
xlabel('Routing Protocols');
ylabel('Rounds');
title('Lifetime');
xticks(1:num_protocols);
xticklabels(protocols);
colormap(colors); % Use the created color matrix

figure; 
b2 = bar([consEnergyAODV, consEnergyEAODV, consEnergyDSDV, consEnergyEDSDV, consEnergyPrim, consEnergyEPrim], 'stacked', 'facecolor', 'flat');
b2.CData = colors;
xlabel('Routing Protocols');
ylabel('Consumed Energy');
title('Consumed Energy On Network Of Each Routing Protocols');
xticks(1:num_protocols);
xticklabels(protocols);
colormap(colors); % Use the created color matrix






