function [PC_back,cycle_back]=JMPACCDPTR(PC,cycle,intmem)
    DPL=intmem(131,1);%DPTR low
    DPH=intmem(132,1);%DPTR high
    DPTR=DPH*(2^8)+DPL;%DPTR
    ACC=intmem(225,1);%ACC
    PC_back=ACC+DPTR+1;
    %cycle count
    cycle_back=cycle+3;
end