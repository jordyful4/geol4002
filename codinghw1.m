clear

% Load the data
fid=fopen('C:\Users\jojo1\OneDrive\Desktop\LSU classes\geol 4002 spr26\P403.NA.tenv3.txt');
    C=textscan(fid,'%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','headerlines',1);
    fclose(fid);

%parse the data
t=C{3};
x=C{9};
y=C{11};
e=C{13};

% Plot the data
figure(1)
title('Time vs Lat Change')
clf
plot(t,x,'.')
P=polyfit(t,x,1);
vx=P(1)*1000 %converts from m/y to mm/y
xline=polyval(P,t);
hold on
plot(t,xline)
hold off

figure (2)
title('Time vs Long Change')
clf
plot(t,y,'.')
P2=polyfit(t,y,1);
vy=P2(1)*1000
yline=polyval(P2,t);
hold on
plot(t,yline)
hold off

figure (3)
clf
plot(t,e,'.')
P3=polyfit(t,e,1);
ve=P3(1)*1000
eline=polyval(P3,t);
hold on
plot(t,eline)
hold off

%fit a line to the data




%plot line on existing figure




%calculate residuals
xresidual=x-xline;
yresidual=y-yline;
eresidual=e-eline;

%plot residuals
figure (4)
subplot(3,1,1)
plot(t,xresidual,'.')

subplot(3,1,2)
plot(t,yresidual,'.')

subplot(3,1,3)
plot(t,eresidual,'.')
