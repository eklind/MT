%----------Parameters----------------%
belt_tension.start=80;
belt_tension.step_size=5;
belt_tension.number=8;

motor_rpm.start=0;
motor_rpm.step_size=150;
motor_rpm.number=10;

load.start=0;
load.step_size=0.5;
load.number=4;

temp.start=-20;
temp.step_size=20;
temp.number=3;

age.start=0;
age.step_size=1;
age.number=2;
%------------------------------------%

a=belt_tension.start:belt_tension.step_size:belt_tension.start+ belt_tension.step_size*belt_tension.number;
b=motor_rpm.start:motor_rpm.step_size:motor_rpm.start+ motor_rpm.step_size*motor_rpm.number;
c=load.start:load.step_size:load.start+ load.step_size*load.number;
d=temp.start:temp.step_size:temp.start+ temp.step_size*temp.number;
e=age.start:age.step_size:age.start+ age.step_size*age.number;

%%
%Create test table
numOfTests=belt_tension.number*motor_rpm.number*load.number*temp.number*age.number;
test_table=zeros(numOfTests,5);

test=1;
for belt_var=1:belt_tension.number
    for motor_rpm_var=1:motor_rpm.number
        for load_var=1:load.number
            for temp_var=1:temp.number
                for age_var=1:age.number
                    test_table(test,1)=a(belt_var);
                    test_table(test,2)=b(motor_rpm_var);
                    test_table(test,3)=c(load_var);
                    test_table(test,4)=d(temp_var);
                    test_table(test,5)=e(age_var); 
                    test=test+1;
                end
            end
        end
    end
end

stop=strcat('A2:E',num2str(numOfTests+1))
xlswrite('test_table.xlsx',{'belt tension','motor rpm','load fan','temperature','age'},'A1:E1');
xlswrite('test_table.xlsx',test_table,stop);