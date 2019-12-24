function simulation_test
    a = [1, 2, 3, 4, 5, 6, 7, 8];
    while true
        for i = 1:8
            a(i) = randi([1, 5]);       
        end
        fprintf(' %d', a(1), a(2), a(3), a(4), a(5), a(6), a(7), a(8));
        fprintf('\n');
        break;
    end
    
    
    
