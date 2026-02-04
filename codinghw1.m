clear
%Load and parse the map data
%--Coastline
fid=fopen('C:\Users\jojo1\OneDrive\Desktop\LSU classes\geol 4002 spr26\coastfile.xy');
    coast_data=textscan(fid,'%f %f','headerlines',0);
    fclose(fid);

    coast_lon=coast_data{1};
    coast_lat=coast_data{2};
    
%--Borders
fid=fopen('C:\Users\jojo1\OneDrive\Desktop\LSU classes\geol 4002 spr26\politicalboundaryfile.xy');
    border_data=textscan(fid,'%f %f','headerlines',0);
    fclose(fid);

    border_lon=border_data{1};
    border_lat = border_data{2};

% Load and parse the station data
%__Station P403
fid=fopen('C:\Users\jojo1\OneDrive\Desktop\LSU classes\geol 4002 spr26\P403.NA.tenv3.txt');
    P403data=textscan(fid,'%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','headerlines',1);
    fclose(fid);

    %-data
    tP403=P403data{3};
    xP403=P403data{9};
    yP403=P403data{11};
    eP403=P403data{13};
    %-map
    xlocationP403=P403data{22}(1);
    ylocationP403=P403data{21}(1);

%__Station P404
fid=fopen('C:\Users\jojo1\OneDrive\Desktop\LSU classes\geol 4002 spr26\P404.NA.tenv3.txt');
    P404data=textscan(fid,'%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','headerlines',1);
    fclose(fid);
    
    %-data
    tP404 = P404data{3};
    xP404 = P404data{9};
    yP404 = P404data{11};
    eP404 = P404data{13};
    %-map
    xlocationP404=P404data{22}(1);
    ylocationP404=P404data{21}(1);

%Station_P396
fid=fopen('C:\Users\jojo1\OneDrive\Desktop\LSU classes\geol 4002 spr26\P396.NA.tenv3.txt');
    P396data=textscan(fid,'%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','headerlines',1);
    fclose(fid);

    %-data
    tP396 = P396data{3};
    xP396 = P396data{9};
    yP396 = P396data{11};
    eP396 = P396data{13};
    %-map
    xlocationP396=P396data{22}(1);
    ylocationP396=P396data{21}(1);

%Station_P395
fid=fopen('C:\Users\jojo1\OneDrive\Desktop\LSU classes\geol 4002 spr26\P395.NA.tenv3.txt');
    P395data=textscan(fid,'%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','headerlines',1);
    fclose(fid);

    %-data
    tP395 = P395data{3};
    xP395 = P395data{9};
    yP395 = P395data{11};
    eP395 = P395data{13};
    %-map
    xlocationP395=P395data{22}(1);
    ylocationP395=P395data{21}(1);

%Calculate the velocity magnitude and azimuth
%-station P403
    vP403 = sqrt(xP403.^2 + yP403.^2);
    aziP403 = atan2d(yP403, xP403);

    P1=polyfit(tP403,xP403,1);
    vxP403=P1(1)*1000 %converts from m/y to mm/y

    P2=polyfit(tP403,yP403,1);
    vyP403=P2(1)*1000

    P3=polyfit(tP403,eP403,1);
    veP403=P3(1)*1000

%-station P404
    vP404 = sqrt(xP404.^2 + yP404.^2);
    aziP404 = atan2d(yP404, xP404);

    H1=polyfit(tP404,xP404,1);
    vxP404=H1(1)*1000

    H2=polyfit(tP404,yP404,1);
    vyP404=H2(1)*1000;

    H3=polyfit(tP404,eP404,1);
    veP404=H3(1)*1000;

%-station P396
    vP396 = sqrt(xP396.^2 + yP396.^2);
    aziP396 = atan2d(yP396, xP396);
    
    U1 = polyfit(tP396,xP396,1);
    vxP396 = U1(1)*1000

    U2 = polyfit(tP396,yP396,1);
    vyP396 = U2(1)*1000

    U3=polyfit(tP396,eP396,1);
    veP396 = U3(1) * 1000

%-station P395
    vP395 = sqrt(xP395.^2 + yP395.^2);
    aziP365 = atan2d(yP395, xP395);

    K1=polyfit(tP395,xP395,1);
    vxP395 = K1(1) * 1000; 

    K2 = polyfit(tP395,yP395,1);
    vyP395 = K2(1) * 1000;

    K3 = polyfit(tP395,eP395,1);
    veP395 = K3(1) * 1000;

%Plotted map with velocity vectors
%--map
figure (5)
clf
hold on
plot(coast_lon,coast_lat)
plot(border_lon,border_lat)
%--velocity vectors
quiver(xlocationP403,ylocationP403,vxP403,vyP403, 'm');
quiver(xlocationP404,ylocationP404,vxP404,vyP404, 'y');
quiver(xlocationP396,ylocationP396,vxP396,vyP396, 'b');
quiver(xlocationP395,ylocationP395,vxP395,vyP395, 'c');

%---------IGNORE FOR NOW//OLD ASSIGNMENT CODE----
% Plot the data
figure(1)
title('Time vs Lat Change')
clf
plot(tP403,xP403,'.')
hold on
plot(tP403,xline)
hold off

figure (2)
title('Time vs Long Change')
clf
plot(tP403,yP403,'.')
hold on
plot(tP403,yline)
hold off

figure (3)
clf
plot(tP403,eP403,'.')
hold on
plot(tP403,eline)
hold off

%residual calculations
xresidual=xP403-xline;
yresidual=yP403-yline;
eresidual=eP403-eline;

%residual plot 
figure (4)
subplot(3,1,1)
plot(tP403,xresidual,'.')

subplot(3,1,2)
plot(tP403,yresidual,'.')

subplot(3,1,3)
plot(tP403,eresidual,'.')

%CALCS NOT USED FOR VECTOR MAP BUT MIGHT NEED AGAIN 
%NTI-xline=polyval(P,tP403);
%NTI-yline=polyval(P2,tP403);
%NTI-eline=polyval(P3,tP403);

%------------------------------