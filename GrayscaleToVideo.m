clear;
close all;
clc;
inputPath = 'C:\Users\lenovo\Documents\MATLAB\Video-Codec\recreated';
vidWriter = VideoWriter('RecreatedVideo');
vidWriter.FrameRate = 1;
% secsPerImage = 5;
open(vidWriter);


recreatedImages = dir('recreated/*.png');
nFiles = length(recreatedImages);
recDir = recreatedImages.folder;
for i=1:nFiles
    curFileName = [recDir '\' recreatedImages(i).name];
    images{i} = imread(curFileName);
end
for k=1:length(images)
    frame = im2frame(images{k});
    writeVideo(vidWriter,frame);
end
close(vidWriter);

