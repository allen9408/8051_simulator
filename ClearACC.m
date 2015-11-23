function [PC_back,intmem_back,cycle_back]=ClearACC(PC,intmem,cycle)
    intmem_back=intmem;
    %clear ACC
    intmem_back(225,1)=0;
    %load Rn,PSW
    PSW=loadPSW(intmem(209,1));
    CY=PSW(1,1);
    AC=PSW(2,1);
    F0=PSW(3,1);
    RS1=PSW(4,1);
    RS0=PSW(5,1);
    OV=PSW(6,1);
    UN=PSW(7,1);
    P=PSW(8,1);
    %save PSW,Rn
    intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,0);
    %cycle count
    cycle_back=cycle+1;
    PC_back=PC+1;
end