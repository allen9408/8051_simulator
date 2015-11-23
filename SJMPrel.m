function [PC_back,cycle_back]=SJMPrel(PC,promem,cycle)
    rel=promem(PC+1,1);
    PC_back=PC+2+rel;
    %PC_back=directbin.double
    if(rel>127)
        PC_back=PC_back-256;
    end
    cycle_back=cycle+2;
end