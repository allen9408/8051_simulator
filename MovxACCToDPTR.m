function [PC_back,cycle_back,extmem_back]=MovxACCToDPTR(PC,cycle,intmem,extmem)
    extmem_back=extmem;
    %load ACC
    ACC=intmem(225,1);
    %load DPTR
    DPL=intmem(131,1);%DPTR low
    DPH=intmem(132,1);%DPTR high
    DPTR=DPH*(2^8)+DPL;%DPTR
    
    %save extmem
    extmem_back(DPTR+1)=ACC;
    
    %cycle count
    cycle_back=cycle+3;
    PC_back=PC+1;
end