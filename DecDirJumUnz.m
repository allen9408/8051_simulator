function [PC_back,cycle_back,intmem_back]=DecDirJumUnz(PC,cycle,intmem,promem)
    intmem_back=intmem;
    addr=promem(PC+1,1);
    intmem_back(addr+1,1)=intmem(addr+1,1)-1;
    rel=promem(PC+2,1);
    data=intmem_back(addr+1,1);
    
    if(data~=0)
        PC_back=PC+3+rel;
        if(rel>127)
            PC_back=PC_back-256;
        end
    else
        PC_back=PC+3;
    end
    
    %cycle count
    cycle_back=cycle+2;
end