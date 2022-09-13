function [ MA_img, MA_area ] = MA_detection_func( input_img )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
	
greenC = input_img(:,:,2);
comp = imcomplement(greenC);
histe = adapthisteq(comp);
adjustImage = imadjust(histe,[],[],3);
comp = imcomplement(adjustImage);
J = imadjust(comp,[],[],4);
J = imcomplement(J);
J = imadjust(J,[],[],4);
K=fspecial('disk',5);
L=imfilter(J,K,'replicate');
L = im2bw(L,0.4);

M =  bwmorph(L,'tophat');
M = im2bw(M);
figure,imshow(M),title('M');
MA_area = bwarea(M);
disp(MA_area);
wname = 'sym4';
[CA,CH,CV,CD] = dwt2(M,wname,'mode','per');
%figure,imshow(CA),title('MMMM');
MA_img = CA;

RGB_Image = uint8( M(:,:,[1 1 1]) * 255 );
%figure, imshow(RGB_Image),title('Myyyyyy');

f = RGB_Image+input_img;
ImgR = f(:, :, 1);
ImgG = f(:, :, 2);
ImgB = f(:, :, 3);
[M N]= size(f);
       
 
%Get location of pure red pixels
Rmask = logical(zeros(M, N));
Rmask = (ImgR == 255 & ImgG == 255 & ImgB == 255);
 
%Replace the pixels with some other color
ImgR(Rmask) = 255;
ImgG(Rmask) = 255;
ImgB(Rmask) = 255;
%Combine into a new image
Img_new(:, :, 1) = ImgR;
Img_new(:, :, 2) = ImgG;
Img_new(:, :, 3) = ImgB;
Img_f  = im2bw(Img_new);
sum(M(:)==255);
MA_img = Img_new;
b = bwboundaries(CA);
%MA_img = imresize(input_img,[303 350]);

%figure, imshow(Img_f),title('Img f');
hold on
for area_bloodvessels = 1:numel(b)
    %plot(b{area_bloodvessels}(:,2), b{area_bloodvessels}(:,1), 'b', 'Linewidth', 1)
end 
end