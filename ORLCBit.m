function [PC_back,cycle_back,intmem_back]=ORLCBit(PC,cycle,intmem,promem)
    intmem_back=intmem;
    addr_bit=promem(PC+1,1);
    %find bit
    if(addr_bit<128)
        m=fix(addr_bit/8);
        n=mod(addr_bit,8);
        addr=33+m;
        bit=mod(fix(intmem(addr,1)/(2^n)),2);
    else
        m=fix(addr_bit/8)-16;
        n=mod(addr_bit,8);
        addr=129+m*8;
        bit=mod(fix(intmem(addr,1)/(2^n)),2);
    end
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
    CY=CY|bit;
    intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,P);
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end