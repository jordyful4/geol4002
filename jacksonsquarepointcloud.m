%%%%Jordyn Fulton
%%Jackson Square point cloud second rodeo

clear
format compact
tic

 %Load cloud data

 filename='jacksonsquare_points.laz';
 lasreader=lasFileReader(filename);
 pointcloud=readPointCloud(lasreader) %[output:06f266a5]

 xpoint=pointcloud.Location(:,1);
 ypoint=pointcloud.Location(:,2);
 zpoint=pointcloud.Location(:,3);

 figure(1) %[output:960e8f0a]
 clf %[output:960e8f0a]
 plot3(xpoint,ypoint,zpoint,'.') %[output:960e8f0a]
 grid %[output:960e8f0a]

 figure(2) %[output:20e0df87]
 clf %[output:20e0df87]
 scatter(xpoint,ypoint,5,zpoint) %[output:20e0df87]
 colorbar %[output:20e0df87]
 
%%%???figure 3 attempt space, it keeps saying it doesn't recognize my VX as a
%%%variable but ive changed it a baunch and its past my bedtime (1am) so
%%%perchance we can go through it in class?:)
%%%%%%%%%%%%%%%%%%%%%%%%%

figure(3)
clf
scatter3(VX,VY,VZ,5,zpoint) %[output:904a85da]
colorbar



%%%%%%%%%%%%%%%%%%%

 figure(4)
 clf
 pcshow(pointcloud)

 %%%%DEM%%%%%%%%%%%%%
 outputfilename='jacksonsquare_output.tin(1)';
 [area,radius]=readgeoraster(outputfilename);

 %%%%%%Vector components%%%%
 xvec1=radius.XWorldLimits(1);
 xvec2=radius.XWorldLimits(2);
 distXv=radius.CellExtentIRLx;
 VX=(xvec1+distXv/2):distXv:(xvec2-distXv/2);

 yvec1=radius.YWorldLimits(1);
 yvec2=radius.YWorldLimits(2);
 distYv=radius.CellExtentIRLy;
 VY=(yvec1+distYv/2):distYv:(yvec2-distYv/2);

 zvec1=radius.ZWorldLimits(1);
 zvec2=radius.ZWorldLimits(2);
 distZv=radius.CellExtentIRLz;
 VZ=(zvec1+distZv/2):distZv:(zvec2-distZv/2);

 %%converting PsuedoNaNs to regular NaNs
 iNaNs=find(a==-9999);
 a(iNaNs)=NaN;

 figure(4)
 clf
 imagesc(X,Y,area)
 colorbar

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":10.6}
%---
%[output:06f266a5]
%   data: {"dataType":"textualVariable","outputData":{"name":"pointcloud","value":"  <a href=\"matlab:helpPopup('pointCloud')\" style=\"font-weight:bold\">pointCloud<\/a> with properties:\n\n     Location: [939639×3 double]\n        Count: 939639\n      XLimits: [7.8330e+05 7.8360e+05]\n      YLimits: [3.3176e+06 3.3178e+06]\n      ZLimits: [-0.0900 33.4300]\n        Color: []\n       Normal: []\n    Intensity: [939639×1 uint16]"}}
%---
%[output:960e8f0a]
%   data: {"dataType":"image","outputData":{"dataUri":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAfCAYAAACGVs+MAAAAAXNSR0IArs4c6QAAAG1JREFUWEdjFBIS+s8wgIBx1AGjITAaAqMhMBoCQzoE+KNnMDAJSIFrkn8fnjF8XJpBcq1CUV0gmL2JgZlfEmzp34\/PGd5P9RthDkCOApDX6R4CJIc3Fg0UpYFRB4yGwGgIjIbAaAiMhsCwCAEAyhQ6i0PP1SAAAAAASUVORK5CYII=","height":30,"width":47}}
%---
%[output:20e0df87]
%   data: {"dataType":"image","outputData":{"dataUri":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAfCAYAAACGVs+MAAAAAXNSR0IArs4c6QAAAvVJREFUWEftlk9Ik2Ecx7\/742vmn2LTYmO6LGTgv8gdPFTELgUdAj0MveQSCUzUkw7EZsqYjHYIhxh2cZcdvBhBlwi0U2hsXULYQRa5Mf8ul2\/TbW6L5xnvmNuUvQ7tsuf28j7v8\/vwfb6\/7+8VSCSSOP7jEhQACgoUFCgoUFCAU4ApkqG85A4EYgY7\/vcXFs40iknx+uZJlDWJsfflEiLCP\/i5\/hKhsPfcQSiAtOIxGp89QkWcQSS2h\/UPNfi1Y8F+8PvFACge1uHa2jvU1YsQiAfh341h1TkENvQjCSCTyTJgfD5f3oDJafjgTTeCX2\/h6v19bMzK4Vo1Iny0RQuQ4qOjo2hpaTlW0Ol0wmg0Ih+QJEDJ9TJIb8sQclUi4F1LFicVSeHp6WlIhVaIBAmoULwBgVgH2tvbjwHU1tbCYrFALpfTfXa7HVarFVqtFn19fWAYBi6XCzqdjr7P6X+AA7jh06Mouks\/PChWwVM1lAFgNpvpe71ej9bWVgwPD8Nms6GzsxMLCwuYn5\/H3NwcHA4HBeMFcLjZg3g0oYCQaURxpSkDIPWOiBpjY2NYXFyERqPB+Pg43G43+vv7oVAoKCQvgM+sGcHYb1pDKrqJu6XPTwTgrmJpaQkrKyvo7e09BqBWq+k18AIwsJ\/gjwUpQJ2oEoOl97ICEOkNBgOVnkhOntMBzqTA0+01bEYjFKCZuYzXkpoMAGK2rq4uTExMYHl5me4laphMpvw98MR9BF8k8ROtLhHgbbU4A4AYTKVSJa3AsixtYaVSmX8XdH8rw9ahkB7edOUIk83BU02YS0rx8sCLjwps\/xXTcxuqDvFKs5EVgFMhHA7T\/CA+OGnxAjDMKuEPFCVMWH2AwQ5vBgBpMc7hxA9tbW0YGRmh7Zdt8QKYmiqHf1dEz5FIoxgY2M8aRB6Ph4YMlwMzMzNJQ6ZD5ARw2iwg8Zq6SBKmAqS6\/8wKkA8JRPpEJEMofRClA5AkzFuBXNzM7TkXD\/ABIHv5dME\/5x2omp8xdfcAAAAASUVORK5CYII=","height":30,"width":47}}
%---
%[output:904a85da]
%   data: {"dataType":"error","outputData":{"errorType":"runtime","text":"Unrecognized function or variable 'VX'."}}
%---
