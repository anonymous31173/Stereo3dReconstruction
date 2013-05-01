function [ R, imgD, imgS ] = focalFix(imgPathD, imgPathS)
%takes the path to two images that need to be fixed for focal lengths
%   Returns the two post-op images and their focal scale R

imgD = imresize(imread(imgPathD),.25);
imgS = imresize(imread(imgPathS),.25);

%get the exif data from the pictures
exif1 = imfinfo(imgPathD);
exif2 = imfinfo(imgPathS);

%get focal length camera used for pictures 
focalLengthD = exif1.DigitalCamera.FocalLength;
focalLengthS = exif2.DigitalCamera.FocalLength;

%calculate the focal ratio R
R = focalLengthD/focalLengthS;

%if R > 1, then shrink the image Id by R times.
if R > 1
    imgD = imresize(imgD,(1/R),'nearest');
%if R < 1, then shrink the image Is by 1/R times
elseif R < 1
    imgS = imresize(imgS,(R),'nearest');
end

end

