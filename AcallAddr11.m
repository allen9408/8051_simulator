function [PC_back,cycle_back,intmem_back,idatax_back]=AcallAddr11(PC,cycle,intmem,idatax,promem)
    intmem_back=intmem;
    idatax_back=idatax;
    
    addrh=fix(promem(PC,1)/32);
    addrl=promem(PC+1,1);
    PC=PC+2-1;%jump will add 1
    data1=mod(PC,256);
    data2=fix(PC/256);
    %load sp
    SP=intmem_back(130,1);
    SP=SP+1;
%     if(SP<128)
%         intmem_back(SP+1,1)=data1;
%     else
%         idatax_back(SP-127,1)=data1;
%     end
    intmem_back(SP+1,1)=data1;
    SP=SP+1;
%     if(SP<128)
%         intmem_back(SP+1,1)=data2;
%     else
%         idatax_back(SP-127,1)=data2;
%     end
    intmem_back(SP+1,1)=data2;
    PC_back=fix(PC/2048)+addrh*256+addrl+1;
    %cycle count
    cycle_back=cycle+2;
end
