function [PC_back,cycle_back,intmem_back]=MovxUndToACC(PC,cycle,intmem,extmem,i)
    intmem_back=intmem;
    %load PSW
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
    
    if (PSW(4,1)==0 && PSW(5,1)==0)
        addr=i;
    elseif (PSW(4,1)==0 && PSW(5,1)==1)
        addr=i+8;
    elseif (PSW(4,1)==1 && PSW(5,1)==0)
        addr=i+16;
    elseif (PSW(4,1)==1 && PSW(5,1)==1)
        addr=i+24;
    end
    unaddr=intmem(addr,1);
    %load undirect data
    unddata=extmem(unaddr+1,1);
    %P
    P=0;
    pb=dec2bin(unddata,8);
    for j=1:8
        if pb(j)=='1'
            P=P+1;
        end
    end
    P=mod(P,2);
    
    %save PSW,ACC
    intmem_back(225,1)=unddata;
    intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,P);
    
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+1;
end