function [PC_back,cycle_back,intmem_back]=MovDataToReg(PC,cycle,intmem,promem,n)
    intmem_back=intmem;
    %load Rn,PSW
    PSW=loadPSW(intmem(209,1));
    
    if (PSW(4,1)==0 && PSW(5,1)==0)
        addr=n;
    elseif (PSW(4,1)==0 && PSW(5,1)==1)
        addr=n+8;
    elseif (PSW(4,1)==1 && PSW(5,1)==0)
        addr=n+16;
    elseif (PSW(4,1)==1 && PSW(5,1)==1)
        addr=n+24;
    end
    
    data=promem(PC+1,1);
    intmem_back(addr,1)=data;
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end