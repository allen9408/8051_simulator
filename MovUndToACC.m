function [PC_back,cycle_back,intmem_back,idatax_back]=MovUndToACC(PC,cycle,intmem,idatax,n)
    intmem_back=intmem;
    idatax_back=idatax;
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
        iaddr=n;
    elseif (PSW(4,1)==0 && PSW(5,1)==1)
        iaddr=n+8;
    elseif (PSW(4,1)==1 && PSW(5,1)==0)
        iaddr=n+16;
    elseif (PSW(4,1)==1 && PSW(5,1)==1)
        iaddr=n+24;
    end
    addr=intmem(iaddr,1)+1;
    %load undirect data
    if (addr<129)
        data=intmem(addr,1);
    else
        data=idatax(addr-128,1);
    end
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
    cycle_back=cycle+2;
    PC_back=PC+1;
end
    