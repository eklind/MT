t=linspace(0,2*pi)
a=sin(t);
b=-2*sin(2*t);


c=[a(1:end) b];

d=fft(b)
e=abs(d)
