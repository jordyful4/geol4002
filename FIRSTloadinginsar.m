clear
%%%script name: FIRSTloadinginsar

filename='S1-GUNW-A-R-064-tops-20190710_20190628-015013-36885N_35006N-PP-a1b9-v2_0_2.nc'


x=ncread(filename,'/science/grids/data/longitude');
y=ncread(filename,'/science/grids/data/latitude');
A=ncread(filename,'/science/grids/data/amplitude')';
C=ncread(filename,'/science/grids/data/coherence')';
U=ncread(filename,'/science/grids/data/unwrappedPhase')';

W=mod(U,2*pi);

%%plotting amplitude

figure(1)
  clf
  imagesc(x,y,A)
  axis xy
  colorbar
  caxis([0,10000])
  colormap(gray)
  title('Greyscale Amplitude')

%%plotting coherence

figure(2)
  clf
  imagesc(x,y,C)
  axis xy
  colorbar
  caxis([0,1])
  title('Coherence Plot')

figure(3)
  clf

  ax(1)=subplot(221);
  imagesc(x,y,U)
  axis xy
  colorbar
  title('unwrapped')

   ax(2)=subplot(222);
  h2=imagesc(x,y,U);
  set(h2,'AlphaData',C>0.5)
  axis xy
  colorbar
  title('unwrapped with transparency')

  ax(3)=subplot(223);
  imagesc(x,y,C)
  axis xy
  colorbar
  caxis([0,1])
  title('re-wrapped')

  ax(4)=subplot(224);
  h=imagesc(x,y,W); 
  set(h,'AlphaData',C>0.5) 
  axis xy
  colorbar
  title('re-wrapped with transparency')
  
  colormap(jet)
  linkaxes(ax,'xy')