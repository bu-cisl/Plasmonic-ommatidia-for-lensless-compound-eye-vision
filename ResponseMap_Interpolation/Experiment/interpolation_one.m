function    p = interpolation_one(pleft,pright,R2,mask,shift1)
    
    p1left = imtranslate(pleft,[-shift1,0]);
    p1right = imtranslate(pright,[shift1,0]);
    p1 =  zeros(400,400);
%     p1(:,1:200) = p1left(:,1:200);
%     p1(:,201:400) = p1right(:,201:400);
    mask1 = blending_bgmask_one(shift1,mask);
    %shift1_tmp = shift1;
    shift2 = ceil(-shift1-1);
    mask_blendcent()
    p2l_tmp = mask_tmp1.*p1left;
    p2r_tmp = (1-mask_tmp1).*p1right;
    p1 = p2l_tmp+p2r_tmp;
    p = mask.*p1+mask1.*R2;
end