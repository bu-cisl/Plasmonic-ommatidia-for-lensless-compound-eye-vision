%clear; close all; clc;
% 
% outdir = ['res2-cos/'];
% mkdir(outdir);

% Define Fourier operators
F = @(x) fftshift(fft2(ifftshift(x)));
Ft = @(x) fftshift(ifft2(ifftshift(x)));
cp = @(x,N,N0) x(-(N-1)/2+N0/2:(N-1)/2+N0/2,-(N-1)/2+N0/2:(N-1)/2+N0/2);

% 15-30:m=25, 30-45:m=19, 45-60:m=13
% 3:5; 15:20
D = 11;
m=41;
m1 = 47;
m2 = 42;
m3 = 30;
m4 = 18;
Response = [];
bg_add = 1;
n_phi = 90;

[x1,y1] = meshgrid(1:400,1:400);
mask = ones(400,400);
mask(((x1-200.5).^2+((y1-200.5).^2) > 200^2)) = 0;
%% load in angular sensitive pixel (ASP) 2D responses
% angular response for the dominant polarization component (z)
data = load('polar_data/0.mat');
R2 = double(data.data);
R2 = rot90(R2,1);
Response = R2;

%%
data = load('polar_data/4.mat');
data1 = load('polar_data/15.mat');

R2 = double(data.data);
R2_1 = double(data1.data);

R2 = rot90(R2,1);
R2_1 = rot90(R2_1,1);
% ......................  shift ............
pleft = zeros(400,400);
pleft(:,1:205) = R2_1(:,1:205).*1.8;
pright = zeros(400,400);
pright(:,195:400)= R2(:,195:400);
mask_test = ones(400,400);
mask_test(:,205:end)=0;
s =linspace(1,0,11);
mask_test(:,195:205) = repmat(s,400,1);
mask_new = mask_test;
s2 = linspace(0.6,1,120);
mask_new(:,1:120)=repmat(s2,400,1);
R2 = pleft.*mask_new+pright.*(1-mask_test);
tmp = R2;
tmp(tmp>0.075)=1;
tmp(tmp<1)=0.6;
test = imgaussfilt(tmp,5);
R2 = R2.*test;
split_data_for_shift();
D1 = 3;
s = linspace(-6,0,D1);
for n = 1:D1-1 
    p = interpolation_one(pleft,pright,R2,mask,s(n));
    Response = cat(3,Response,p);
end

D1 = 9;
s = linspace(0,m,D1);
s2 = linspace(-m,0,D1);
i = 45;
Response = cat(3,Response,R2);

for n = 2:D1-1   
    p = interpolation(pleft,pright,pleft2,pright2,R2,mask,s(n),s2(n),m);
    i = i+15/(D-1);
    Response = cat(3,Response,p);
%     figure;imagesc(p);axis image
%     title(['degree:', num2str(i)]);
    clc;
end
Response = cat(3, Response,R2_1);

%% load in angular sensitive pixel (ASP) 2D responses
% angular response for the dominant polarization component (z)
data = load('polar_data/15.mat');
data1 = load('polar_data/30.mat');
R2 = double(data.data);
R2_1 = double(data1.data);
R2 = rot90(R2,1);
R2_1 = rot90(R2_1,1);
split_data_for_shift()
s = linspace(0,m1,D);
s2 = linspace(-m1,0,D);
i = 45;

for n = 2:D-1
    p = interpolation(pleft,pright,pleft2,pright2,R2,mask,s(n),s2(n),m1);
    i = i+15/(D-1);
    Response = cat(3,Response,p);
%     figure;imagesc(p);axis image
%     title(['degree:', num2str(i)]);
    clc;
end
Response = cat(3, Response,R2_1);

%% load in angular sensitive pixel (ASP) 2D responses
% angular response for the dominant polarization component (z)
data = load('polar_data/30.mat');
data1 = load('polar_data/45.mat');

R2 = double(data.data);
R2_1 = double(data1.data);
R2 = rot90(R2,1);
R2_1 = rot90(R2_1,1);

split_data_for_shift();

s = linspace(0,m2,D);
s2 = linspace(-m2,0,D);
i = 45;

for n = 2:D-1
    p = interpolation(pleft,pright,pleft2,pright2,R2,mask,s(n),s2(n),m2);
    i = i+15/(D-1);
    Response = cat(3,Response,p);
%     figure;imagesc(p);axis image
%     title(['degree:', num2str(i)]);
    clc;
end
Response = cat(3, Response,R2_1);

%% 45-60

data = load('polar_data/45.mat');
data1 = load('polar_data/60.mat');
R2 = double(data.data);
R2_1 = double(data1.data);
R2 = rot90(R2,1);
R2_1 = rot90(R2_1,1);

split_data_for_shift();

s = linspace(0,m3,D);
s2 = linspace(-m3,0,D);
i = 45;

for n = 2:D-1
    p = interpolation(pleft,pright,pleft2,pright2,R2,mask,s(n),s2(n),m3);
    i = i+15/(D-1);
    Response = cat(3,Response,p);
%     figure;imagesc(p);axis image
%     title(['degree:', num2str(i)]);
    clc;
end
Response = cat(3, Response,R2_1);

%% 
data = load('polar_data/60.mat');
data1 = load('polar_data/75.mat');
R2 = double(data.data);
R2_1 = double(data1.data);
R2 = rot90(R2,1);
R2_1 = rot90(R2_1,1);

split_data_for_shift();

s = linspace(0,m4,D);
s2 = linspace(-m4,0,D);
i = 45;

for n = 2:D-1
    p = interpolation(pleft,pright,pleft2,pright2,R2,mask,s(n),s2(n),m4);
    i = i+15/(D-1);
    Response = cat(3,Response,p);
%     figure;imagesc(p);axis image
%     title(['degree:', num2str(i)]);
    clc;
end
Response = cat(3, Response,R2_1);


% for i = 1: size(Response,3)
%     figure;imagesc(Response(:,:,i));axis image;colormap jet;axis off
% end

save response Response 

%% angular coordinate
x2 = linspace(-1,1,400);
y2 = linspace(-1,1,400);
[x22,y22] = meshgrid(x2,y2);
 
x_kk=x22;
y_kk=y22;
rho_xy = sqrt(x_kk.^2+y_kk.^2);
rho_xy(rho_xy>=1) = 1;
rho_angle = asind(rho_xy);
x_angle2 = x_kk.*(rho_angle./rho_xy);
y_angle2 = y_kk.*(rho_angle./rho_xy); 
x_angle2(isnan(x_angle2)) = 0;
y_angle2(isnan(y_angle2)) = 0;

x3 = linspace(-90,90,400);
y3 = linspace(-90,90,400);
[x33,y33] = meshgrid(x3,y3);

dim = size(Response);

Response_angle  = [];

for i = 1:size(Response,3)
R_angle2 = griddata(x_angle2,y_angle2,Response(:,:,i),x33,y33);
R_angle2(isnan(R_angle2)) = 0;
clc;
Response_angle = cat(3, Response_angle,R_angle2);
end 

save response_angle Response_angle 