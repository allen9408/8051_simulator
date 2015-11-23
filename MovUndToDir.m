function [PC_back,cycle_back,intmem_back]=MovUndToDir(PC,cycle,intmem,promem,idatax,i)
    intmem_back=intmem;
    addr1=promem(PC+1,1);
    
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
    addr2=rn;
    
    %load data
    if (addr2<128)
        unddata=intmem(addr2+1,1);
    else
        unddata=idatax(addr2-127,1);
    end
    
    %save data
    intmem_back(addr1+1,1)=unddata;
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end
    