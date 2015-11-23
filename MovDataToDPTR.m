function [PC_back,cycle_back,intmem_back]=MovDataToDPTR(PC,cycle,promem,intmem)
    intmem_back=intmem;
    
    DPH=promem(PC+1,1);
    DPL=promem(PC+2,1);
    
    %save DPTR
    intmem_back(131,1)=DPL;
    intmem_back(132,1)=DPH;
    
    %cycle count
    cycle_back=cycle+3;
    PC_back=PC+3;
end