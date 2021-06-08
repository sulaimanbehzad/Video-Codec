function [im_transform] = ComputeDCT(img, A, B)
% This function computes the DCT coefficients
[imX, imY] = size(img);
im_transform.block = zeros(A,B);
normalization_matrix=[
    16 11 10 16 24 40 51 61
    12 12 14 19 26 58 60 55
    14 13 16 24 40 57 69 56
    14 17 22 29 51 87 80 62
    18 22 37 56 68 109 103 77
    24 35 55 64 81 104 113 92
    49 64 78 87 103 121 120 101
    72 92 95 98 112 100 103 99];
for a=1:imY/A
    for b=1:imX/B
        for k=1:A
            for l=1:B
                res=0;
                for i=1:A
                    for j=1:B
                        res=res+double(img(A*(a-1)+i,B*(b-1)+j))*cos(pi*(k-1)*(2*i-1)/(2*A))*cos(pi*(l-1)*(2*j-1)/(2*B));    
                    end
                     if k==1
                         res = res*sqrt(1/A);
                     else
                         res = res*sqrt(2/A);
                     end
                     if l==1
                         res = res*sqrt(1/B);
                     else
                         res = res*sqrt(2/B);
                     end
                     im_transform(a,b).block(k,l)=res;
                end
            end
        end
        im_transform(a,b).block = round(im_transform(a,b).block./normalization_matrix);
    end
end
