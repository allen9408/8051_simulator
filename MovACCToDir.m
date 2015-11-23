function [PC_back,cycle_back,intmem_back]=MovACCToDir(PC,cycle,intmem,promem)
    intmem_back=intmem;
    addr=promem(PC+1,1)+1;
    
    %load ACC
    ACC=intmem(225,1);
    
    %save Reg
    intmem_back(addr,1)=ACC;
    
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end