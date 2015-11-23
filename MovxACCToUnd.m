function [PC_back,cycle_back,intmem_back,extmem_back]=MovxACCToUnd(PC,cycle,intmem,extmem,i)
    intmem_back=intmem;
    extmem_back=extmem;
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
    data=intmem(225,1);
    
    %save data
    extmem_back(addr+1,1)=data;
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+1;
end