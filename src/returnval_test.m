function returnval_test
    [a, w] = get_area(5);
    fprintf('area = %d\twidth = %d\n', a, w);
    [max, min] = try_decimal;
    fprintf('max = %.2f, min = %.3f\n', max, min);
end

function [area, width] = get_area(height)
    width = 9;
    area = width * height;
end

function[max, min] =  try_decimal
    max = 9
    min = 2
end


    