clear; close all; clc;


% Define Fourier operators
F = @(x) fftshift(fft2(ifftshift(x)));
Ft = @(x) fftshift(ifft2(ifftshift(x)));
cp = @(x,N,N0) x(-(N-1)/2+N0/2:(N-1)/2+N0/2,-(N-1)/2+N0/2:(N-1)/2+N0/2);

% 15-30:m=25, 30-45:m=19, 45-60:m=13
% 3:5; 15:20
D = 11;
m=14;
m1 = 20; %25
m2 = 15;
m3 = 15;
Response = [];
bg_add = 1;
n_phi = 90;

data = load('polar_data/0.mat');

sphericalz = data.data;
sphericalz = reorganize_data(sphericalz,2);
coordinate_process_v2();
R2 = R2./max(max(R2));
R2 = rot90(R2,2);
Response = R2;

%% load in angular sensitive pixel (ASP) 2D responses
% angular response for the dominant polarization component (z)
data = load('polar_data/3.mat');
data1 = load('polar_data/15.mat');

sphericalz = data.data;
sphericalz1 = data1.data;

sphericalz = reorganize_data(sphericalz,2);
coordinate_process_v2();
R2_tmp = R2;
R2_tmp = rot90(R2_tmp,2);
R2_tmp = R2_tmp./max(max(R2_tmp));
sphericalz = reorganize_data(sphericalz);
sphericalz1 = reorganize_data(sphericalz1);
coordinate_process();
R2_1 = rot90(R2_1,2);
R2_1 = R2_1./max(max(R2_1));
R2 = R2_tmp;
clc;

%% method 2
tmp = R2;
tmp(tmp>0.46)=1;
tmp(tmp<1)=0;
tmp2 = R2;
tmp2(tmp2>0.4)=1;
tmp2(tmp2<1)=0;
tmp2(:,91:end) = 0;
tmp(:,1:90) = 0;
% tmp2(tmp2==1)=0.388;
% R2_tmp= R2;
% R2_tmp(logical(tmp2))=0.388;
R2_tmp=R2.*(1-tmp2.*0.19);
pleft = zeros(181,181);
pleft(:,1:90) = R2_tmp(:,1:90);
pright = zeros(181,181);
pright(:,91:181)= R2_tmp(:,91:181);
pleft(pleft>0.388)=0.388;
R2_tmp  = pleft+pright;
R2_tmp1 = imgaussfilt(R2_tmp.*(1-tmp),2.05).*0.93;
test = imgaussfilt(tmp,2);
R2_tmp2 = R2.*test+R2_tmp1;
R2= R2_tmp2;

Response = cat(3,Response,R2);
%% shift
mask = generate_mask(181,89);
split_data_for_shift();

D1 = 2;
s = linspace(-2,0,D1);
for n = 1:D1-1 
    p = interpolation_one(pleft,pright,R2,mask,s(n));
    Response = cat(3,Response,p);
end


D1 = 9;
s = linspace(0,m,D1);
s2 = linspace(-m,0,D1);
i = 15;
for n = 2:D1-1   
    p = interpolation(pleft,pright,pleft2,pright2,pmid,pmid2,mask,s(n),s2(n),m1);
    i = i+15/(D1-1);
    Response = cat(3,Response,p);
    i = i+15/(D1-1);
%     figure;imagesc(p);axis image
%     title(['degree:', num2str(i)]);
    clc;
end
Response = cat(3, Response,R2_1);

%% load in angular sensitive pixel (ASP) 2D responses
% angular response for the dominant polarization component (z)
data = load('polar_data/15.mat');
data1 = load('polar_data/30_1.mat');

sphericalz = data.data;
sphericalz1 = data1.data;

sphericalz = reorganize_data(sphericalz);
sphericalz1 = reorganize_data(sphericalz1,1);
coordinate_process();
R2 = rot90(R2,2);
R2 = R2./max(max(R2));
clc;

% f = figure; 
% imagesc(x2,y2,R2_1);
% axis image; axis off; colormap jet;
% export_fig(f,[outdir,'R2-response.png']);

%% shift
mask = generate_mask(181,89);
split_data_for_shift();

bg = 0.018;
s = linspace(0,m1,D);
s2 = linspace(-m1,0,D);
i = 15;
for n = 2:D-1   
    p = interpolation(pleft,pright,pleft2,pright2,pmid,pmid2,mask,s(n),s2(n),m1);
    i = i+15/(D-1);
    Response = cat(3,Response,p);
    i = i+15/(D-1);
%     figure;imagesc(p);axis image
%     title(['degree:', num2str(i)]);
    clc;
end
Response = cat(3, Response,R2_1);
%%

data = load('polar_data/30_1.mat');
data1 = load('polar_data/45.mat');

sphericalz = data.data;
sphericalz1 = data1.data;
sphericalz = reorganize_data(sphericalz,1);
sphericalz1 = reorganize_data(sphericalz1);
coordinate_process();
% f = figure; 
% imagesc(x2,y2,R2_1);
% axis image; axis off; colormap jet;
% export_fig(f,[outdir,'R2-response.png']);

%% shift

split_data_for_shift();

s = linspace(0,m2,D);
s2 = linspace(-m2,0,D);
i = 45;
for n = 2:D-1    
    p = interpolation(pleft,pright,pleft2,pright2,pmid,pmid2,mask,s(n),s2(n),m2);
    i = i+15/(D-1);
    Response = cat(3,Response,p);
%     figure;imagesc(p);axis image
%     title(['degree:', num2str(i)]);
    clc;
end
Response = cat(3, Response,R2_1);
%%
data = load('polar_data/45.mat');
data1 = load('polar_data/60.mat');

sphericalz = data.data;
sphericalz1 = data1.data;

sphericalz = reorganize_data(sphericalz);
sphericalz1 = reorganize_data(sphericalz1);
coordinate_process();
R2_1 = rot90(R2_1,2);
R2_1 = R2_1./max(max(R2_1));

clc;
% 
% f = figure; 
% imagesc(x2,y2,R2_1);
% axis image; axis off; colormap jet;
% export_fig(f,[outdir,'R2-response.png']);

%% shift
split_data_for_shift();

bg = 0.018;
s = linspace(0,m3,D);
s2 = linspace(-m3,0,D);
i = 45;

for n = 2:D-1
    p = interpolation(pleft,pright,pleft2,pright2,pmid,pmid2,mask,s(n),s2(n),m3);
    i = i+15/(D-1);
    Response = cat(3,Response,p);
%     figure;imagesc(p);axis image
%     title(['degree:', num2str(i)]);
    clc;
end
Response = cat(3, Response,R2_1);

% for i = 1:21
% f = figure;imagesc(Response(:,:,i));axis image;colormap jet;axis off;
% end
%% more data 
data = load('polar_data/60.mat');
data1 = load('polar_data/65.mat');

sphericalz = data.data;
sphericalz1 = data1.data;

sphericalz = reorganize_data(sphericalz);
sphericalz1 = reorganize_data(sphericalz1);
coordinate_process();
R2 = rot90(R2,2);
R2 = R2./max(max(R2));

clc;

split_data_for_shift();
m4 = 8;
bg = 0.018;
D = 4;
s = linspace(0,m4,D);
s2 = linspace(-m4,0,D);
i = 45;

for n = 2:D-1
    p = interpolation(pleft,pright,pleft2,pright2,pmid,pmid2,mask,s(n),s2(n),m3);
    Response = cat(3,Response,p);
%     figure;imagesc(p);axis image
%     title(['degree:', num2str(i)]);
    clc;
end
Response = cat(3, Response,R2_1);
%%

x_kk=x22;
y_kk=y22;
rho_xy = sqrt(x_kk.^2+y_kk.^2);
rho_xy(rho_xy>=1) = 1;
rho_angle = asind(rho_xy);
x_angle2 = x_kk.*(rho_angle./rho_xy);
y_angle2 = y_kk.*(rho_angle./rho_xy); 
x_angle2(isnan(x_angle2)) = 0;
y_angle2(isnan(y_angle2)) = 0;

x3 = linspace(-90,90,181);
y3 = linspace(-90,90,181);
[x33,y33] = meshgrid(x3,y3);

dim = size(Response);
Response_angle  = [];
for i = 1:dim(3)
R_angle2 = griddata(x_angle2,y_angle2,Response(:,:,i).*mask,x33,y33); 
R_angle2(isnan(R_angle2)) = 0;
clc;
Response_angle = cat(3, Response_angle,R_angle2);
end 

%save response Response Response_angle
%%
load('response.mat')
mask = generate_mask(400,199);


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
Response_angle_L  = [];
Response_L  = [];
for i = 1:dim(3)
tmp = Response(:,:,i);
tmp = imresize(tmp,[400 400],'bicubic');
R_angle2 = griddata(x_angle2,y_angle2,tmp.*mask,x33,y33); 
R_angle2(isnan(R_angle2)) = 0;
clc;
Response_L = cat(3, Response_L,tmp);
Response_angle_L = cat(3, Response_angle_L,R_angle2);
end 