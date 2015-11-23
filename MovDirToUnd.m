function [PC_back,cycle_back,intmem_back,idatax_back]=MovDirToUnd(PC,cycle,intmem,idatax,promem,i)
    intmem_back=intmem;
    idatax_back=idatax;
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
    
    addr1=rn;
    addr2=promem(PC+2,1);
    data=intmem(addr2+1,1);
    
    %save data
    if(addr1<128)
        intmem_back(addr+1,1)=data;
    else
        idatax_back(addr-127,1)=data;
    end
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end