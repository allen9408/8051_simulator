function [PC_back,cycle_back,intmem_back]=SwapACC(PC,cycle,intmem)
    intmem_back=intmem;
    ACC=intmem(225,1);
    
    ACCL=mod(ACC,16);
    ACCH=fix(ACC/16);
    
    intmem_back(225,1)=ACCL*16+ACCH;
    %cycle count
    cycle_back=cycle+1;
    PC_back=PC+1;
end