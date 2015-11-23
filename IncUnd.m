function [PC_back,intmem_back,cycle_back,idatax_back]=IncUnd(PC,cycle,intmem,idatax,n)
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
    %add
    if(addr<129)
        add1=intmem(addr,1);
    else
        add1=idatax(addr-128,1);
    end
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
    if (tmp1>255)
        tmp1=tmp1-256;
    end
    
    %save PSW,Rn
    intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,P);
    if(addr<129)
        intmem_back(addr,1)=tmp1;
    else
        idatax_back(addr-128,1)=tmp1;
    end
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+1;
end