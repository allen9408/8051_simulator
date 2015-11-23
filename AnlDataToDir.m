function [PC_back,cycle_back,intmem_back]=AnlDataToDir(PC,cycle,intmem,promem)
    intmem_back=intmem;

    addr=promem(PC+1,1);
   
    %add
    add1=promem(PC+2);
    add2=intmem(addr+1,1);
    tmp=bitand(add1,add2);
    
    intmem_back(addr+1,1)=tmp;
    
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+3;
end