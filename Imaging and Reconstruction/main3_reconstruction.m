%% reconstruction with pseudo inverse
load('SVD.mat')
load('noisy_measurement.mat')

N = 400;

%% 
mu = 0.2:0.2:4;
%mu = 8:0.5:15;
x_fdn_tsvd_1 = zeros(N,N,length(mu));
q = 2;
for k = 1:size(Im_noisy_tot,2)
    tmp = squeeze(Im_noisy_tot(:,k,q));
    for i = 1:length(mu)    
        svd_num1 = sum(sv1>=mu(i));
        x_fdn_tsvd_1(:,:,i) = ...
        reshape(v_ud1(:,1:svd_num1)*((u_ud1(:,1:svd_num1)'*tmp)./sv1(1:svd_num1)),N,N);
    end
    filename = ['obj',num2str(k)];
    result = struct(filename,x_fdn_tsvd_1);
end   
save SNR56 result 

%% result 2 
mu = 0.05:0.1:3;

x_fdn_tsvd_1 = zeros(N,N,length(mu));
q = 3;
for k = 1:size(Im_noisy_tot,2)
    tmp = squeeze(Im_noisy_tot(:,k,q));
    for i = 1:length(mu)    
        svd_num1 = sum(sv1>=mu(i));
        x_fdn_tsvd_1(:,:,i) = ...
        reshape(v_ud1(:,1:svd_num1)*((u_ud1(:,1:svd_num1)'*tmp)./sv1(1:svd_num1)),N,N);
    end
    filename = ['obj',num2str(k)];
    result = struct(filename,x_fdn_tsvd_1);
end
save SNR63 result 

%% result 3
mu = 0.005:0.05:1;

x_fdn_tsvd_1 = zeros(N,N,length(mu));
q = 4;
for k = 1:size(Im_noisy_tot,2)
    tmp = squeeze(Im_noisy_tot(:,k,q));
    for i = 1:length(mu)    
        svd_num1 = sum(sv1>=mu(i));
        x_fdn_tsvd_1(:,:,i) = ...
        reshape(v_ud1(:,1:svd_num1)*((u_ud1(:,1:svd_num1)'*tmp)./sv1(1:svd_num1)),N,N);
    end
    filename = ['obj',num2str(k)];
    result = struct(filename,x_fdn_tsvd_1);
end
save SNR73 result 



