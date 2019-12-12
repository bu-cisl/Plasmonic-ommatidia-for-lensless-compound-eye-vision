mask_tmp = ones(400,400);
s =linspace(1,0,-shift2*2);
mask_tmp(:,201+shift2:200-shift2) = repmat(s,400,1);
mask_tmp(:,201-shift2:end)=0;
mask_tmp1 = imgaussfilt(mask_tmp,5);
mask_tmp2 = 1-mask_tmp;

%mask_tmp1 = mask_tmp;
