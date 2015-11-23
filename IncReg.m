function [PC_back,intmem_back,cycle_back]=IncReg(PC,cycle,intmem,n)
    intmem_back=intmem;
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
        addr=n;
    elseif (PSW(4,1)==0 && PSW(5,1)==1)
        addr=n+8;
    elseif (PSW(4,1)==1 && PSW(5,1)==0)
        addr=n+16;
    elseif (PSW(4,1)==1 && PSW(5,1)==1)
        addr=n+24;
    end
    %add
    add1=intmem(addr,1);
    add2=1;
    tmp=fi(add1+add2,0,8,0);
    tmp1=add1+add2;
    %CY
    if (tmp.data>127)
        CY=1;
    else
        CY=0;
    end
    %OV
    if (tmp1>255)
        OV=1;
    else
        OV=0;
    end
    %AC
    lowa=dec2bin(add1,8);
    lowb=dec2bin(add2,8);
    tempa=bin2dec(lowa(5:8))+bin2dec(lowb(5:8));
    if(tempa>15)
        AC=1;
    else 
        AC=0;
    end
    
    %save PSW,Rn
    intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,P);
    if(add2>128 || tmp1>255)
        intmem_back(addr,1)=tmp1-256;
    else
        intmem_back(addr,1)=tmp.data;
    end
    
    %cycle count
    cycle_back=cycle+1;
    PC_back=PC+1;
end
    
    