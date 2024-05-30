      
    data = fopen('data.txt', 'r');
    data1 = fopen('data1.txt', 'r');
    
    
    E1 = textscan(data, '%*f %f');
    E2 = textscan(data1, '%*f %f');
    
    e1 = E1{1};
    e2 = E2{1};
    
    Std_1 = std(e1);
    Std_2 = std(e2);

