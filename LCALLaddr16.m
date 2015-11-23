function [PC_back,intmem_back,cycle_back,idatax_back]=LCALLaddr16(PC,intmem,promem,cycle,idatax)
    intmem_back=intmem;
    idatax_back=idatax;
    addr1=promem(PC+1,1);
    addr2=promem(PC+2,1);
    PC=PC+2;%jump will add 1
    %load sp
    SP=intmem(130,1);
    %%%%%%
    SP=SP+1;
%     if(SP<128)
%         intmem_back(SP+1,1)=mod(PC,256);
%     else
%         idatax_back(SP-127,1)=mod(PC,256);
%     end
    intmem_back(SP+1,1)=mod(PC,256);
    SP=SP+1;
%     if(SP<128)
%         intmem_back(SP+1,1)=fix(PC/256);
%     else
%         idatax_back(SP-127,1)=fix(PC/256);
%     end
    intmem_back(SP+1,1)=fix(PC/256);
    PC_back=addr1*256+addr2+1;
    
    %save sp
    intmem_back(130,1)=SP;
    %%%%%%%
    
    %cycle count
    cycle_back=cycle+3;
end
    