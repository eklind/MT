function data_structure = make_data_struct(filepath) 
% Input the filepath to an excel file outputed from the DAQ system,
% returns a data structure with all the measurements.



    % ====== Ask user for experiment specific parameters ============
    params = {'Enter nominal motor speed','Enter nominal belt tension on motor side',...
        'Enter nominal belt tension on compressoe side','Enter steady state motor current',...
        'Enter ambient temperature','Other comments','Save name and data structure? y/n'};

    % Gui for parameter input
    dim1=[1 50];
    deaf_param = {'1','1','1','1','1',' ','n'};
    run_param = inputdlg(params,'Enter Run Parameters',dim1,deaf_param);
    nom_vel = str2double(run_param{1});
    nom_ten_motor = str2double(run_param{2});
    nom_ten_comp = str2double(run_param{3});
    motor_current = str2double(run_param{4})*10;
    amb_temp = str2double(run_param{5});
    comments = run_param{6};
    save_opt = run_param{7};



    %=========== Create the top level data structure ==============
    data_structure = struct('Nom_motor_RPM',nom_vel,'Nom_Tension_motor',nom_ten_motor,...
        'Nom_Tension_comp',nom_ten_comp,'Motor_current',motor_current,...
        'Ambient_Temp',amb_temp,'Comments',comments);

        % file_name = 'data_struct_table.xlsx';
    % filename = 'C:\Users\Viktor\Desktop\Shakedown1.xlsx';
    
 % ====== If a filepath is passed as argument, it loads an .xlsx file   
    
if(nargin>=1)
    %====== Load raw data from tab 3 and 4 in file 'filename' =========
    [~,lf_sensors,~] = xlsread(filepath,4,'A1:Z1');
    [~,hf_sensors,~] = xlsread(filepath,5,'A1:Z1');
    n_lf_sensors=size(lf_sensors(1,:));
    n_hf_sensors=size(hf_sensors(1,:)); 

    [lf_data,~,~] = xlsread(filepath,4);
    [hf_data,~,~] = xlsread(filepath,5);
    
    % ========= Create two data structures, for high and low speed sampling.
    % Calculate sample frequencies
    low_freq = 1/mean(diff(lf_data(:,1)));
    high_freq = 1/mean(diff(hf_data(:,1)));
    LF = struct('Sampling_Rate_Hz',low_freq);
    HF = struct('Sampling_Rate_Hz',high_freq);


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
   
    % ===== If no input arguments, tdms-file has to be chosen  ======
else     
     tdms_data = TDMS_getStruct();
     %remove temperature offsets
     tdms_data = calibrate_temps(tdms_data);
     
     lf_data_struct = struct2cell(tdms_data.g_1Hz_Data);
     hf_data_struct = struct2cell(tdms_data);%s2
     hf_data_struct = hf_data_struct{3}; 
     hf_data_struct = struct2cell(hf_data_struct);
     
     low_freq = 1/mean(diff(tdms_data.g_1Hz_Data.Time__sec_.data));
     high_freq = 1/mean(diff(hf_data_struct{3}.data));
     
     LF = struct('Sampling_Rate_Hz',low_freq);
     HF = struct('Sampling_Rate_Hz',high_freq);
     for i=3:length(lf_data_struct(:,1))
        name = lf_data_struct{i}.name;
        LF = setfield(LF,name,lf_data_struct{i}.data);
     end
     
     for j=3:length(hf_data_struct(:,1))
        name = hf_data_struct{j}.name;
        HF = setfield(HF,name,hf_data_struct{j}.data);
     end
     
%      HF = setfield(HF,'Time__sec_',...
%          hf_data_struct.Time__sec_.data);
%      HF = setfield(HF,'Belt_Displacement',...
%          hf_data_struct.Belt_Displacement.data);
%      HF = setfield(HF,'Accelerometer_X',...
%          hf_data_struct.Accelerometer_X_Axis.data);
%      HF = setfield(HF,'Accelerometer_Y',...
%          hf_data_struct.Accelerometer_Y_Axis.data);
%      HF = setfield(HF,'Accelerometer_Z',...
%          hf_data_struct.Accelerometer_Z_Axis.data);
     
    
end
    
    
% === Concatenate the three structs into one ==================== 
    data_structure.LF=LF;
    data_structure.HF=HF;

% ==== Return and save the data structure ============

if (save_opt == 'y')
    name=name_save(data_structure);
    save("Experiments/"+name+".mat",name);
    disp("Data Structure Saved as "+name); 
else
    disp("Data Structure NOT saved!")
end

end