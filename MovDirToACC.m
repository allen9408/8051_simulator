function [PC_back,intmem_back,cycle_back]=MovDirToACC(PC,intmem,promem,cycle)
    intmem_back=intmem;
    addr=promem(PC+1)+1;
    tmp=fi(intmem(addr,1),0,8,0);
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
    %P
    P=0;
    pb=dec2bin(tmp.data,8);
    for j=1:8
        if pb(j)=='1'
            P=P+1;
        end
    end
    P=mod(P,2);
    
    %save ACC,PSW
    intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,P);    
    intmem_back(225,1)=tmp.data;
    
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end
    