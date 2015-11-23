function [PC_back,cycle_back,intmem_back]=RotLeftACC(PC,cycle,intmem)
    intmem_back=intmem;
    ACC=intmem(225,1);
    if(ACC>127)
        h=1;
    else
        h=0;
    end
    intmem_back(225,1)=(ACC-h*128)*2+h;
    %cycle count
    cycle_back=cycle+1;
    PC_back=PC+1;
end