function [PC_back,cycle_back]=JZrel(PC,cycle,intmem,promem)
    ACC=intmem(225,1);
    rel=promem(PC+1,1);
    if(ACC==0)
        PC_back=PC+2+rel;
        if(rel>127)
            PC_back=PC_back-256;
        end
    else
        PC_back=PC+2;
    end
    %cycle count
    cycle_back=cycle+3;
end