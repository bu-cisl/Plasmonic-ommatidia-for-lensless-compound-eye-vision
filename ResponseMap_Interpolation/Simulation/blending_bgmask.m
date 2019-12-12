function [mask1,mask2] = blending_bgmask(shift1,shift2,mask)
    pleft = zeros(size(mask));
    dim = size(mask);
    pleft(:,1:200) = mask(:,1:round(dim(2)/2));
    pright = zeros(dim);
    shift2 = shift2+3;
    pright(:,round(dim(2)/2)+1:dim(2))= mask(:,round(dim(2)/2)+1:dim(2));
    p1left = imtranslate(pleft,[-shift1,0]);
    p1right = imtranslate(pright,[shift1,0]);
    p2left = imtranslate(pleft,[-shift2,0]);
    p2right = imtranslate(pright,[shift2,0]);
    
    mask1 = (p1left+p1right -p2left-p2right).*mask;
    mask1(mask1<1)=0;
    mask1 = imgaussfilt(mask1,7);
    
    shift2 = shift2-7;
    p2left = imtranslate(pleft,[-shift2,0]);
    p2right = imtranslate(pright,[shift2,0]);
    mask2 = p2left+p2right;
    mask2(mask2>=1)=1;
    mask2 = imgaussfilt(mask2,5);
    
end
