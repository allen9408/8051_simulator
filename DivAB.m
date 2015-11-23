function [PC_back,intmem_back,cycle_back]=DivAB(PC,cycle,intmem)
    intmem_back=intmem;
    %load ACC,B
    ACC=intmem(225,1);
    B=intmem(241,1);
    %load PSW
    PSW=loadPSW(intmem(209,1));
    CY=PSW(1,1);
    AC=PSW(2,1);
    F0=PSW(3,1);
    RS1=PSW(4,1);
    RS0=PSW(5,1);
    OV=PSW(6,1);
    UN=PSW(7,1);
    P=PSW(8,1);
    
    %DIV
    if(B==0)
        OV=1;
    else
        CY=0;
        OV=0;
        data1=fix(ACC/B);
        data2=mod(ACC,B);
        intmem_back(225,1)=data1;
        intmem_back(241,1)=data2;
    end
    %P
    P=0;
    pb=dec2bin(intmem_back(225,1),8);
    for j=1:8
        if pb(j)=='1'
            P=P+1;
        end
    end
    P=mod(P,2);
    %save PSW,Rn
    intmem_back(209,1)=savePSW(0,AC,F0,RS1,RS0,OV,UN,P);
    %cycle count
    cycle_back=cycle+4;
    PC_back=PC+1;
end