function [PC_back,cycle_back,intmem_back]=XrlACCToDir(PC,cycle,intmem,promem)
    intmem_back=intmem;
    ACC=intmem(225,1);
    addr=promem(PC+1,1);
   
    %add
    add1=ACC;
    add2=intmem(addr+1,1);
    tmp=bitxor(add1,add2);
    
    intmem_back(addr+1,1)=tmp;
    
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end