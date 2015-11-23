function [PC_back,cycle_back,intmem_back]=MovxDPTRToACC(PC,cycle,intmem,extmem)
    intmem_back=intmem;
    %load PSW
    PSW=loadPSW(intmem(209,1));
    CY=PSW(1,1);
    AC=PSW(2,1);
    F0=PSW(3,1);
    RS1=PSW(4,1);
    RS0=PSW(5,1);
    OV=PSW(6,1);
    UN=PSW(7,1);
    P=PSW(8,1);
    
    %load DPTR
    DPL=intmem(131,1);%DPTR low
    DPH=intmem(132,1);%DPTR high
    DPTR=DPH*(2^8)+DPL;%DPTR
    
    addr=DPTR;
    data=extmem(addr+1,1);
    %P
    P=0;
    pb=dec2bin(data,8);
    for j=1:8
        if pb(j)=='1'
            P=P+1;
        end
    end
    P=mod(P,2);
    %save PSW,ACC
    intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,P);
    intmem_back(225,1)=data;
    %cycle count
    cycle_back=cycle+3;
    PC_back=PC+1;
end