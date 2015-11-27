function [PC_back,cycle_back,intmem_back]=DecRegJumUnz(PC,cycle,intmem,promem,n)
    intmem_back=intmem;
    %load Rn,PSW
    PSW=loadPSW(intmem(209,1));
    
    if (PSW(4,1)==0 && PSW(5,1)==0)
        rn=intmem(n,1)-1;
        intmem_back(n,1)=rn;
    elseif (PSW(4,1)==0 && PSW(5,1)==1)
        rn=intmem(n+8,1)-1;
        intmem_back(n+8,1)=rn;
    elseif (PSW(4,1)==1 && PSW(5,1)==0)
        rn=intmem(n+16,1)-1;
        intmem_back(n+16,1)=rn;
    elseif (PSW(4,1)==1 && PSW(5,1)==1)
        rn=intmem(n+24,1)-1;
        intmem_back(n+24,1)=rn;
    end
    rel=promem(PC+1,1);
    if(rn~=0)
        PC_back=PC+2+rel;
        if(rel>127)
            PC_back=PC_back-256;
        end
    else
        PC_back=PC+2;
    end
    
    %cycle count
    cycle_back=cycle+3;
end