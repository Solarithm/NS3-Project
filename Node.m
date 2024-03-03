classdef Nodes
    properties
        x
        y
        neighbor
        distance
        % Energy 
        energyInitial % Năng lượng ban đầu
        energyConsumed % Năng lượng tiêu hao
        energyRemaining % Năng lượng còn lại

    end
    methods
        % Node contructor
        function obj = Nodes(x, y)
            obj.x = x;
            obj.y = y;
            obj.neighbor = [];
            obj.distance = 0;
        end
        function nodes = deleteNode(nodes, index)
            nodes(index) = [];
        end
        function obj = NodeswEnergy(x, y, energyInitial)
            obj.x = x;
            obj.y = y;
            obj.neighbor = [];
            obj.distance = 0;
             % Energy constructor
            obj.energyInitial = energyInitial; % Gán năng lượng ban đầu
            obj.energyConsumed = 0; % Khởi tạo năng lượng tiêu hao là 0
            obj.energyRemaining = energyInitial; % Gán năng lượng còn lại bằng năng lượng ban đầu
        end 
        % Energy consumption
        function consumeEnergy(obj, energy)
            obj.energyConsumed = obj.energyConsumed + energy;
            obj.energyRemaining = obj.energyInitial - obj.energyConsumed;
        end

    end
end



