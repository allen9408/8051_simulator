function [PC_back,cycle_back,intmem_back]=MovACCToReg(PC,cycle,intmem,n)
    intmem_back=intmem;
    %load Rn,PSW
    PSW=loadPSW(intmem(209,1));
    if (PSW(4,1)==0 && PSW(5,1)==0)
        n=n;
    elseif (PSW(4,1)==0 && PSW(5,1)==1)
        n=n+8;
    elseif (PSW(4,1)==1 && PSW(5,1)==0)
        n=n+16;
    elseif (PSW(4,1)==1 && PSW(5,1)==1)
        n=n+24;
    end
    
    %save ACC
    intmem_back(n,1)=intmem(225,1);
    
    %cycle count
    cycle_back=cycle+1;
    PC_back=PC+1;
end