% polar angle coordinates
phi = linspace(1,180,180).';

% azimuthal angle coordinates
theta = linspace(-90,90,181).'; 


%% load 1D directional data
%directional = csvread('directionaldata.csv',1,1);

% intended peak response angle of the angular-sensitive-pixel (ASP)


%% clean up 2D ASP data according to 1D data
% rescale the data according to the peak power for proper normalization
%sphericalz = sphericalz/max(sphericalz(:))*max(directional_pix);

% remove data from extreme angle (close to 90 degrees)
% consider 85 degrees FOV
theta = theta(6:end-5);
% R_asp = sphericalz(6:end-5,:);
%theta = theta(11:end-10);

R_asp = sphericalz(:,:);
%R_asp = sphericalz(3:end-4,1:181);

phi = [0;phi];
% R = [R(:,1:90),R(:,90),rot90(R(:,1:90),2)];
R_asp = [flipud(R_asp(:,180)),R_asp];

%% setup the coordinates at the far field
[phi2, theta2] = meshgrid(phi, theta);

% this is to convert angular coordinates to xyz coordinates (z is the
% observation screen location)
rho = sind(theta2);
% x-coordinates
x = rho.*cosd(phi2);
% y-coordinates
y = rho.*sind(phi2);

%% in linear angular space

% input data coordinate
x_angle = theta2.*cosd(phi2);
y_angle = theta2.*sind(phi2);

% output data coordinate, assume FOV 85
% x3 = linspace(-90,90,181);
% y3 = linspace(-90,90,181);
% [x33,y33] = meshgrid(x3,y3);

% previous version 05062019

x3 = linspace(-90,90,181);
y3 = linspace(-90,90,181);
[x33,y33] = meshgrid(x3,y3);

% interpolate the data from input to output
R_angle = griddata(x_angle,y_angle,R_asp,x33,y33); 
% remove missing data with 0
R_angle(isnan(R_angle)) = 0;
% remove very low response by 0
% R_angle(R_angle<1e-5) = 0;
clc;

%%
x2 = linspace(-1,1,181);
y2 = linspace(-1,1,181);
[x22,y22] = meshgrid(x2,y2);

R2 = griddata(x,y,R_asp,x22,y22); 
R2(isnan(R2)) = 0;
clc;

% f = figure; 
% imagesc(x2,y2,R2);
% axis image; axis off; colormap jet;
% export_fig(f,[outdir,'R2-response.png']);


%% load in angular sensitive pixel (ASP) 2D responses
% angular response for the dominant polarization component (z)

% polar angle coordinates
phi = linspace(1,180,180).';

% azimuthal angle coordinates
theta = linspace(-90,90,181).'; 


%% load 1D directional data
%directional = csvread('directionaldata.csv',1,1);

% intended peak response angle of the angular-sensitive-pixel (ASP)
response_pix = [0,10,20,30,40,50,60,75]; 
theta_pix = [-85:.5:85];

% the data from the 2D response is from 20 degree
n_pix = 4;



%% clean up 2D ASP data according to 1D data
% rescale the data according to the peak power for proper normalization
%sphericalz1 = sphericalz1/max(sphericalz1(:))*max(directional_pix);

% remove data from extreme angle (close to 90 degrees)
% consider 85 degrees FOV
theta = theta(6:end-5);
% R_asp = sphericalz(6:end-5,:);
%theta = theta(11:end-10);

R_asp1 = sphericalz1(:,:);
%R_asp = sphericalz(3:end-4,1:181);

phi = [0;phi];
% R = [R(:,1:90),R(:,90),rot90(R(:,1:90),2)];
R_asp1 = [flipud(R_asp1(:,180)),R_asp1];

%% setup the coordinates at the far field
[phi2, theta2] = meshgrid(phi, theta);

% this is to convert angular coordinates to xyz coordinates (z is the
% observation screen location)
rho = sind(theta2);
% x-coordinates
x = rho.*cosd(phi2);
% y-coordinates
y = rho.*sind(phi2);

%% in linear angular space

% input data coordinate
x_angle = theta2.*cosd(phi2);
y_angle = theta2.*sind(phi2);

% output data coordinate, assume FOV 85
x3 = linspace(-90,90,181);
y3 = linspace(-90,90,181);
[x33,y33] = meshgrid(x3,y3);

% interpolate the data from input to output
R_angle1 = griddata(x_angle,y_angle,R_asp1,x33,y33); 
% remove missing data with 0
R_angle1(isnan(R_angle1)) = 0;
% remove very low response by 0
% R_angle(R_angle<1e-5) = 0;
clc;


%%
x2 = linspace(-1,1,181);
y2 = linspace(-1,1,181);
[x22,y22] = meshgrid(x2,y2);
R2_1 = griddata(x,y,R_asp1,x22,y22); 
R2_1(isnan(R2_1)) = 0;
clc;