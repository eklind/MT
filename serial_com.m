
connected_port = seriallist;
COM_port = connected_port.cellstr{1};
%create serial object
s = serial(COM_port); 
set(s,'BaudRate',115200);

%Open the connection
fopen(s);

%% write to device 
%fprintf(s,'*IDN?.')
fprintf(s,'D.') %ascii
%fprintf(s,'N.') %binary
%%
% read from device
out = fscanf(s,'%d',3)
out2=fread(s,3)

%%
% Disconnect and clean up
%fclose(s)
%delete(s)
%clear s
%clear all