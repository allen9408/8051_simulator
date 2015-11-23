function [PC_back,cycle_back,intmem_back,idatax_back]=MovACCToUnd(PC,cycle,intmem,idatax,i)
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
    addr=rn;
    
    %load ACC
    ACC=intmem(225,1);
    
    if(addr<128)
        intmem_back(addr+1)=ACC;
    else
        idatax_back(addr-127)=ACC;
    end
    
    %cycle count
    cycle_back=cycle+1;
    PC_back=PC+1;
end