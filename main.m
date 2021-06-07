clear all;
close all;
clc;

imageFiles = dir('grayscale/*.png');
nImages = length(imageFiles);
imageDir = imageFiles.folder;
for i=1:nImages
    curImageName = [imageDir '\' imageFiles(i).name];
%     printf(string(curImageName));
    curImage = imread(curImageName);
%     change image to do
    curImageDouble = im2double(curImage);
    dct2(
%     dct{i}=ComputeDCT(curImageDouble);
    images{i}=curImage;
end