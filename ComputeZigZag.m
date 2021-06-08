function [I_zigzag] = ComputeZigZag(I_Trsfrm, A, B, m, n)
size(I_Trsfrm)
[imX, imY] = size(I_Trsfrm);
for a=1:imX/B
    for b=1:imY/A
        I_zigzag(a,b).block=zeros(1,0);
        freq_sum=2:(B+A);
        counter=1;
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
                        if I_Trsfrm(a,b).block(x_indices(p),y_indices(p))<0
                            bin_eq=dec2bin(bitxor(2^n-1,abs(I_Trsfrm(a,b).block(x_indices(p),y_indices(p)))),n);
                        else
                            bin_eq=dec2bin(I_Trsfrm(a,b).block(x_indices(p),y_indices(p)),n);
                        end
%                         size(bin_eq)
                        I_zigzag(a,b).block=[I_zigzag(a,b).block,bin_eq(1:m)];
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
                        if I_Trsfrm(a,b).block(x_indices(p),y_indices(p))<0
                            bin_eq=dec2bin(bitxor(2^n-1, uint8(abs(I_Trsfrm(a,b).block(x_indices(p),y_indices(p)))),n));
                        else
                            bin_eq=dec2bin(I_Trsfrm(a,b).block(x_indices(p),y_indices(p)),n);
                        end
                        I_zigzag(a,b).block=[I_zigzag(a,b).block,bin_eq(1:m)];
                    end
            end
        end
    end
end
