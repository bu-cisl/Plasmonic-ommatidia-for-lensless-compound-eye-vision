function mask = generate_mask(size,radius,center)
    if nargin == 2   % if the number of inputs equals 2
      center = [ceil(size/2),ceil(size/2)]; % then make the third value, z, equal to my default value, 5.
    end
    [x1,y1] = meshgrid(1:size,1:size);
    mask = ones(size,size);
    mask(((x1-center(1)).^2+(y1-center(2)).^2) >= radius^2) = 0;
end