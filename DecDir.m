function [PC_back,intmem_back,cycle_back]=DecDir(PC,cycle,intmem,promem)
    intmem_back=intmem;
    %load Rn,PSW
    PSW=loadPSW(intmem(209,1));
    CY=PSW(1,1);
    AC=PSW(2,1);
    F0=PSW(3,1);
    RS1=PSW(4,1);
    RS0=PSW(5,1);
    OV=PSW(6,1);
    UN=PSW(7,1);
    P=PSW(8,1);
    addr=promem(PC+1,1)+1;
    rn=intmem(addr,1);
    %sub
    sub1=rn;
    sub2=1;
    tmp=fi(sub1-sub2,0,8,0);
    tmp1=sub1-sub2;
%     %CY
%     if (sub1>127 && tmp.data<127)
%         CY=1;
%     else
%         CY=0;
%     end
%     %OV
%     if (tmp1<0)
%         OV=1;
%     else
%         OV=0;
%     end
%     %AC
%     low1=dec2bin(sub1,8);
%     low2=dec2bin(sub2,8);
%     tempa=bin2dec(low1(5:8))-bin2dec(low2(5:8));
%     if(tempa<0)
%         AC=1;
%     else
%         AC=0;
%     end
    %save PSW,Rn
    intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,P);
    intmem_back(addr,1)=tmp.data;
    
    %cycle count
    cycle_back=cycle+2;
    PC_back=PC+2;
end