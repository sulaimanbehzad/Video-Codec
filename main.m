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
%     change image to do
    curImageDouble = im2double(curImage);
%     dct2(
% Dimensions for DCT blocksize
    A=8;
    B=8;
    dct{i}=ComputeDCT(curImageDouble, A, B);
    images{i}=curImage;
end