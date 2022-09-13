input_img = imread('image005.png');
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%figure,imshow(input_img),title('input_img');	
g = input_img(:,:,2);                          % Extract Green Channel
r = input_img(:,:,1);
histmatch_img = imhistmatch (g,r);
%figure,imshow(histmatch_img),title('histmatch_img');
%Low_High = stretchlim(histmatch_img);
adjust_img = imadjust(histmatch_img);
%figure,imshow(adjust_img),title('adjust_img');
pre_img = medfilt2(adjust_img);
%figure,imshow(pre_img),title('pre_img'); 
ginv = imcomplement (pre_img);               % Complement the Green Channel
adahist = adapthisteq(ginv);                % Adaptive Histogram Equalization
%figure,imshow(adahist),title('adahist');
se = strel('ball',13,13);                     % Structuring Element
gopen = imopen(adahist,se);                 % Morphological Open
%figure,imshow(gopen),title('gopen');
godisk = adahist - gopen;                   % Remove Optic Disk
%figure,imshow(godisk),title('od');

medfilt = medfilt2(godisk); 
%figure,imshow(medfilt),title('medfilt');         %2D Median Filter
background = imopen(medfilt,strel('disk',15));% imopen function
%figure,imshow(background),title('background');
I2 = medfilt - background;                  % Remove Background
%figure,imshow(I2),title('I2');
I3 = imadjust(I2);                          % Image Adjustment
%figure,imshow(I3),title('I3');

                   % Gray Threshold
bw = im2bw(I3,.47);                       % Binarization
figure,imshow(bw),title('bw');
se3 = strel('disk',3);
img_open = imopen(bw,se3);
figure,imshow(img_open),title('img_open');

bw1 = bwareaopen(bw,200);
figure,imshow(bw1),title('bw1');
n_u = bw -img_open;
figure,imshow(n_u),title('nu');
bwf= bwareaopen(bw, 200);
area1 = bwarea(bw);
area2 = bwarea(bwf);                    % Morphological Open
HM_area = area1-area2;
%figure,imshow(bw),title('bw1');
%BW_10_test = bwareaopen(bw,150);
HM_img =bw;
RGB_Image = uint8( n_u(:,:,[1 1 1]) * 255 );
new_image =input_img-RGB_Image;
%figure,imshow(new_image),title('new_image');
n = input_img-new_image;
%figure,imshow(n),title('new_image');
f = RGB_Image+input_img;
ImgR = f(:, :, 1);
ImgG = f(:, :, 2);
ImgB = f(:, :, 3);
[M N]= size(f);
 
%Get location of pure red pixels
Rmask = logical(zeros(M, N));
Rmask = (ImgR == 255 & ImgG == 255 & ImgB == 255);
 
%Replace the pixels with some other color
ImgR(Rmask) = 0;
ImgG(Rmask) = 255;
ImgB(Rmask) = 125;
%Combine into a new image
Img_new(:, :, 1) = ImgR;
Img_new(:, :, 2) = ImgG;
Img_new(:, :, 3) = ImgB;
HM_img = Img_new;
figure,imshow(HM_img),title('HM_img');
%figure,imshow(BW_10_test),title('without bessels.................');
b = bwboundaries(n_u);
% axes(handles.axes5);
%I = imresize(I,[500 752]);
%figure,imshow(n_u);
hold on

for k = 1:numel(b)
   % plot(b{k}(:,2), b{k}(:,1), 'b', 'Linewidth', .1)
end



