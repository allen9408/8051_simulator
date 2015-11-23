function [PC_back,cycle_back,intmem_back]=CplACC(PC,cycle,intmem)
    intmem_back=intmem;
    intmem_back(225,1)=255-intmem(225,1);
    
    %cycle count
    cycle_back=cycle+1;
    PC_back=PC+1;
end