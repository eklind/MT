function score=Efficiency(struct)
    fs=struct.LF.Sampling_Rate_Hz;
    comp_vec=Compressor_Status(struct,fs);
    if(sum(comp_vec==0)>10 && sum(comp_vec==1)>10)
        ratio1=struct.LF.Comp_RPM(comp_vec==1)./struct.LF.Drive_RPM(comp_vec==1);
        ratio2=struct.LF.Comp_RPM(comp_vec==0)./struct.LF.Drive_RPM(comp_vec==0);
        score=100*nanmedian(ratio1)/nanmedian(ratio2);
    else
        score=0;
    end
end