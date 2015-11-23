function [PC_back,cycle_back,intmem_back]=PopDir(PC,cycle,intmem,idatax,promem)
    intmem_back=intmem;
    %load SP
    SP=intmem(130,1);
    addr=promem(PC+1,1);
    
%     if (SP<128)
%         data=intmem(SP+1,1);
%     else
%         data=idatax(SP-127,1);
%     end
    data=intmem(SP+1,1);
    SP=SP-1;
    intmem_back(130,1)=SP;
    intmem_back(addr+1,1)=data;
    
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end