function [PC_back,cycle_back,intmem_back]=OrlACCReg(PC,cycle,intmem,n)
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
        rn=intmem(n,1);
    elseif (PSW(4,1)==0 && PSW(5,1)==1)
        rn=intmem(n+8,1);
    elseif (PSW(4,1)==1 && PSW(5,1)==0)
        rn=intmem(n+16,1);
    elseif (PSW(4,1)==1 && PSW(5,1)==1)
        rn=intmem(n+24,1);
    end
    %and
    and1=intmem(225,1);
    and2=rn;
    tmp=bitor(and1,and2);
    %P
    P=0;
    pb=dec2bin(tmp,8);
    for j=1:8
        if pb(j)=='1'
            P=P+1;
        end
    end
    P=mod(P,2);
    %save PSW,Rn
    intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,P);
    intmem_back(225,1)=tmp;
    
    %cycle count
    cycle_back=cycle+1;
    PC_back=PC+1;
end