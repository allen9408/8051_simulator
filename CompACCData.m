function [PC_back,cycle_back,intmem_back]=CompACCData(PC,intmem,cycle,promem)
    intmem_back=intmem;
    data=promem(PC+1,1);
    rel=promem(PC+2,1);
    %load ACC
    ACC=intmem(225,1);
    
    b=fix(log2(PC));
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
    
    if(ACC~=data)
        PC_back=PC+3+rel;
        if(PC_back>2^(b+1)-1 && b>7);
            PC_back=PC_back-2^(b+1);
        end
    else
        PC_back=PC+3;
    end
    if(ACC<data)
        CY=1;
    else
        CY=0;
    end
    intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,P);
    %cycle count
    cycle_back=cycle+4;
end