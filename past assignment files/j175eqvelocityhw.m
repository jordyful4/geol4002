%2/6 hw assignment: calculate and plot on a map the pre, co, and post
%seismic velocities for the earthquake on station J175 with the east, north
%and elevation components
clear


%%%load the data
[tj175,eastj175,northj175]=load_and_parse('J175','OK');

%%%plot the time series
figure(1)
clf
plot(tj175,eastj175,'.-')
grid

%%find the points from before & after the earthquake
    i_before=find(tj175 < 2011.186);
    i_after=find(tj175 > 2011.186);

%%plot the points
hold on
    plot(tj175(i_before),eastj175(i_before),'.')
    plot(tj175(i_after),eastj175(i_after),'.')

%%calculate velocity for entire time series and for the just before
    [veast,vnorth]=fit_velocity_one_GNSS(tj175,eastj175);
    [veast_before,vnorth_before]=fit_velocity_one_GNSS(tj175(i_before),eastj175(i_before));


%%find the points for co-seismic displacement
i_co=find(tj175>2011.186 & tj175<2011.190);
diff_eastj175=eastj175(i_co(2))-eastj175(i_co(1))

%function definitions%

function [tj175,eastj175,northj175,vertj175]=load_and_parse(stationname,referenceplate)
    filename=[stationname,'.',referenceplate,'.tenv3.txt'];

    fid=fopen(filename);
    C=textscan(fid,'%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','headerlines',1);
    fclose(fid);  

    tj175=C{3};
    eastj175=C{9};
    northj175=C{11};
    vertj175=C{12};
end

function [veast,vnorth,eastline,veast_before,northline,vnorth_before]=fit_velocity_one_GNSS(tj175,eastj175)
    Pe=polyfit(tj175,eastj175,1);
    veast=Pe(1)*1000;
    eastline=polyval(Pe,tj175);
    veast_before=Pe(i_before)*1000;

    Pn=polyfit(tj175,northj175,1);
    vnorth=Pn(1)*1000;
    vnorth_before=Pn(i_before)*1000;
    northline=polyval(Pn,tj175);


end