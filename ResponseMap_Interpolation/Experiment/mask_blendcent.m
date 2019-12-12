mask_tmp = ones(181,181);
s =linspace(1,0, shift2*2+1);
mask_tmp(:,91-shift2:91+shift2) = repmat(s,181,1);
mask_tmp(:,91+shift2+1:end)=0;

mask_tmp1 = mask_tmp;
mask_tmp2 = 1-mask_tmp;

