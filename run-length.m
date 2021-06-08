for a=1:I_dim(1)/N
    for b=1:I_dim(2)/M
        
        % Computing the Count values for the corresponding symbols and
        % savin them in "I_run" structure.
        count=0;
        run=zeros(1,0);
        sym=I_zigzag(a,b).block(1);
        j=1;
        block_len=length(I_zigzag(a,b).block);
        for i=1:block_len
            if I_zigzag(a,b).block(i)==sym
                count=count+1;
            else
                run.count(j)=count;
                run.sym(j)=sym;
                j=j+1;
                sym=I_zigzag(a,b).block(i);
                count=1;
            end
            if i==block_len
                run.count(j)=count;
                run.sym(j)=sym;
            end
        end 
        
        % Computing the codelength needed for the count values.
        dim=length(run.count);  % calculates number of symbols being encoded.
        maxvalue=max(run.count);  % finds the maximum count value in the count array of run structure.
        codelength=log2(maxvalue)+1;
        codelength=floor(codelength);
        
        % Encoding the count values along with their symbols.
        I_runcode(a,b).code=zeros(1,0);
        for i=1:dim
            I_runcode(a,b).code=[I_runcode(a,b).code,dec2bin(run.count(i),codelength),run.sym(i)];
        end
    end
end