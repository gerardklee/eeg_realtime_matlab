function main()

    % adding paths
    addpath(genpath('/users/gerardlee/desktop/eeg_realtime_matlab/OpenBCI_MATLAB/Matlab-Python/labstreaminglayer'));
    
    % set up default fieldtrip path
    addpath('/users/gerardlee/desktop/eeg_realtime_matlab/fieldtrip');
    ft_defaults

    % instantiate the library
    addpath(genpath('/users/gerardlee/desktop/eeg_realtime_matlab/liblsl-Matlab'));
    disp('loading the library...');
    lib = lsl_loadlib();
    disp('library loaded');
    
    % resolve a stream...
    disp('resolving an EEG stream...');
    result = {};
    error_timer = 15;
    error_tracker = 0;
    while isempty(result)
        if error_tracker == error_timer
            disp('check your connection');
            break
        end
        disp('connecting...');
        result = lsl_resolve_byprop(lib, 'type', 'EEG');
        error_tracker = error_tracker + 1;
    end
    
    if error_tracker == 15
        error('connection failed..');
    end
    
    disp('succesfully connected to openBCI...');
    
    % create a new inlet
    disp('opening an inlet...');
    inlet = lsl_inlet(result{1});  
    
    disp('now receiving data...');   
    disp("graph begins..");
    get_plot(inlet);
end

function get_plot(inlet)
    x_points = [];
    y_points = [];
    figure;
    for i = 1:5000
        disp(i);
        [vec] = inlet.pull_sample();
        data = vec(1, 1);
        
        % pre-allocate the array for speed
        x_temp = zeros(1, length(x_points) + 1);
        y_temp = zeros(1, length(y_points) + 1);
        
        if length(x_temp) == 1
            x_points = x_temp;
            x_points(1, 1) = i;
            y_points = y_temp;
            y_points(1, 1) = data;
            continue;
        end
        
        x_temp = x_points;
        y_temp = y_points;
        x_temp(1, i - 1) = x_points(1, length(x_points));
        y_temp(1, i - 1) = y_points(1, length(y_points));
        x_temp(1, i) = i;
        y_temp(1, i) = data;
        
        x_points = x_temp;
        y_points = y_temp; 
 
    end
    plot(x_points, y_points);
end
    
    
    

    
