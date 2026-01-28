clear

% Load the data

fid=fopen('P403.NA.tenv3.txt');

C=textscan(fid,'%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','headerlines',1);
fclose(fid);
%parse the data

t=C{3};
x=C{9};

% Plot the data

figure(1)
clf
plot(t,x,'.')

