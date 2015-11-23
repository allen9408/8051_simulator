function [PC_back,cycle_back]=AJMPaddr11(PC,promem,cycle)
    data1=promem(PC,1);
    data2=promem(PC+1,1);
    PC=PC+2;
    PC_back=fix(PC/2048)*2048+fix(data1/32)*256+data2+1;
    cycle_back=cycle+2;
end