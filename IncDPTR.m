function [PC_back,intmem_back,cycle_back]=IncDPTR(PC,cycle,intmem)
    intmem_back=intmem;
%     %load PSW
%     PSW=loadPSW(intmem(209,1));
%     CY=PSW(1,1);
%     AC=PSW(2,1);
%     F0=PSW(3,1);
%     RS1=PSW(4,1);
%     RS0=PSW(5,1);
%     OV=PSW(6,1);
%     UN=PSW(7,1);
%     P=PSW(8,1);
    %load DPTR
    DPL=intmem(131,1);
    DPH=intmem(132,1);
    DPTR=DPH*256+DPL;
    
    %add
    add1=DPTR;
    add2=1;
    tmp=add1+add2;
%     tmp1=add1+add2;
%     %CY
%     if (tmp.data>32767)
%         CY=1;
%     else
%         CY=0;
%     end
%     %OV
%     if (tmp1>65535)
%         OV=1;
%     else
%         OV=0;
%     end
%     %AC
%     lowa=dec2bin(add1,8);
%     lowb=dec2bin(add2,8);
%     tempa=bin2dec(lowa(5:8))+bin2dec(lowb(5:8));
%     if(tempa>255)
%         AC=1;
%     else 
%         AC=0;
%     end
%     %save PSW,DPTR
%     intmem_back(209,1)=savePSW(CY,AC,F0,RS1,RS0,OV,UN,P);
    [DPL1,DPH1]=saveDPTR(tmp);
    intmem_back(131,1)=DPL1;
    intmem_back(132,1)=DPH1;
    
    
    %cycle count
    cycle_back=cycle+1;
    PC_back=PC+1;
end