function [PC_back,cycle_back,intmem_back]=RotRightACC(PC,cycle,intmem)
    intmem_back=intmem;
    ACC=intmem(225,1);
    if(mod(ACC,2)==1)
        h=1;
    else
        h=0;
    end
    intmem_back(225,1)=fix(ACC/2)+h*128;
    %cycle count
    cycle_back=cycle+1;
    PC_back=PC+1;
end