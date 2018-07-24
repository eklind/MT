function Comp_Status_Vector =Compressor_Status(data_struct,fs)

A=data_struct.LF.Comp_Status;
A(2,:)=A(2,:)*fs;
for i=2:size(A,2)
    value=A(1,i-1);
    time=A(2,i);
    prev_time=A(2,i-1);
   if value==1
       B(prev_time+1:time)=1;
   else
       B(prev_time+1:time-1)=0;
   end
end
value=A(1,end);
time=A(2,end);
if value==1
   B(time+1:data_struct.LF.Time__sec_(end)*fs+1)=1;
else
   B(time+1:data_struct.LF.Time__sec_(end)*fs+1)=0;
end
Comp_Status_Vector=B>0;
end