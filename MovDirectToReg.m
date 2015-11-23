function [PC_back,intmem_back,cycle_back]=MovDirectToReg(PC,intmem,cycle,promem,n)
    intmem_back=intmem;
    addr=promem(PC+1,1);
    data=intmem(addr+1,1);
    %load PSW
    PSW=loadPSW(intmem(209,1));
    if (PSW(4,1)==0 && PSW(5,1)==0)
        intmem_back(n,1)=data;
    elseif (PSW(4,1)==0 && PSW(5,1)==1)
        intmem_back(n+8,1)=data;
    elseif (PSW(4,1)==1 && PSW(5,1)==0)
        intmem_back(n+16,1)=data;
    elseif (PSW(4,1)==1 && PSW(5,1)==1)
        intmem_back(n+24,1)=data;
    end
    
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end