function [PC_back,cycle_back,intmem_back]=ClearBit(PC,cycle,intmem,promem)
    intmem_back=intmem;
    addr_bit=promem(PC+1,1);
    %find bit
    if(addr_bit<128)
        m=fix(addr_bit/8);
        n=mod(addr_bit,8);
        addr=33+m;
        bit=mod(fix(intmem(addr,1)/(2^n)),2);
    else
        m=fix(addr_bit/8)-16;
        n=mod(addr_bit,8);
        addr=129+m*8;
        bit=mod(fix(intmem(addr,1)/(2^n)),2);
    end
    if(bit==1)
        intmem_back(addr,1)=intmem(addr,1)-(2^n);
    end
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end