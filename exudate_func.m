function [ exudate_img,exudate_area ] = exudate_func( delete_od_img,input_img )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


g=delete_od_img(:,:,2);
%figure, imshow(g),title('green channel image');

%image adjust
img_imadjust = imadjust(g);
%figure, imshow(img_imadjust),title('Imadjust image');


% adaphistogram technique
img_adap = adapthisteq(g);
%figure, imshow(img_adap),title('adp_histo image');
img_com = imcomplement(img_adap);
%figure, imshow(img_com),title('img com');
img_imadjust = imadjust(img_com);
%figure, imshow(img_imadjust),title('img imadjust');
img_com1 = imcomplement(img_imadjust);
%figure, imshow(img_com1),title('img com1');
level = graythresh(img_com1);
bw=im2bw(img_com1,.999999999);
%figure, imshow(bw),title('bw');
se = strel('disk',2);
mo = imopen(bw,se);
exudate_area = bwarea(bw);
disp(exudate_area);
RGB_Image = uint8( mo(:,:,[1 1 1]) * 255 );
%figure, imshow(RGB_Image),title('RGB_Image');
fl =RGB_Image-delete_od_img-input_img;
%figure,imshow(fl),title('fl');
f =RGB_Image+input_img;
%g=rgb2gray(f);
%figure,imshow(f),title('f');
%[centers, radii] = imfindcircles(g,[5 15],'ObjectPolarity','dark','Sensitivity',.95);
%h = viscircles(centers,radii);
%figure, imshow(f),title('f');
ImgR = f(:, :, 1);
ImgG = f(:, :, 2);
ImgB = f(:, :, 3);
[M N] = size(f);
 
%Get location of pure red pixels
Rmask = logical(zeros(M, N));
Rmask = (ImgR == 255 & ImgG == 255 & ImgB == 255);
 
%Replace the pixels with some other color
ImgR(Rmask) = 0;
ImgG(Rmask) = 0;
ImgB(Rmask) = 255;
%Combine into a new image
Img_new(:, :, 1) = ImgR;
Img_new(:, :, 2) = ImgG;
Img_new(:, :, 3) = ImgB;
exudate_img = Img_new;
%figure, imshow(Img_new),title('final');
%imshow(delete_od_img);
%[centers, radii] = imfindcircles(delete_od_img, [25, 50], 'Sensitivity', .96);
%viscircles(centers, radii);

end
