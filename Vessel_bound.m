input_img = imread('im0009.jpg');
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%figure,imshow(input_img),title('input_img');	
greenc = input_img(:,:,2);                          % Extract Green Channel
ginv = imcomplement (greenc);               % Complement the Green Channel
adahist = adapthisteq(ginv);                % Adaptive Histogram Equalization
%figure,imshow(adahist),title('adahist');
se = strel('ball',10,10);                     % Structuring Element
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
bw = im2bw(I3,.45);                       % Binarization
%figure,imshow(bw),title('bw');
se3 = strel('disk',4);
img_open = imopen(bw,se3);
%figure,imshow(img_open),title('img_open');

bw1 = bwareaopen(bw, 280);
%figure,imshow(bw1),title('bw1');
n_u =  img_open-bw1;

%figure,imshow(BW_10_test),title('without bessels.................');
b = bwboundaries(n_u);
% axes(handles.axes5);
RGB_Image = uint8( n_u(:,:,[1 1 1]) * 255 );
%I = imresize(I,[500 752]);
figure,imshow(n_u);
hold on

for k = 1:length(b)
   % plot(b{k}(:,2), b{k}(:,1), 'b', 'Linewidth', 2)
end



