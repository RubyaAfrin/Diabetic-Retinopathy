function [ delete_od_img ] = delete_od_func( od_img,input_img )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
RGB_Image = uint8( od_img(:,:,[1 1 1]) * 255 );


    
g=rgb2gray(RGB_Image);
%figure,imshow(g),title('img');
[centers, radii] = imfindcircles(g,[5 30],'ObjectPolarity','bright','Sensitivity',.939);
h = viscircles(centers,radii);
noOfCircles = length(centers);
if(noOfCircles>0)
p = centers(1,1);
q = centers(1,2);
[r,c]=size(g);
g=zeros(r,c);
    for i=1:r
        for j=1:c
             if((i==round(q) && j==round(p)))
                 for x=i-200:i+200
                     for y =j-90:j+70
                         g(x,y)=1;
                     end
                 end
                    
                    
            end
          %268 462
           
        end
    end
 % figure,imshow(g),title('img g');
  
RGB_Image_new = uint8(g(:,:,[1 1 1]) * 255 );
delete_od_img = input_img-RGB_Image_new;
%figure, imshow(delete_od_img),title('delete_od_img');
else
    RGB_Image = uint8( od_img(:,:,[1 1 1]) * 255 );
delete_od_img = input_img-RGB_Image;
figure, imshow(delete_od_img),title('delete_od_img');
end
end

	