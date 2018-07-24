function Load= Load_Factor(struct)

Suction=struct.LF.Compressor_Suction_Pressure;
Discharge=struct.LF.Compressor_Discharge_Pressure;

Ratio=(Discharge+14.7)./(Suction+14.7);

%Load=Ratio;
Load=Ratio.*struct.LF.Comp_Vector;
end