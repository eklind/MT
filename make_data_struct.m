function data_structure = make_data_struct(filepath) 
% Input the filepath to an excel file outputed from the DAQ system,
% returns a data structure with all the measurements.


    % file_name = 'data_struct_table.xlsx';
    % filename = 'C:\Users\Viktor\Desktop\Shakedown1.xlsx';

    %====== Load raw data from tab 3 and 4 in file 'filename' =========
    [~,lf_sensors,~] = xlsread(filepath,4,'A1:Z1');
    [~,hf_sensors,~] = xlsread(filepath,5,'A1:Z1');
    n_lf_sensors=size(lf_sensors(1,:));
    n_hf_sensors=size(hf_sensors(1,:));

    [lf_data,~,~] = xlsread(filepath,4);
    [hf_data,~,~] = xlsread(filepath,5);

    % ====== Ask user for experiment specific parameters ============
    params = {'Enter nominal motor speed','Enter nominal belt tension on motor side',...
        'Enter nominal belt tension on compressoe side','Enter steady state motor current',...
        'Enter ambient temperature','Other comments'};

    % Gui for parameter input
    dim1=[1 50];
    run_param = inputdlg(params,'Enter Run Parameters',dim1);
    nom_vel = str2double(run_param{1});
    nom_ten_motor = str2double(run_param{2});
    nom_ten_comp = str2double(run_param{3});
    motor_current = str2double(run_param{4});
    amb_temp = str2double(run_param{5});
    comments = run_param{6};



    %=========== Create the top level data structure ==============
    OP1 = struct('Nom_motor_RPM',nom_vel,'Nom_Tension_motor',nom_ten_motor,...
        'Nom_Tension_comp',nom_ten_comp,'Motor_current',motor_current,...
        'Ambient_Temp',amb_temp,'Comments',comments);


    % ========= Create two data structures, for high and low speed sampling.
    % Calculate sample frequencies
    low_freq = 1/mean(diff(lf_data(:,1)));
    high_freq = 1/mean(diff(hf_data(:,1)));
    LF = struct('Sampling_Rate',low_freq);
    HF = struct('Sampling_Rate',high_freq);


    % ========= Format input data to fit with a struct ================
    str_lf = string(lf_sensors);
    str_lf = deblank(str_lf);
    str_lf = replace(str_lf,' ','_');
    str_lf = replace(str_lf,'(','');
    str_lf = replace(str_lf,')','');

    str_hf = string(hf_sensors);
    str_hf = deblank(str_hf);
    str_hf = replace(str_hf,' ','_');
    str_hf = replace(str_hf,'(','');
    str_hf = replace(str_hf,')','');


% === Assign values to the correspondning sensor name in the struct =====

    for i=1:n_lf_sensors(2)
        LF = setfield(LF,str_lf{i},lf_data(:,i));
    end

    for j=1:n_hf_sensors(2)
        HF = setfield(HF,str_hf{j},hf_data(:,j));
    end

% === Concatenate the three structs into one ==================== 
    OP1.LF=LF;
    OP1.HF=HF;

% ==== Return the data structure ============
data_structure = OP1;
end