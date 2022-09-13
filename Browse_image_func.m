function [img] = Browse_image_func()
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

[filename pathname]=uigetfile({'*.jpg';'*.tif';'*.bmp';'*.png'},'Select an image');
filepath=strcat(pathname,filename);
 % input original image
img =imread(filepath);
img = imresize(img,[605 700]);

end