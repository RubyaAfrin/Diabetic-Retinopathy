function [ HM_img,HM_area ] = HM_detection_func( input_img )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%figure,imshow(input_img),title('input_img');	
g = input_img(:,:,2);                          % Extract Green Channel
r = input_img(:,:,1);
%figure,imshow(r),title('r');
histmatch_img = imhistmatch (g,r);
%figure,imshow(histmatch_img),title('histmatch_img');
%Low_High = stretchlim(histmatch_img);
adjust_img = imadjust(histmatch_img);
%figure,imshow(adjust_img),title('adjust_img');
pre_img = medfilt2(adjust_img);
%figure,imshow(pre_img),title('pre_img'); 
ginv = imcomplement (pre_img);                 % Complement the Green Channel
%figure,imshow(ginv),title('ginv');
adahist = adapthisteq(ginv);                   % Adaptive Histogram Equalization
%figure,imshow(adahist),title('adahist');
se = strel('ball',13,13);                    % Structuring Element
gopen = imopen(adahist,se);                  % Morphological Open
%figure,imshow(gopen),title('gopen');
godisk = adahist - gopen;                    % Remove Optic Disk
%figure,imshow(godisk),title('od');

medfilt = medfilt2(godisk); 
%figure,imshow(medfilt),title('medfilt');         %2D Median Filter
background = imopen(medfilt,strel('disk',15));    % imopen function
%figure,imshow(background),title('background');
I2 = medfilt - background;                        % Remove Background
%figure,imshow(I2),title('I2');
I3 = imadjust(I2);                                % Image Adjustment
%figure,imshow(I3),title('I3');

                   % Gray Threshold
bw = im2bw(I3,.47);                       % Binarization
%figure,imshow(bw),title('bw');
se3 = strel('disk',1);
img_open_1 = imopen(bw,se3);
se4 = strel('disk',5);
img_open_2 = imopen(bw,se4);
%figure,imshow(img_open_1),title('img_open 1');
%figure,imshow(img_open_2),title('img_open 2');
bw1 = bwareaopen(bw,1000);
bw2 = bwareaopen(bw,300);
%figure,imshow(bw1),title('bw1');
MA_p = bw-img_open_1-img_open_2 ;
%BW2 = bwareafilt(MA_p,[10 15]);
%MA_new = MA_p - bwareaopen(MA_p,500);
HM =  img_open_2-bw1;
%figure,imshow(HM),title('HM');
%HM = ( MA_p-img_open_2-bw1)-HM1;                % Morphological Open
HM_area = bwarea(HM)-3000;
disp(HM_area);
%figure,imshow(bw),title('bw1');
%BW_10_test = bwareaopen(bw,150);
HM_img =bw;
RGB_Image = uint8( HM(:,:,[1 1 1]) * 255 );
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

%figure,imshow(BW_10_test),title('without bessels.................');
%b = bwboundaries(n_u);
% axes(handles.axes5);
%I = imresize(I,[500 752]);
%figure,imshow(n_u);
hold on

%for k = 1:numel(b)
   % plot(b{k}(:,2), b{k}(:,1), 'b', 'Linewidth', .1)
%end

end


