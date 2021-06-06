clc;
clear all;

vidPath = fullfile('\sample video\sample 30 frame 1 min.mp4');
if (! exist (vidPath, "file"))
   warning ("'%s' doesn't exist, running demo VideoWriter first...", vidPath);
   demo ("VideoWriter");
vid = VideoReader(vidPath);
vidX = vid.Height;
vidY = vid.Width;
numFrames = vid.NumberOfFrames;