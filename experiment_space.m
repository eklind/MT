function position = experiment_space(nom_speed, tension1, tension2, motor_current)
    % Takes in the nominal motor speed used in the experiment, the measured
    % tension on motor side and compressor side and the compressor load.
    % Returns an operation point in the experimet space.

    %check if the textfile exist, otherwise create a new file with initial
    %zeros in the begining.
    if (exist('experiment_space_file.txt')~=2)
        disp('"experiment_space_file" dont exist, creating a new file...')
        newFile=fopen('experiment_space_file.txt','a');
        fprintf(newFile,'%i %i %i %i\n',[0 0 0 0]);
        fclose(newFile);
    end

    rpm_range=[0 2000]; %[RPM] x
    tension_range=[50 250]; %[lbs] y
    load_range=[0 30];  %[Amps] z


    average_tension=(tension1+tension2)/2;

    % Calculate the relative values
    % speed
    rel_rpm_range=rpm_range-rpm_range(1);
    rel_speed=(nom_speed-rpm_range(1))/(rel_rpm_range(2)-rel_rpm_range(1));
    rel_speed = ceil(rel_speed *100);
    %tension
    rel_tension_range=tension_range-tension_range(1);
    rel_tension=(average_tension-tension_range(1))/(rel_tension_range(2)-rel_tension_range(1));
    rel_tension = ceil(rel_tension *100);
    %load
    rel_load_range=load_range-load_range(1);
    rel_load=(motor_current-load_range(1))/(rel_load_range(2)-rel_load_range(1));
    rel_load = ceil(rel_load *100);



    %the final position in x,y,z
    position = [rel_speed rel_tension rel_load 1];

    old_space = dlmread('experiment_space_file.txt');

    % Se if the current op-point is used before
    [LIA,LOCB]=ismember(old_space(:,1:3),position(1:3),'rows');
    [~,indx]=max(LOCB);
    % If it is used, increment the number of occurences for that point
    % otherwise append the new point
    if sum(LIA)
        old_space(indx,4)=old_space(indx,4)+1;
        new_space = old_space;
    else
        new_space = [old_space; position];
    end

    dlmwrite('experiment_space_file.txt',new_space);

    position = position(1:3);
end