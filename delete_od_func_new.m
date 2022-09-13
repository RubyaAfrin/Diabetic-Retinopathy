function [ delete_od_img ] = delete_od_func_new( od_img,input_img )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
RGB_Image = uint8( od_img(:,:,[1 1 1]) * 255 );
delete_od_img = input_img-RGB_Image;
%figure, imshow(delete_od_img),title('delete_od_img');
end
	