function [PC_back,cycle_back,intmem_back]=MovRegToDir(PC,cycle,intmem,promem,n)
    intmem_back=intmem;
    dir=promem(PC+1,1)+1;
    %load PSW
    PSW=loadPSW(intmem(209,1));
    if (PSW(4,1)==0 && PSW(5,1)==0)
        data=intmem(n,1);
    elseif (PSW(4,1)==0 && PSW(5,1)==1)
        data=intmem(n+8,1);
    elseif (PSW(4,1)==1 && PSW(5,1)==0)
        data=intmem(n+16,1);
    elseif (PSW(4,1)==1 && PSW(5,1)==1)
        data=intmem(n+24,1);
    end
    
    %save Reg
    intmem_back(dir,1)=data;
    
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end