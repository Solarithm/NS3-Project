classdef PriorityQueue < handle
    properties
        elements
        priorities
        count
    end
    
    methods
        function obj = PriorityQueue()
            obj.elements = {};
            obj.priorities = [];
            obj.count = 0;
        end
        
        function insert(obj, element, priority)
            obj.count = obj.count + 1;
            obj.elements{obj.count} = element;
            obj.priorities(obj.count) = priority;
        end
        
        function element = pop(obj)
            [~, index] = min(obj.priorities);
            element = obj.elements{index};
            obj.elements(index) = [];
            obj.priorities(index) = [];
            obj.count = obj.count - 1;
        end
        
        function isEmpty = isEmpty(obj)
            isEmpty = obj.count == 0;
        end
    end
end
