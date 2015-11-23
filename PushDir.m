function [PC_back,cycle_back,intmem_back,idatax_back]=PushDir(PC,cycle,intmem,promem,idatax)
    intmem_back=intmem;
    idatax_back=idatax;
    
    %load SP
    SP=intmem(130,1);
    SP=SP+1;
    addr=promem(PC+1,1);
    data=intmem(addr+1,1);
    
    %push
%     if (SP<128)
%         intmem_back(SP+1,1)=data;
%     else
%         intmem_back(SP-127,1)=data;
%     end
    intmem_back(SP+1)=data;
    intmem_back(130,1)=SP;
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end
       