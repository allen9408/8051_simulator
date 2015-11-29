clear all;
[promem,extmem,intmem,idatax,PC,cycle,ACC,B,PSW,SP,DPTR,Rn,C,flag,freq_count,cycle_count,inst_matrix]=InitializeReg();
% %memory definition
% promem=zeros(2^16,1);
% extmem=zeros(2^16,1);
% intmem=zeros(256,1);%including SFR in high 128B
% idatax=zeors(128,1);
% %registers location
% B=intmem(241,1);%F0+1
% ACC=intmem(225,1);%E0+1
% PSW=intmem(209,1);%D0+1
% SP=intmem(130,1);%81+1% PC=2*16+3;
% PC0=2*16+3;
% cycle=2*16+3;
% DPL=intmem(131,1);%DPTR low
% DPH=intmem(132,1);%DPTR high


%main program
[promem]=loadprogram(promem);
branchNumber=0;
% [intmem,extmem,idatax,PC,cycle,ACC,B,PSW,SP,DPTR,Rn,C,flag]=startsim(promem,intmem,extmem,idatax,PC,cycle,ACC,B,PSW,SP,DPTR,Rn,C,flag);
GUI1(intmem,extmem,idatax,PC,cycle,ACC,B,PSW,SP,DPTR,Rn,C,flag,promem,branchNumber,freq_count,cycle_count,inst_matrix);




