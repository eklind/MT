
connected_port = seriallist;
COM_port = connected_port.cellstr{1};
%create serial object
s = serial(COM_port); 
set(s,'BaudRate',4800);

%Open the connection
fopen(s);

% write to device 
%fprintf(s,'*IDN?')


%%
% read from device
out = fscanf(s,'%d',10)

%%
% Disconnect and clean up
fclose(s)
delete(s)
clear s