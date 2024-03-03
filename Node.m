    classdef Node
        properties
            x
            y
            neighbor
            distance
            eI
            eC
            eR
        end
        methods
            % Node contructor
            function obj = NodeUnEnergy(x, y)
                obj.x = x;
                obj.y = y;
                obj.neighbor = [];
                obj.distance = 0;
            end
            function obj = Node(x, y)
                obj.x = x;
                obj.y = y;
                obj.neighbor = [];
                obj.distance = 0;
                 % Energy constructor
                obj.eI = 100;
                obj.eC = 0; 
                obj.eR = 100;
            end 
        end
    end



