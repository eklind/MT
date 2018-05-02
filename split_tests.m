% Load test i
function output_struct=split_tests(input_struct,steady_state_time,test_time,stop_time,deadzone)

%steady_state_time=1*60;
%test_time=0.5*60;
%stop_time=18.5*60;
t_start=steady_state_time+deadzone+1:test_time:stop_time+1;
t_stop=steady_state_time-deadzone+test_time:test_time:stop_time-deadzone;
t=[t_start;t_stop];

for i=1:size(t,2)
   test=num2str(i);
   test=strcat('Test',test);
   if(t_stop(i)<=length(input_struct.LF.Time))
        output_struct.(test)=cut_struct(input_struct,t_start(i),t_stop(i)); 
   else
       output_struct.junk=cut_struct(input_struct,t_start(i),length(input_struct.LF.Time));
   end
end