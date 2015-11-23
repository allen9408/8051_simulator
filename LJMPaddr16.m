function [PC_back,cycle_back]=LJMPaddr16(PC,promem,cycle)
    direct1bin=fi(promem(PC+1,1),0,8,0);
    direct2bin=fi(promem(PC+2,1),0,8,0);
    PCbin=fi(PC,0,16,0);
    for i=9:16
        PCbin.bin(i)=direct2bin.bin(i-8);
    end
    for i=1:8
        PCbin.bin(i)=direct1bin.bin(i);
    end
    direct1bin.double
    direct2bin.double
    PC_back=direct1bin.double*(2^8)+direct2bin.double+1;%+PC0
    
    
    cycle_back=cycle+3;
end