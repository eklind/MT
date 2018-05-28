function data_structure = make_data_struct(filepath,tension) 
% Input the filepath to an excel file outputed from the DAQ system,
% returns a data structure with all the measurements.



    % ====== Ask user for experiment specific parameters ============
    params = {'Enter nominal motor speed','Enter nominal belt tension on motor side',...
        'Enter nominal belt tension on compressoe side','Enter steady state motor current',...
        'Enter ambient temperature','Other comments','Save name and data structure? y/n'};

    % Gui for parameter input
    dim1=[1 50];

    if(nargin>=2)
        run_param = {'1',tension,'1','1','1',' ','n'};
    else
        deaf_param = {'1','1','1','1','1',' ','n'};
        run_param = inputdlg(params,'Enter Run Parameters',dim1,deaf_param);
    end
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
    % ===== If a file path is specified
    try
        tdms_data = TDMS_getStruct(filepath);
    catch disp('Error while loading, CHECK YOU FUCKING CODE AGAIN!')
        data_structure.comments = 'EMPTY';
        return
    end
else
    % ===== If no input arguments, tdms-file has to be chosen  ======
   try
        tdms_data = TDMS_getStruct();
    catch disp('Error while loading, CHECK YOU FUCKING CODE AGAIN')
        data_structure.comments = 'EMPTY';
        return
    end
end  
     
     
     %remove temperature offsets
%      tdms_data = calibrate_temps(tdms_data);
     
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
     LF.Time__sec_=LF.Time__sec_-LF.Time__sec_(1);
     
     for j=3:length(hf_data_struct(:,1))
        name = hf_data_struct{j}.name;
        HF = setfield(HF,name,hf_data_struct{j}.data);
     end
     
    
    
% === Concatenate the three structs into one ==================== 
    data_structure.LF=LF;
    data_structure.HF=HF;
    
% === Perform filtering on the raw data ==============
data_structure = data_filt(data_structure);


% === Find Compressor status ========== 
P=data_structure.LF.Compressor_Discharge_Pressure;
dP=diff(movmean(P,5));
VFDi=data_structure.LF.VFD_Current_Output;
dP_pos = dP>0;

j=1;
Alternator=true;
for i=1:length(dP_pos)-5  
    if ((dP_pos(i)==1)&&(VFDi(i+5)>18))&&Alternator
        C_status(:,j)=[1;data_structure.LF.Time__sec_(i)];
        j=j+1;
        Alternator = false;
    elseif((dP_pos(i)==0)&&(VFDi(i+3)<15))&&~(Alternator)
        C_status(:,j)=[0;data_structure.LF.Time__sec_(i)];
        j=j+1;
        Alternator=true;
    end
end
data_structure.LF.Comp_Status=C_status;

% ==== Return and save the data structure ============

if (save_opt == 'y')
    name=name_save(data_structure);
    save("Experiments/"+name+".mat",name);
    disp("Data Structure Saved as "+name); 
else
    disp("Data Structure NOT saved!")
end

end
