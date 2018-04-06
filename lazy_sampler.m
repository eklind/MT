function [time_vector] = lazy_sampler(data,fs)
    % data is a 1D sampled data vector, fs is the used sample frequency.
    % Returns the time vector assoicated with the sample data, sample
    % time period
    
    n = length(data);
    sample_period = 1/fs;
    end_time = n*sample_period-sample_period;
    time_vector = 0:sample_period:end_time;
end
