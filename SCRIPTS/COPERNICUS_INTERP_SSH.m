function [Variable_interp,Variable_obc] = COPERNICUS_INTERP_SSH(fname_data,z_data,variable_name,nbidta,nbjdta)




%variable_name='so';
%fname_data = 'Sal_16_0000.nc';
%z_data = 'domain_cfg.nc';





% This is the NEMO grid

xout=double(ncread(z_data,'nav_lon'));
yout=double(ncread(z_data,'nav_lat'));


% Here we read in the copernicus data

Variable_in=ncread(fname_data,variable_name);
xin=double(ncread(fname_data,'longitude'));
yin=double(ncread(fname_data,'latitude'));



% make COPERNICUS coordinates 3D arrays (for griddata function)
[Xin,Yin]=meshgrid(xin,yin);


% We only want to feed non-nan numbers from the copernicus grid.
Xlr=Xin(~isnan(Variable_in));
Ylr=Yin(~isnan(Variable_in));
Variable_lr=Variable_in(~isnan(Variable_in));


% Interpolate Copernicus grid (without nans) on to same grid - basically
% "flood filling", but by interpolation, not extrapolation.

Variable_in=griddata(Xlr,Ylr,Variable_lr,Xin,Yin);

clear Variable_lr Xlr Ylr Zlr

% nans will still exists around the edges - let's find the nearest
% neighours to fill them in.

ind_nnan=~isnan(Variable_in(:));
ind_nan = isnan(Variable_in(:));

Xlnnan=Xin(ind_nnan);
Ylnnan=Yin(ind_nnan);
coordnnan=[Xlnnan Ylnnan];

Xlnan=Xin(ind_nan);
Ylnan=Yin(ind_nan);
coordnan=[Xlnan Ylnan];


clear Xin Yin Zin Xlnan Ylnan Zlnan Xlnnan Ylnnan Zlnnan

% I found you!
ind=knnsearch(coordnnan,coordnan);

clear coordnan coordnnan

% tricky to read, but these 3 lines replace nans with nearest neighbours.
% Trust me.

Variable_TEMP=Variable_in(ind_nnan);
Variable_TEMP=Variable_TEMP(ind);
Variable_in(isnan(Variable_in))=Variable_TEMP;

clear Variable_TEMP ind ind_nnan ind_nan



% let's put our treated copernicus variable in NEMO space.

Variable_interp=interp2(xin,yin,Variable_in,xout,yout);

clear Variable_in xin yin zin

for i = 1:length(nbidta)
    
Variable_obc(i,1) = squeeze( Variable_interp(nbidta(i),nbjdta(i))); 
    
end


% ncid=netcdf.open(fname,'WRITE');
% varid = netcdf.inqVarID(ncid,'vosaline');
% 
% netcdf.putVar(ncid,varid,Variable_interp)



end

