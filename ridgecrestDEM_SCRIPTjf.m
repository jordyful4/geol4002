 filename='C:\Users\jojo1\OneDrive\Documents\GitHub\geol4002\ridgecrest_before.tif';
  [a,r]= readgeoraster (filename);

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

  figure(1)
  clf
  imagesc(x,y,a)
  colorbar
  axis equal
  axis xy

  %taking the gradient to add to a greyscale figure

   [dadx,dady]=gradient(a);
figure(2)
  clf
  imagesc(x,y,dadx)
  colorbar
  axis equal
  axis xy
  colormap(gray)

  %%%^^^This is plotting figures 1 and 2 for the BEFORE data of Ridgecrest

   %%%%%vvv this is to plot the AFTER dataset

  filename='C:\Users\jojo1\OneDrive\Documents\GitHub\geol4002\ridgecrest_after.tif';
  [A,R]= readgeoraster (filename);

  % Make the x and y vectors for the DEM grid
  X1=r.XWorldLimits(1);
  X2=r.XWorldLimits(2);
  dX=r.CellExtentInWorldX;
  X=(X1+dX/2):dX:(X2-dX/2);

  Y1=r.YWorldLimits(1);
  Y2=r.YWorldLimits(2);
  dY=r.CellExtentInWorldY;
  Y=(Y1+dY/2):dY:(Y2-dY/2);

  % find all the pseudo-NaNs and make them actual NaNs
  i2NaNs=find(a==-9999);
  a(i2NaNs)=NaN;

  % flip the image upside down so that it is a proper map
  A=flipud(A);

figure(3)
  clf
  imagesc(X,Y,A)
  colorbar
  axis equal
  axis xy

  %taking the gradient to add to a greyscale figure

   [dadX,dadY]=gradient(a);

figure(4)
  clf
  imagesc(X,Y,dadX)
  colorbar
  axis equal
  axis xy
  colormap(gray)