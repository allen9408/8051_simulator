function [PC_back,cycle_back,intmem_back]=MovDirToDir(PC,cycle,intmem,promem)
    intmem_back=intmem;
    addr1=promem(PC+1,1)+1;
    addr2=promem(PC+2,1)+1;
    
    %save reg
    intmem_back(addr1,1)=intmem(addr2,1);
    
    %cycle count
    cycle_back=cycle+3;
    PC_back=PC+3;
end