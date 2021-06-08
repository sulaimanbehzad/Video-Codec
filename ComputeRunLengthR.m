function [I_runcode] = ComputeRunLengthR(I_runcode,A,B,imX, imY,n)
% Run-Length Decoding of the compressed image.
for a=1:imY/B
    for b=1:imX/A
        enc_str=I_runcode(a,b).code;
        % Computing the length of the encoded string.
        enc_len=length(enc_str);
        
        % Since Max. Count is unknown at the receiver, Number of bits used for each 
        % count value is unknown and hence cannot be decoded directly. Number of bits 
        % used for each count can be found out by trial and error method for all 
        % the possible lengths => factors of encoded string length.
        % Computing the non-trivial factors of the "enc_len" (length of encoded
        % string) i.e., factors other than 1 & itself.
        factors_mat=zeros(1,0);
        if enc_len<=(n+1)
            realfact=enc_len;
        else
            for i=2:enc_len-2       % "enc_len-1" is always not a divisor of "enc_len".
                if(rem(enc_len,i)==0)
                    factors_mat=[factors_mat,i];
                end
            end
            % Trial and Error Method to Find the Exact count value.
            for i=1:length(factors_mat)
                flagcntr=0;
                temp_dim=enc_len/factors_mat(i);
                for j=1:temp_dim
                    if strcmp(enc_str(1+(j-1)*factors_mat(i):j*factors_mat(i)),dec2bin(0,factors_mat(i)))==0
                        if j==1
                            flagcntr=flagcntr+1;
                        else
                            if enc_str((j-1)*factors_mat(i))~=enc_str(j*factors_mat(i))
                                flagcntr=flagcntr+1;
                            else
                                break;
                            end
                        end
                    else
                        break;
                    end
                end
                if flagcntr==temp_dim
                    realfact=factors_mat(i);
                    break;
                end
            end
        end
        
        % Clearing unused variables from Memory space
        clear factors_mat flagcntr j 
        % Finding out the count values of corresponding symbols in the encoded
        % string and then decoding it accordingly.
        dec_str=zeros(1,0);
        temp_dim=enc_len/realfact;
        for i=1:temp_dim
            count_str=enc_str(1+(i-1)*realfact:(i*realfact)-1);
            countval=bin2dec(count_str);
            for j=1:countval
                dec_str=[dec_str,enc_str(i*realfact)];
            end
        end
        I_runcode(a,b).code=dec_str;
    end
end

