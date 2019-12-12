%%  broadband 5 percent

load('broadband.mat')
load('Response.mat')
mu = 0;

[x1,y1] = meshgrid(1:400,1:400);
mask_final = ones(400,400);
mask_final(((x1-200.5).^2+((y1-200.5).^2) > 200^2)) = 0;
for i =1:length(drx_5)
    rx_angle = drx_10(i);
    mask = Response(:,:,i);
    rx= 200*rx_angle;
    %rx= 200.*(sin(theta+1/2*rx_angle)-sin(theta-1/2*rx_angle));
    sigma = rx/2.355;
    x = -3*sigma:1:3*sigma;
    kernel = normpdf(x,mu,sigma);
    
    mask(mask>max(max(mask)).*0.15)=1;
    mask(mask<1)=0;
    mask(:,1:150) = 0;
    %mask = imgaussfilt(mask,1);
    mask(mask>0)=1;
    %mask2 = imgaussfilt(mask,3);
    tmp = Response(:,:,i).*mask;
    tmp2 = Response(:,:,i);
    for m = 1: size(tmp,1)
        signal1 = tmp(m,:);
        signal2 = tmp2(m,:);
        signal3 = mask(m,:);
        tmp(m,:)=conv(signal1,kernel,'same');
        tmp2(m,:)=conv(signal2,kernel,'same');
        mask2(m,:)=conv(signal3,kernel,'same');
    end
   mask2(mask2>0.05)=1;
   mask2(mask2<1)=0;
   mask2 = imgaussfilt(mask2,5);
   Response_tmp1(:,:,i) = tmp.*mask2+Response(:,:,i).*(1-mask2);
   Response_tmp2(:,:,i) = tmp2.*mask_final;
   % Response_tmp(:,:,i) = tmp.*mask2+Response(:,:,i).*(1-mask2);
end
save Response_5p Response_tmp2

%%  broadband 10 percent

mu = 0;

[x1,y1] = meshgrid(1:400,1:400);
mask_final = ones(400,400);
mask_final(((x1-200.5).^2+((y1-200.5).^2) > 200^2)) = 0;
for i =1:length(drx_10)
    rx_angle = drx_10(i);
    mask = Response(:,:,i);
    rx= 200*rx_angle;
    %rx= 200.*(sin(theta+1/2*rx_angle)-sin(theta-1/2*rx_angle));
    sigma = rx/2.355;
    x = -3*sigma:1:3*sigma;
    kernel = normpdf(x,mu,sigma);
    
    mask(mask>max(max(mask)).*0.15)=1;
    mask(mask<1)=0;
    mask(:,1:150) = 0;
    %mask = imgaussfilt(mask,1);
    mask(mask>0)=1;
    %mask2 = imgaussfilt(mask,3);
    tmp = Response(:,:,i).*mask;
    tmp2 = Response(:,:,i);
    for m = 1: size(tmp,1)
        signal1 = tmp(m,:);
        signal2 = tmp2(m,:);
        signal3 = mask(m,:);
        tmp(m,:)=conv(signal1,kernel,'same');
        tmp2(m,:)=conv(signal2,kernel,'same');
        mask2(m,:)=conv(signal3,kernel,'same');
    end
   mask2(mask2>0.05)=1;
   mask2(mask2<1)=0;
   mask2 = imgaussfilt(mask2,5);
   Response_tmp1(:,:,i) = tmp.*mask2+Response(:,:,i).*(1-mask2);
   Response_tmp2(:,:,i) = tmp2.*mask_final;
   % Response_tmp(:,:,i) = tmp.*mask2+Response(:,:,i).*(1-mask2);
end
save Response_10p Response_tmp2