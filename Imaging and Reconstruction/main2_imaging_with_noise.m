%% read Response 

%load('response.mat');
load('response_angle.mat');
addnoise = @(x,SNR) sqrt(mean(x.^2))./SNR*randn(size(x))+x;
n_phi = 120;
%% read data 
load('object_all.mat')
dim = size(Response_angle);
N = dim(2);
%% Reconstruction
Response2 = Response_angle;
rot = linspace(0,360-360/n_phi,n_phi);
M1 = [];
Im = zeros(n_phi*dim(3),size(obj,3));
k = 1;
for m = 1:n_phi
    for n = 1:dim(3)           
        data = Response2(:,:,n);
        pnew1 = imrotate(data,rot(m),'bilinear','crop');
        for q = 1: size(obj,3)
            Im(k,q) = sum(sum(pnew1.*obj(:,:,q)));       
        end
        k = k+1;
        M1 = [M1;pnew1(:).'];
    end 
end 
clear k
% % analysis the singular values
[u_ud1,s_ud1,v_ud1] = svd(M1,'econ');
% 
sv1 = diag(s_ud1);


% save('Matric.mat','M1','-v7.3')
save('SVD.mat','sv1','u_ud1','s_ud1','v_ud1','-v7.3')
save noise_free_measurement Im 

%%
dim = size(Im,1);
SNR = [631, 1413, 4467];
dim3 = length(SNR);
Im_noisy_tot = zeros(size(Im,1),size(Im,2),dim3);
for i = 1:dim3
    for q = 1:size(Im,2)
        Im_noisy_tot(:,q,i)=addnoise(Im(:,q),SNR(i));
    end
end
save noisy_measurement Im_noisy_tot 