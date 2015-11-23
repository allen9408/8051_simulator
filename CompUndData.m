function [PC_back,cycle_back,intmem_back]=CompUndData(PC,cycle,intmem,idatax,promem,i)
    intmem_back=intmem;
    data=promem(PC+1,1);
    rel=promem(PC+2,1);
    %load PSW
    PSW=loadPSW(intmem(209,1));
    if (PSW(4,1)==0 && PSW(5,1)==0)
        rn=intmem(i,1);
    elseif (PSW(4,1)==0 && PSW(5,1)==1)
        rn=intmem(i+8,1);
    elseif (PSW(4,1)==1 && PSW(5,1)==0)
        rn=intmem(i+16,1);
    elseif (PSW(4,1)==1 && PSW(5,1)==1)
        rn=intmem(i+24,1);
    end
    addr=rn;
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
    
    %load undirect data
    if (addr<128)
        unddata=intmem(addr+1,1);
    else
        unddata=idatax(addr-127,1);
    end
    
   
    if(unddata~=data)
        PC_back=PC+3+rel;
        if(rel>127);
            PC_back=PC_back-256;
        end
    else
        PC_back=PC+3;
    end
    if(unddata<data)
        CY=1;
    else
        CY=0;
    end
    intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,P);
    %cycle count
    cycle_back=cycle+4;
end