function new_name = name_save(data_struct)
% Takes a data structure and saves it with a unique name

w=data_struct.Nom_motor_RPM;
tension=floor((data_struct.Nom_Tension_motor+data_struct.Nom_Tension_comp)/2);
current = data_struct.Motor_current;

name=string(w)+'_'+string(tension)+'_'+string(current);

load("experiment_names.mat",'namevect')

n=size(namevect,1);
num_in_line= n+1;
name=string(num_in_line)+'_'+name;
namevect=[namevect;name];   
    

save("experiment_names.mat",'namevect');
data_struct.name=name;

new_name="T"+name;
assignin('caller',new_name,data_struct);


end