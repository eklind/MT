function score=Efficiency(struct)
    fs=struct.LF.Sampling_Rate_Hz;
    comp_vec=Compressor_Status(struct,fs);
    if(sum(comp_vec==0)>30 && sum(comp_vec==1)>30)
        v_comp_on=struct.LF.Comp_RPM(comp_vec==1);
        v_comp_off=struct.LF.Comp_RPM(comp_vec==0);
        v_drive_on=struct.LF.Drive_RPM(comp_vec==1);
        v_drive_off=struct.LF.Drive_RPM(comp_vec==0)
        
        ratio1=v_comp_on(v_drive_on>750)./v_drive_on(v_drive_on>750);
        ratio2=v_comp_off(v_drive_off>750)./v_drive_off(v_drive_off>750);
        score=100*nanmedian(ratio1)/nanmedian(ratio2);
    else
        score=0;
    end
end