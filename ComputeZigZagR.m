function [im_transform_reverce] = ComputeZigZagR(I_runcode, A, B,M,N,m,n)
[imX, imY] = size(img);

im_transform_reverce.block=zeros(N,M);
for a=1:imY/N
    for b=1:imX/M
        bpp=length(I_runcode(a,b).code)/(N*M);  % "bpp" is the bits-per-pixel in reconstruction of image.
        bpp_diff=n-bpp; 
        freq_sum=2:(N+M);
        counter=1;
        c_indx=1;
        for i=1:length(freq_sum)
            if i<=((length(freq_sum)+1)/2)
                if rem(i,2)~=0
                    x_indices=counter:freq_sum(i)-counter;
                else
                    x_indices=freq_sum(i)-counter:-1:counter;
                end
                    index_len=length(x_indices);
                    y_indices=x_indices(index_len:-1:1); % Creating reverse of the array as "y_indices".
                    for p=1:index_len
                        decm_eq=bin2dec([I_runcode(a,b).code(1+m*(c_indx-1):m*c_indx),dec2bin(0,bpp_diff)]);
                        if decm_eq>(2^(n-1))-1
                            decm_eq=decm_eq-(2^n-1);
                        end
                        im_transform_reverce(a,b).block(x_indices(p),y_indices(p))=decm_eq;
                       c_indx=c_indx+1;
                    end
            else
                counter=counter+1;
                if rem(i,2)~=0
                    x_indices=counter:freq_sum(i)-counter;
                else
                    x_indices=freq_sum(i)-counter:-1:counter;
                end
                    index_len=length(x_indices);
                    y_indices=x_indices(index_len:-1:1); % Creating reverse of the array as "y_indices".
                    for p=1:index_len
                        decm_eq=bin2dec([I_runcode(a,b).code(1+m*(c_indx-1):m*c_indx),dec2bin(0,bpp_diff)]);
                        if decm_eq>(2^(n-1))-1
                            decm_eq=decm_eq-(2^n-1);
                        end
                        im_transform_reverce(a,b).block(x_indices(p),y_indices(p))=decm_eq;
                        c_indx=c_indx+1;
                    end
            end
        end
    end
end

% Denormalizing the Reconstructed Tranform matrix using the same
% Normalization matrix.
for a=1:imY/N
    for b=1:imX/M
        im_transform_reverce(a,b).block=(I_rec_Trnsfm(a,b).block).*Norm_Mat;
    end
end

