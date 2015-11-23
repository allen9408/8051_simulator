function [PC_back,cycle_back,intmem_back]=MovDataToDir(PC,cycle,intmem,promem)
    intmem_back=intmem;
    addr=promem(PC+1,1);
    data=promem(PC+2,1);
    
    %save data;
    intmem_back(addr+1)=data;
    
    %cycle count
    cycle_back=cycle+3;
    PC_back=PC+3;
end
