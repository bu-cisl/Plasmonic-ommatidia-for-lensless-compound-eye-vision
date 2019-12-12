    
function    p = interpolation(pleft,pright,pleft2,pright2,pmid,pmid2,mask,shift1,shift2,m)
    p1left = imtranslate(pleft,[-shift1,0]);
    p1right = imtranslate(pright,[shift1,0]);
    p1 =  zeros(181,181);
    p1(:,1:90) = p1left(:,1:90);
    p1(:,92:181) = p1right(:,92:181);
    shift1_tmp = shift1;
    shift1 =ceil(shift1);
    d = size(p1(:,91-shift1:91+shift1));
    p1(:,91-shift1:91+shift1) = repmat(pmid(:,91),1,d(2));
    [mask1,mask2] = blending_bgmask(shift1,shift2,mask);
    p1_tmp = mask1.*p1;
    p1 = ((m-shift1_tmp)/m).*p1;
    p1 = p1+p1_tmp.*(1-((m-shift1_tmp)/m));
    
    p2left = imtranslate(pleft2,[-shift2,0]);
    p2right = imtranslate(pright2,[shift2,0]);
    shift2 =ceil(abs(shift2));
    mask_blendcent()
    p2l_tmp = mask_tmp1.*p2left;
    p2r_tmp = mask_tmp2.*p2right;
    p2 = p2l_tmp+p2r_tmp;
%     p2(:,1:90)=p2left(:,1:90);
%     p2(:,92:181)=p2right(:,92:181);
%     d = size(p2(:,91-shift1:91:92+shift1));
%     p2(:,91-shift1:91:92+shift1) = repmat(pmid2(:,91),1,d(2));
    p2 = (shift1_tmp/m).*p2.*mask2;
    p = p1+p2;
    %p(p<0.002)=bg;
    p = mask.*p;
end