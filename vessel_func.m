

%old code
greenc = I(:,:,2);                          % Extract Green Channel
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
figure,imshow(I3),title('I3');

level = graythresh(I3);                     % Gray Threshold
bw = im2bw(I3,.47);                       % Binarization
figure,imshow(bw),title('bw');
bw = bwareaopen(bw, 30);                    % Morphological Open
figure,imshow(bw),title('bw1');
end


