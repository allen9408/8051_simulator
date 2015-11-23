function [PC_back,cycle_back,intmem_back]=RET(cycle,intmem,idatax)
    intmem_back=intmem;
    %load sp
    SP=intmem(130,1);
%     if(SP<128)
%         PCH=intmem(SP+1,1);
%     else
%         PCH=idatax(SP-127,1);
%     end
    PCH=intmem(SP+1,1);
    SP=SP-1;
%     if(SP<128)
%         PCL=intmem(SP+1,1);
%     else
%         PCL=idatax(SP-127,1);
%     end
    PCL=intmem(SP+1,1);
    SP=SP-1;
    intmem_back(130,1)=SP;
    PC_back=PCH*256+PCL+1;
    %cycle count
    cycle_back=cycle+4;
end