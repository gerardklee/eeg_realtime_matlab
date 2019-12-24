
figure('position', [100, 100, 800, 2000]);
for i = 2:100
    for c = 1:8
        subplot(8,1,c);
        plot([i-1 i], [output{i-1}(c) output{i}(c)], 'b-'); hold on;
        xlim([0, 1000]);
    end
end

    
    
    