clear
close all;
clc;

imageFiles = dir('grayscale/*.png');
nImages = length(imageFiles);
imageDir = imageFiles.folder;
for i=1:nImages-48
    curImageName = [imageDir '\' imageFiles(i).name];
%     printf(string(curImageName));
    curImage = imread(curImageName);
    curImage = imresize(curImage, [512, 512]);
%     change image to do
    curImageDouble = im2double(curImage);
% Dimensions for DCT blocksize
    A=8;
    B=8;
    curDct=ComputeDCT(curImageDouble, A, B);
    disp(curDct)
    images{i}=curImage;
end