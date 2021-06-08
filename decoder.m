clear;
close all;
clc;

encodedFiles = dir('runlength/*.mat');
nFiles = length(encodedFiles);
encodedDir = encodedFiles.folder;
for i=1:nFiles
%     Dimensions for DCT blocksize
    A=8;
    B=8;
%     Image dimesnsions
    imX=512;
    imY=512;
    curFileName = [encodedDir '\' encodedFiles(i).name];
    curRL = load(curFileName);
    curRL = curRL.curRunLength;
    curZigZag = ComputeRunLengthR(curRL, A, B, imX, imY, 10);
    curTransformInv = ComputeZigZagR(curZigZag,A,B,imX,imY,8,10);
    curRecreatedImage = ComputeDCTR(curTransformInv,imX,imY, A, B);
    curRecreatedImage = curRecreatedImage/max(max(curRecreatedImage));
    curRecreatedImage = im2uint8(curRecreatedImage);
    figure, imshow(curRecreatedImage);
%     curImage = imread(curImageName);
%     curImage = imresize(curImage, [512, 512]);
% %     change image to do
%     curImageDouble = im2double(curImage);
% % Dimensions for DCT blocksize
%     A=8;
%     B=8;
%     curDct=ComputeDCT(curImageDouble, A, B);
%     [imX, imY] = size(curImageDouble);
%     curZigZag = ComputeZigZag(curDct, A, B, imX, imY, 8, 10);
%     curRunLength = RunLength(curZigZag, A, B, imX, imY);
%     save(['runlength/' encodedFiles(i).name '.txt'], 'curRunLength');
%     fprintf(fileID, curRunLength);
%     disp(curRunLength)
%     images{i}=curImage;
end