function main

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
    
    % run to print each value of the stream
    inlet_tracker = 0;
    while true
        if inlet_tracker == 20
            break
        end
        
        % get data from the inlet
        [vec, ts] = inlet.pull_sample();
        
        % display the data
        fprintf('%.2f\t', vec);
        fprintf('%.5f\n', ts);
        
        % store [vec, ts] into variable and print its size for check
        matrix = [vec, ts];
        disp('size of the matix printing..');
        disp(size(matrix));
        inlet_tracker = inlet_tracker + 1;
    end
    
    
    
    

        
    
    
    

    
