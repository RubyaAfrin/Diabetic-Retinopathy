function [ CA ] = vesselsdetection_func1( img );
greenc = img(:,:,2);                          % Extract Green Channel
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

level = graythresh(I3);                     % Gray Threshold
bw = im2bw(I3,level);                       % Binarization
%figure,imshow(bw),title('bw');
bw = bwareaopen(bw, 30);                    % Morphological Open
% figure,imshow(bw);
%figure,imshow(bw),title('bw1');

wname = 'sym4';
[CA,CH,CV,CD] = dwt2(bw,wname,'mode','per');
%figure,imshow(CA),title('Approximate');


b = bwboundaries(bw);
% axes(handles.axes5);
%I = imresize(I,[500 752]);
%figure,imshow(I)
hold on

for k = 1:numel(b)
    %plot(b{k}(:,2), b{k}(:,1), 'b', 'Linewidth', .1)
end

end
