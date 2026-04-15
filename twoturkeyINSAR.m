clear

%%%turkey interferogram files
filename_S='C:\Users\jojo1\OneDrive\Documents\GitHub\geol4002\S1-GUNW-D-R-021-tops-20230210_20230105-033504-00035E_00035N-PP-9df5-v2_0_6.nc';

filename_N='C:\Users\jojo1\OneDrive\Documents\GitHub\geol4002\S1-GUNW-D-R-021-tops-20230210_20230129-033440-00036E_00037N-PP-c92c-v2_0_6.nc';

  S.x=ncread(filename_S,'/science/grids/data/longitude');
  S.y=flipud(ncread(filename_S,'/science/grids/data/latitude'));
  S.u=flipud(ncread(filename_S,'/science/grids/data/unwrappedPhase')'); % unwrapped phase (radians)
  S.c=flipud(ncread(filename_S,'/science/grids/data/coherence')');
  S.m=flipud(ncread(filename_S,'/science/grids/data/connectedComponents')'); % connected components
  S.a=flipud(ncread(filename_S,'/science/grids/data/amplitude')'); % amplitude (watts)
  S.L=ncread(filename_S,'/science/radarMetaData/wavelength'); % wavelength (m)


  N.x=ncread(filename_N,'/science/grids/data/longitude');
  N.y=flipud(ncread(filename_N,'/science/grids/data/latitude'));
  N.u=flipud(ncread(filename_N,'/science/grids/data/unwrappedPhase')'); % unwrapped phase (radians)
  N.c=flipud(ncread(filename_N,'/science/grids/data/coherence')');
  N.m=flipud(ncread(filename_N,'/science/grids/data/connectedComponents')'); % connected components
  N.a=flipud(ncread(filename_N,'/science/grids/data/amplitude')'); % amplitude
  N.L=ncread(filename_N,'/science/radarMetaData/wavelength'); % wavelength (m)

  %%rewrapping scenes

  N.w=mod(N.u,2*pi);
  S.w=mod(S.u,2*pi);

  %%plotting individual scenes together and making NaNs transparent

  figure(1),clf
  ax(1)=subplot(1,5,1);
    h=imagesc(N.x,N.y,N.u);set(h,'alphadata',~isnan(N.u)),hold on,
    h=imagesc(S.x,S.y,S.u);set(h,'alphadata',~isnan(S.u)),axis xy, colorbar, title('unwrappedPhase')
    set(ax(1),'colormap',jet)
  ax(2)=subplot(1,5,2);
    h=imagesc(N.x,N.y,N.w);set(h,'alphadata',~isnan(N.w)),hold on,
    h=imagesc(S.x,S.y,S.w);set(h,'alphadata',~isnan(S.w)),axis xy, colorbar, title('wrappedPhase')
    set(ax(2),'colormap',jet)
  ax(3)=subplot(1,5,3);
    h=imagesc(N.x,N.y,N.c);set(h,'alphadata',~isnan(N.c)),hold on,
    h=imagesc(S.x,S.y,S.c);set(h,'alphadata',~isnan(S.c)),axis xy, colorbar, title('coherence'), caxis([0,1])
  ax(4)=subplot(1,5,4);
    h=imagesc(N.x,N.y,N.m);set(h,'alphadata',~isnan(N.m)),hold on,
    h=imagesc(S.x,S.y,S.m);set(h,'alphadata',~isnan(S.m)),axis xy, colorbar, title('connectedComponents')
  ax(5)=subplot(1,5,5);
    h=imagesc(N.x,N.y,N.a);set(h,'alphadata',~isnan(N.a)),hold on,
    h=imagesc(S.x,S.y,S.a);set(h,'alphadata',~isnan(S.a)),axis xy, colorbar, title('amplitude'), caxis([0,1e4])
    set(ax(5),'colormap',gray)

  linkaxes(ax,'xy')
  xlim([35.5,39])
  ylim([35.5,39])

  %%making a big grid
  %%also need to figure out the size of this big grid

  x1=min([N.x;S.x]);
  x2=max([N.x;S.x]);
  y1=min([N.y;S.y]);
  y2=max([N.y;S.y]);

  dx=1/3600*3; % 3 arcsecond spacing (recall, 1 degree of lat/lon = 3600 arcseconds)
  dy=1/3600*3; % 3 arcsecond spacing

  B.x=[x1:dx:(x2+dx/2)]'; % take the transpose to make it a single column, rather than a row
  B.y=[y1:dy:(y2+dy/2)]';

  [~,S.ix1]=min(abs(B.x-S.x(1)));
  [~,S.ix2]=min(abs(B.x-S.x(end)));
  [~,S.iy1]=min(abs(B.y-S.y(1)));
  [~,S.iy2]=min(abs(B.y-S.y(end)));

  [~,N.ix1]=min(abs(B.x-N.x(1)));
  [~,N.ix2]=min(abs(B.x-N.x(end)));
  [~,N.iy1]=min(abs(B.y-N.y(1)));
  [~,N.iy2]=min(abs(B.y-N.y(end)));

  B.w(N.iy1:N.iy2,N.ix1:N.ix2)=N.w;
  B.w(S.iy1:S.iy2,S.ix1:S.ix2)=max(S.w,B.w(S.iy1:S.iy2,S.ix1:S.ix2)); % prioritizes keeping the numbers

  figure(2),clf
    subplot(221)
    imagesc(B.x,B.y,B.w),axis xy, colorbar, title('big wrapped phase')

%%% unwrapping big grid attempt
    tic
    B.u = unwrap(B.w);
    toc
%%% plotting attempt of unwrapped results
    subplot(222)
    imagesc(B.x,B.y,B.u),axis xy, colorbar, title('big unwrapped phase')
    colormap(jet)

    %%making incoherent areas NaNs

    B.c=zeros(numel(B.y),numel(B.x))*NaN; % make a big empty grid and fill it with NaNs
    B.c(N.iy1:N.iy2,N.ix1:N.ix2)=N.c;
    B.c(S.iy1:S.iy2,S.ix1:S.ix2)=max(S.c,B.c(S.iy1:S.iy2,S.ix1:S.ix2)); % prioritizes keeping the numbers

    B.m=zeros(numel(B.y),numel(B.x))*NaN; % make a big empty grid and fill it with NaNs
    B.m(N.iy1:N.iy2,N.ix1:N.ix2)=N.m;
    B.m(S.iy1:S.iy2,S.ix1:S.ix2)=max(S.m,B.m(S.iy1:S.iy2,S.ix1:S.ix2)); % prioritizes keeping the numbers

    B.w_with_nans=B.w; % copy the full wrapped nans grid before we start destroying data points
    B.w_with_nans(find(B.m<1))=NaN;   % This one excludes areas that ARIA couldn't unwrap (too noisy)
    B.w_with_nans(find(B.c<0.3))=NaN; % This one adds a coherence threshold for the other regions (try changing the threshold)

    subplot(223)
    imagesc(B.x,B.y,B.w_with_nans),axis xy, colorbar, title('new big wrapped w NaNs removed')

    tic
    B.u_with_nans = unwrap(B.w_with_nans);
    toc

    subplot(224)
    imagesc(B.x,B.y,B.u_with_nans),axis xy, colorbar, title('new big unwrapped phase')


    %%%same figure again comparing different unwrapping solutions but
    %%%plotted all together in a coherent color scale

    figure(3),clf,
    subplot(221)
    imagesc(B.x,B.y,B.w),axis xy, colorbar, title('big wrap')

    subplot(222)
    imagesc(B.x,B.y,B.u),axis xy, colorbar, title('big unwrap')
    caxis([-300,300])

    subplot(223)
    imagesc(B.x,B.y,B.w_with_nans), axis xy, colorbar, title('big wrap without NaNs')

    subplot(224)
    imagesc(B.x,B.y,B.u_with_nans),axis xy, colorbar, title('big unwrap without NaNs')
    caxis([-300,300])
    colormap(jet)

    %%finding and plotting LOS displacement

     B.L=N.L; % radar wavelength, from the *.nc file
     B.LOS=B.u_with_nans*B.L/(4*pi);

     figure(4),clf,
    imagesc(B.x,B.y,B.LOS),axis xy,colorbar
    colormap(jet)
    caxis([-1.5,1.5])
