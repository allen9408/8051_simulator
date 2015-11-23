function [PC_back,cycle_back]=JB(PC,cycle,intmem,promem)
    addr_bit=promem(PC+1,1);
    rel=promem(PC+2,1);
    
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
        PC_back=PC+3+rel;
        if(rel>127)
            PC_back=PC_back-256;
        end
    else
        PC_back=PC+3;
    end
    %cycle count
    cycle_back=cycle+4;
end