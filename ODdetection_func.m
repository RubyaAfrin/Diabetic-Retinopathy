function [od_img ] = ODdetection_func( pre_img )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here



% Erision technique
se1 = strel('disk',5);        
img_eroded = imerode(pre_img,se1);
%figure, imshow(img_eroded), title('image erision');

% closing technique
se = strel('disk',10);
img_close = imclose(img_eroded,se);
%figure, imshow(img_close),title('image closeing');

% closing technique
se3 = strel('disk',10);
img_open = imopen(img_close,se3);
%figure, imshow(img_open),title('image opening ');

% binary image
od_img = im2bw(img_open,0.96);

%figure,imshow(od_img),title('optic disk detected');

end

