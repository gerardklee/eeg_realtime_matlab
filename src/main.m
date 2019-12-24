function output = main()

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
    error_tracker = 0;
    while isempty(result)
        if error_tracker == 15
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
    
    output = {};
    

    figure('position', [100, 100, 800, 2000]);
    i = 1;    
    % run to print each value of the stream
    while true
        % get data from the inlet
        [vec, ts] = inlet.pull_sample();
        
        % display the data
        fprintf('%.2f\t', vec);
        fprintf('%.5f\n', ts);
        
        % store [vec, ts] into variable and print its size for check
        % size comes out 1 row and 9 columns every iteration
        % so, the values are being replaced every iteration
        matrix = [vec, ts];
        output{i} = matrix;
        if i > 2
            for c = 1:8
                subplot(8,1,c);
                plot([i-1 i], [output{i-1}(c); output{i}(c)], 'b-'); hold on;
                xlim([max([0, i - 1000]), max([1000, i])]);
            end
        end
        i = i + 1;
    end
    
    
    
    

        
    
    
    

    
