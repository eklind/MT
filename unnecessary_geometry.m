in_to_m=2.56/100;

d_m=(17+(5/16))*in_to_m;
d_c=(12+(7/16))*in_to_m;

addon=0.25;
h_t=0.070+addon;
%dt=linspace(0,0.05); %0 to 0.05;
dt=0.025;
h_m=0.234;
h_c=0.227;

alpha=asin(sind(90)*(h_t+dt-h_m)/d_m);
beta=asin(sind(90)*(h_t+dt-h_c)/d_c);

x_m=cos(alpha)*d_m;
x_c=cos(beta)*d_c;
D=x_m+x_c;

%%
plot(dt,D)
hold on
plot(dt,alpha)
plot(dt,beta)

legend('distance','angle motor alpha','angle compressor beta');

%%
clf
hold on
plot(0,h_m,'o','markersize',10)
plot(x_m,h_t+dt,'o','markersize',10)
plot(x_m,h_t+2*dt,'*b','markersize',10)
plot(x_m,h_t,'b*','markersize',10)
plot(D,h_c,'o','markersize',10)
axis equal
hold off

alpha*180/pi
beta*180/pi