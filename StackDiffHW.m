%%%%%Stack and Difference HW assignment - Ridgecrest EQ

clear

filename_D1= 'S1-GUNW-D-R-071-tops-20190704_20190622-135211-36450N_34472N-PP-53f3-v2_0_2.nc';
filename_D2= 'S1-GUNW-D-R-071-tops-20190704_20190610-135211-36450N_34472N-PP-1bf7-v2_0_2.nc';

  D1.x=ncread(filename_D1,'/science/grids/data/longitude');
  D1.y=flipud(ncread(filename_D1,'/science/grids/data/latitude'));
  D1.u=flipud(ncread(filename_D1,'/science/grids/data/unwrappedPhase')'); % unwrapped phase (radians)
  D1.c=flipud(ncread(filename_D1,'/science/grids/data/coherence')');
  D1.m=flipud(ncread(filename_D1,'/science/grids/data/connectedComponents')');
  D1.a=flipud(ncread(filename_D1,'/science/grids/data/amplitude')'); % amplotude (watts)
  D1.L=ncread(filename_D1,'/science/radarMetaData/wavelength'); % wavelength (m)

  D2.x=ncread(filename_D2,'/science/grids/data/longitude');
  D2.y=flipud(ncread(filename_D2,'/science/grids/data/latitude'));
  D2.u=flipud(ncread(filename_D2,'/science/grids/data/unwrappedPhase')'); % unwrapped phase (radians)
  D2.c=flipud(ncread(filename_D2,'/science/grids/data/coherence')');
  D2.m=flipud(ncread(filename_D2,'/science/grids/data/connectedComponents')');
  D2.a=flipud(ncread(filename_D2,'/science/grids/data/amplitude')');
  D2.L=ncread(filename_D2,'/science/radarMetaData/wavelength'); % wavelength (m)

  L=ncread(filename_D2,'/science/radarMetaData/wavelength'); % wavelength (m)

   D1.w=mod(D1.u,2*pi);
   D2.w=mod(D2.u,2*pi);

   
   figure(1),clf
  ax(1)=subplot(2,2,1);
    imagesc(D1.x,D1.y,D1.w,'alphadata',~isnan(D1.u))
    axis xy 
    colorbar
    title('2019-06-22 to 2019-07-4')
  ax(2)=subplot(2,2,2);
    imagesc(D2.x,D2.y,D2.w,'alphadata',~isnan(D2.u)) 
    axis xy 
    colorbar
    title('2019-06-10 to 2019-07-4')
  ax(3)=subplot(2,2,3);
    imagesc(D1.x,D1.y,D1.u,'alphadata',~isnan(D1.w)) 
    axis xy 
    colorbar
    title('2019-06-22 to 2019-07-4')
  ax(4)=subplot(2,2,4);
    imagesc(D2.x,D2.y,D2.u,'alphadata',~isnan(D2.w)) 
    axis xy 
    colorbar
    title('2019-06-10 to 2019-07-4')
  
  linkaxes(ax,'xy')
  colormap(jet)

  %%%redifining new edges

    x1=-118.8; % left edge
    x2=-118; % right edge
    y1=35.3;   % bottom edge
    y2=36.2;   % top edge

 %%%SHORTENED x and y vectors
 dx=1/3600*3; % 3 arcsecond spacing (recall, 1 degree of lat/lon = 3600 arcseconds)
 dy=1/3600*3; 

 D1_smaller.x=[x1:dx:(x2+dx/2)]'; 
 D1_smaller.y=[y1:dy:(y2+dy/2)]';

 D2_smaller.x=D1_smaller.x;
 D2_smaller.y=D1_smaller.y;

%%%corresponding original grid to the shorter grid

    [~,D1.ix1]=min(abs(D1.x-x1));
    [~,D1.ix2]=min(abs(D1.x-x2));
    [~,D1.iy1]=min(abs(D1.y-y1));
    [~,D1.iy2]=min(abs(D1.y-y2));

    [~,D2.ix1]=min(abs(D2.x-x1));
    [~,D2.ix2]=min(abs(D2.x-x2));
    [~,D2.iy1]=min(abs(D2.y-y1));
    [~,D2.iy2]=min(abs(D2.y-y2));

    %%%cutting original grids to new size
    D1_smaller.w=D1.w(D1.iy1:D1.iy2,D1.ix1:D1.ix2);
    D1_smaller.u=D1.u(D1.iy1:D1.iy2,D1.ix1:D1.ix2);

    D2_smaller.w=D2.w(D2.iy1:D2.iy2,D2.ix1:D2.ix2);
    D2_smaller.u=D2.u(D2.iy1:D2.iy2,D2.ix1:D2.ix2);

%%%plotting the shortened grids
figure(2),clf
    ax2(1)=subplot(2,2,1);
      imagesc(D1_smaller.x,D1_smaller.y,D1_smaller.w,'alphadata',~isnan(D1_smaller.u))
      axis xy
      colorbar 
      title(' UNWRAPPED RESIZED 2019-06-22 to 2019-07-4')
    ax2(2)=subplot(2,2,2);
      imagesc(D2_smaller.x,D2_smaller.y,D2_smaller.w,'alphadata',~isnan(D2_smaller.u))
      axis xy 
      colorbar
      title('UNWRAPPED RESIZED 2019-06-10 to 2019-07-4')
    ax2(3)=subplot(2,2,3);
      imagesc(D1_smaller.x,D1_smaller.y,D1_smaller.u,'alphadata',~isnan(D1_smaller.w))
      axis xy
      colorbar
      title('WRAPPED RESIZED 2019-06-22 to 2019-07-4')
    ax2(4)=subplot(2,2,4);
      imagesc(D2_smaller.x,D2_smaller.y,D2_smaller.u,'alphadata',~isnan(D2_smaller.w))
      axis xy
      colorbar
      title('WRAPPED RESIZED 2019-06-10 to 2019-07-4')
    
    linkaxes(ax2,'xy')
    colormap(jet)

    %%%ACTUAL HOMEWORK
    %%%TAKE THE AVERAGE OF THE TWO GRIDS (ADD THEM AND DIVIDE BY TWO)

    %%---reapplying the "original grid>corresponding grid code" sandwich so
    %%the new new grid is the same size

    Dstack_w=[D1_smaller.w+D2_smaller.w/2]; %---averaged wrapped interferograms 
    Dstack_u=[D1_smaller.u+D2_smaller.u/2]; %----averaged unwrapped interferograms
    Dstack_x=[D1_smaller.x+D2_smaller.x/2]'; %---averaging x coordinates
    Dstack_y=[D1_smaller.y+D2_smaller.y/2]'; %---averaging y coordinates

    %%%making resultant figures

    figure(3),clf
       ax3(1)=subplot(2,2,1);
        imagesc(Dstack_x,Dstack_y,Dstack_u,'alphadata',~isnan(Dstack_w))
        axis xy
        colorbar
        title('Differenced UNWRAPPED and Stacked')

       ax3(2)=subplot(2,2,2)
       imagesc(Dstack_x,Dstack_y,Dstack_w,'alphadata',~isnan(Dstack_u))
       axis xy
       colorbar
       title('Differenced WRAPPED and Stacked')

       linkaxes(ax3,'xy')
       colormap(jet)