%%MINI PROJECT 3/23 - WILDFIRES IN CALIFORNIA

clear

 fileName1='before2021cali.tif';
  fileName2='after2021cali.tif';

  [x1,y1,z1]=load_one_DEM(fileName1);
  [x2,y2,z2]=load_one_DEM(fileName2);



 %=[0,500]; % the color axis extent for these figures

  % figure(2)
  % clf
  % ax(1)=subplot(121);
  % imagesc(x1,y1,z1)
  % axis xy
  % axis equal
  % colorbar
  % title('before')
  % %caxis([0,500])
  % 
  % ax(2)=subplot(122);
  % imagesc(x2,y2,z2)
  % axis xy
  % axis equal
  % colorbar
  % title('after')
  % %caxis([0,500])
  % 
  % linkaxes(ax,'xy')

  % determine the extent of the overlap
%
  ytop=min(max(y1),max(y2));

  % made up numbers because Karen is lazy
  ybottom=max(min(y1),min(y2));
  xleft=max(min(x1),min(x2));
  xright=min(max(x1),max(x2));

%
% find the indices of rows and colums within
% the overlapping region
%
  i1=find(y1<ytop & y1>ybottom);
  j1=find(x1<xright & x1>xleft);

  i2=find(y2<ytop & y2>ybottom);
  j2=find(x2<xright & x2>xleft);

%
% Cut the DEM to the smaller area
%
  z1_smaller=z1(i1,j1);
  z2_smaller=z2(i2,j2);

  x_smaller=x1(j1);
  y_smaller=y1(i1);

%
% Plot the new ones!
% (plowing over the old figure)
%
  figure(2)
  clf
  ax(1)=subplot(121);
  imagesc(x_smaller,y_smaller,z1_smaller)
  axis xy
  axis equal
  colorbar
  title('before - cut to coregistered size')
  %caxis([0,500])

  ax(2)=subplot(122);
  imagesc(x_smaller,y_smaller,z2_smaller)
  axis xy
  axis equal
  colorbar
  title('after - cut to coregistered size')
  %caxis([0,500])

  linkaxes(ax,'xy')

%
% Take the gradient!
%
  [d1dx,d1dy]=gradient(z1_smaller);
  [d2dx,d2dy]=gradient(z2_smaller);

%
% Plot the gradient in a "gray" colormap, so it looks like shadows
%  - we looked at dadx: try looking at dady, or -dadx, or dadx+dady
%  
  figure(6)
  clf
  ax(3)=subplot(121);
  imagesc(x_smaller,y_smaller,d1dx)
  colorbar
  axis equal
  axis xy
  title('Before Caldo Fire')
  colormap(gray)
  caxis([-2,2])

  ax(4)=subplot(122);
imagesc(x_smaller,y_smaller,d2dx)
  colorbar
  axis equal
  axis xy
  title('After Caldo Fire')
  colormap(gray)
  caxis([-2,2])
%
% Difference the DEMs and plot them
%
  z_difference=z2_smaller-z1_smaller;

  figure(3)
  clf
  % ax(3)=subplot(121);
  imagesc(x_smaller,y_smaller,z_difference)
  axis xy
  axis equal
  colorbar
  title('after-before difference')
  colormap(flipud(cpolar)) % flip the colors to match fig 5c
  caxis([-10,10])
  ax(5)=gca;

  linkaxes(ax,'xy')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function Definitions Start Here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  function [x,y,a]=load_one_DEM(filename1)
    %load the file
    [a,r]=readgeoraster(filename1);

    % Make the x and y vectors for the DEM grid
    x1=r.XWorldLimits(1);
    x2=r.XWorldLimits(2);
    dx=r.CellExtentInWorldX;
    x=(x1+dx/2):dx:(x2-dx/2);

    y1=r.YWorldLimits(1);
    y2=r.YWorldLimits(2);
    dy=r.CellExtentInWorldY;
    y=(y1+dy/2):dy:(y2-dy/2);

    % find all the pseudo-NaNs and make them actual NaNs
    iNaNs=find(a==-9999);
    a(iNaNs)=NaN;

    % flip the image upside down so that it is a proper map
    a=flipud(a);
  end