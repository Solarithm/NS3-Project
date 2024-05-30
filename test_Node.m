    
% Simulation - energy
% 
% Ch?y file main th? nh?t

run('D:\DATN\mathlab\NS3-Project\Main_PrimOriginal');

run('D:\DATN\mathlab\NS3-Project\Main_PrimHierarchical');

% Ch?y file main th? hai



% Mo file
data = importdata('data.txt');
data1 = importdata('data1.txt');

round_number_1 = data(:, 1);
energy_residual_1 = data(:, 2);
energy_consumption_1 = data(:, 3);

round_number_2 = data1(:, 1);
energy_residual_2 = data1(:, 2);
energy_consumption_2 = data1(:, 3);

figure(3);

plot(round_number_1,energy_residual_1);

hold on 
plot(round_number_2,energy_residual_2)

hold off;
grid on;
xlabel('Number of round');
ylabel('Energy residual (J)');
title('Energy residual in network');
legend('Prim Original','Prim Hirechical')

f3 = figure(3);

saveas(f3,'Energy-residual-16-nodes.png')

figure(4);

plot(round_number_1,energy_consumption_1);

hold on 
plot(round_number_2,energy_consumption_2)

hold off;
grid on;
xlabel('Number of round');
ylabel('Energy consumption (J)');
title('Energy consumption in network');
legend('Prim Original','Prim Hirechical')

f4 = figure(4);
saveas(f4,'Energy-consumption-16-nodes.png')     


   




