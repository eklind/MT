function new_name = name_save(data_struct)
% Takes a data structure and saves it with a unique name

% === Extract the run parameters from the structure ============
w=data_struct.Nom_motor_RPM;
tension=floor((data_struct.Nom_Tension_motor+data_struct.Nom_Tension_comp)/2);
current = data_struct.Motor_current;

% === Creates the new name based on run parameters =======
name=string(w)+'_'+string(tension)+'_'+string(current);

% === Load the vector with used names ====
load("experiment_names.mat",'namevect')

% === Count the previous tests and adds one ===
n=size(namevect,1);
num_in_line= n+1;
name=string(num_in_line)+'_'+name;

% == Add 'T' to name to make it a legal struct field name
new_name="T"+name;

% === Add the new name as a field
data_struct.name=new_name;

% == Change the variable name of the data structure to the new name
assignin('caller',new_name,data_struct);

% Save the name when everything is done
namevect=[namevect;name];   
save("experiment_names.mat",'namevect');

end