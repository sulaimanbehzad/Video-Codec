function [block] = ComputeDCT(img)
%COMPUTEDCT Summary of this function goes here
%   Detailed explanation goes here
T = dctmtx(8);
dct =@(block_struct) T * block_struct.data * T';
block = blockproc(img, [8 8], dct);
% block = inputArg1;
end

