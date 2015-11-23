function [PC_back,cycle_back]=JNC(PC,cycle,intmem,promem)
    rel=promem(PC+1,1);
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
    if(CY==0)
        PC_back=PC+2+rel;
        if(rel>127)
            PC_back=PC_back-256;
        end
    else
        PC_back=PC+2;
    end
    %cycle count
    cycle_back=cycle+3;
end