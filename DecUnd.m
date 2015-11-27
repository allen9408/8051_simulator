function [PC_back,intmem_back,idatax_back,cycle_back]=DecUnd(PC,cycle,intmem,idatax,i)
    intmem_back=intmem;
    idatax_back=idatax;
    
    %load PSW
    PSW=loadPSW(intmem(209,1));
    if (PSW(4,1)==0 && PSW(5,1)==0)
        rn=intmem(i,1);
    elseif (PSW(4,1)==0 && PSW(5,1)==1)
        rn=intmem(i+8,1);
    elseif (PSW(4,1)==1 && PSW(5,1)==0)
        rn=intmem(i+16,1);
    elseif (PSW(4,1)==1 && PSW(5,1)==1)
        rn=intmem(i+24,1);
    end
    
    addr=rn+1;
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
    PC_back=PC+1;
end
    