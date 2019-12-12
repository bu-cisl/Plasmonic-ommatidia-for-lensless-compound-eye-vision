function mask1 = blending_bgmask_one(shift2,mask)
    pleft = zeros(size(mask));
    dim = size(mask);
    pleft(:,1:200) = mask(:,1:round(dim(2)/2));
    pright = zeros(dim);
    shift2 = shift2-1;
    pright(:,round(dim(2)/2)+1:dim(2))= mask(:,round(dim(2)/2)+1:dim(2));
    p1left = pleft;
    p1right =pright;
    p1left = imtranslate(p1left,[-5,0]);
    p1right = imtranslate(p1right,[5,0]);
    p2left = imtranslate(pleft,[-shift2,0]);
    p2right = imtranslate(pright,[shift2,0]);
    mask2 = p1left+p1right-(p2left+p2right);
    mask2(mask2<=0)=0;
    mask1 = imgaussfilt(mask2,1.2);
    
end