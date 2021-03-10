%% instantiate the library
disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
disp('Resolving an EMG stream...');
result = {};
while isempty(result)
    result = lsl_resolve_byprop(lib,'type','EMG'); end

% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

disp('Now receiving data...');
    livedata=0;
    timest=0;
    t0=0;
    
while true
    pause(0.1);
    % get data from the inlet
    [vec,ts] = inlet.pull_sample();
    % and display it
    fprintf('%.2f\t',vec);
    if(t0==0)
        t0=ts;
    end
    fprintf('%.5f\n',ts-t0); 
    
    y=vec;
    fprintf('\n');
    fprintf('%.2f\t',y);
    fprintf('\n');
    if(livedata==0)
        livedata=y;
    end
    livedata=[livedata;y];
    if(timest==0)
        timest=ts-t0;
    end
    timest=[timest ts-t0];
%    plot(timest,livedata);
%    pause(0.5);
end