function [intmem_back,extmem_back,idatax_back,PC,cycle,ACC,B,PSW,SP,DPTR,Rn,C,flag,freq_count,cycle_count,inst_matrix]=startsim(promem,intmem,extmem,idatax,PC,cycle,ACC,B,PSW,SP,DPTR,Rn,C,flag,branchNumber,freq_count,cycle_count,inst_matrix) 
   
    flag=0;
    Rn=zeros(8,1);
    %TODO
    %Ri=zeros(2,1);
%     PC=2*16+3;
%     PC0=2*16+3;
%     cycle=2*16+3;
    %modified in 10.27.dsw, move to ResetProgram
    cur_instruction=0;
    intmem_back=intmem;
    extmem_back=extmem;
    idatax_back=idatax;
    
    %freq statistics %dsw 11.28.
%     freq_count=zeros(250,1);
%     cycle_count=zeros(250,1);
%     inst_matrix=cell(250,1);
    
    
%    while (flag==0)
        cur_instruction=cur_instruction+1;
        Instruction=promem(PC,1);
        opcode=dec2hex(Instruction,2);
        switch(opcode)
            case '02' %LJMP addr16
               [PC,cycle]=LJMPaddr16(PC,promem,cycle);
                freq_count(1,1)=freq_count(1,1)+1;
                cycle_count(1,1)=cycle_count(1,1)+3;
                inst_matrix(1,1)=cellstr('LJMP addr16');
            case {'11','31','51','71','91','B1','D1','F1'}%ACALL addr11
                [PC,cycle,intmem_back,idatax_back]=AcallAddr11(PC,cycle,intmem_back,idatax_back,promem);
                freq_count(2,1)=freq_count(2,1)+1;
                cycle_count(2,1)=cycle_count(2,1)+2;
                inst_matrix(2,1)=cellstr('ACALL addr11');
                       
            case 'B5' %CJNE A,direct,rel
                [PC,cycle,intmem_back]=CompACCDirect(PC,intmem_back,cycle,promem);
                freq_count(3,1)=freq_count(3,1)+1;
                cycle_count(3,1)=cycle_count(3,1)+4;
                inst_matrix(3,1)=cellstr('CJNE A,direct,rel');
            case 'B4' %CJNE A,#data,rel
                [PC,cycle,intmem_back]=CompACCData(PC,cycle,intmem_back,promem);
                freq_count(4,1)=freq_count(4,1)+1;
                cycle_count(4,1)=cycle_count(4,1)+4;
                inst_matrix(4,1)=cellstr('CJNE A,#data,rel');
            case 'B8' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,1);
                freq_count(5,1)=freq_count(5,1)+1;
                cycle_count(5,1)=cycle_count(5,1)+4;
                inst_matrix(5,1)=cellstr('CJNE R0,#data,rel');
            case 'B9' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,2);
                freq_count(6,1)=freq_count(6,1)+1;
                cycle_count(6,1)=cycle_count(6,1)+4;
                inst_matrix(6,1)=cellstr('CJNE R1,#data,rel');
            case 'BA' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,3);
                freq_count(7,1)=freq_count(7,1)+1;
                cycle_count(7,1)=cycle_count(7,1)+4;
                inst_matrix(7,1)=cellstr('CJNE R2,#data,rel');
            case 'BB' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,4);
                freq_count(8,1)=freq_count(8,1)+1;
                cycle_count(8,1)=cycle_count(8,1)+4;
                inst_matrix(8,1)=cellstr('CJNE R3,#data,rel');
            case 'BC' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,5);
                freq_count(9,1)=freq_count(9,1)+1;
                cycle_count(9,1)=cycle_count(9,1)+4;
                inst_matrix(9,1)=cellstr('CJNE R4,#data,rel');
            case 'BD' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,6);
                freq_count(10,1)=freq_count(10,1)+1;
                cycle_count(10,1)=cycle_count(10,1)+4;
                inst_matrix(10,1)=cellstr('CJNE R5,#data,rel');
            case 'BE' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,7);
                freq_count(11,1)=freq_count(11,1)+1;
                cycle_count(11,1)=cycle_count(11,1)+4;
                inst_matrix(11,1)=cellstr('CJNE R6,#data,rel');
            case 'BF' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,8);
                freq_count(12,1)=freq_count(12,1)+1;
                cycle_count(12,1)=cycle_count(12,1)+4;
                inst_matrix(12,1)=cellstr('CJNE R7,#data,rel');
                
            case 'B6' %CJNE @Ri,#data,rel
                [PC,cycle,intmem_back]=CompUndData(PC,cycle,intmem_back,idatax_back,promem,1);
                freq_count(13,1)=freq_count(13,1)+1;
                cycle_count(13,1)=cycle_count(13,1)+5;
                inst_matrix(13,1)=cellstr('CJNE @R0,#data,rel');
            case 'B7' %CJNE @Ri,#data,rel
                [PC,cycle,intmem_back]=CompUndData(PC,cycle,intmem_back,idatax_back,promem,2);
                freq_count(14,1)=freq_count(14,1)+1;
                cycle_count(14,1)=cycle_count(14,1)+5;
                inst_matrix(14,1)=cellstr('CJNE @R1,#data,rel');
                
            case 'D8' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,1);
                freq_count(15,1)=freq_count(15,1)+1;
                cycle_count(15,1)=cycle_count(15,1)+3;
                inst_matrix(15,1)=cellstr('DJNZ R0,rel');
            case 'D9' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,2);
                freq_count(16,1)=freq_count(16,1)+1;
                cycle_count(16,1)=cycle_count(16,1)+3;
                inst_matrix(16,1)=cellstr('DJNZ R1,rel');
            case 'DA' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,3);
                freq_count(17,1)=freq_count(17,1)+1;
                cycle_count(17,1)=cycle_count(17,1)+3;
                inst_matrix(17,1)=cellstr('DJNZ R2,rel');
            case 'DB' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,4);
                freq_count(18,1)=freq_count(18,1)+1;
                cycle_count(18,1)=cycle_count(18,1)+3;
                inst_matrix(18,1)=cellstr('DJNZ R3,rel');
            case 'DC' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,5); 
                freq_count(19,1)=freq_count(19,1)+1;
                cycle_count(19,1)=cycle_count(19,1)+3;
                inst_matrix(19,1)=cellstr('DJNZ R4,rel');
            case 'DD' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,6);
                freq_count(20,1)=freq_count(20,1)+1;
                cycle_count(20,1)=cycle_count(20,1)+3;
                inst_matrix(20,1)=cellstr('DJNZ R5,rel');
            case 'DE' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,7);
                freq_count(21,1)=freq_count(21,1)+1;
                cycle_count(21,1)=cycle_count(21,1)+3;
                inst_matrix(21,1)=cellstr('DJNZ R6,rel');
            case 'DF' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,8); 
                freq_count(22,1)=freq_count(22,1)+1;
                cycle_count(22,1)=cycle_count(22,1)+3;
                inst_matrix(22,1)=cellstr('DJNZ R7,rel');
                
            case 'D5' %DJNZ direct,rel
                [PC,cycle,intmem_back]=DecDirJumUnz(PC,cycle,intmem_back,promem);
                freq_count(23,1)=freq_count(23,1)+1;
                cycle_count(23,1)=cycle_count(23,1)+4;
                inst_matrix(23,1)=cellstr('DJNZ direct,rel');
                
            case '22' %RET
                [PC,cycle,intmem_back]=RET(cycle,intmem_back,idatax_back);
                freq_count(24,1)=freq_count(24,1)+1;
                cycle_count(24,1)=cycle_count(24,1)+4;
                inst_matrix(24,1)=cellstr('RET');
                
            case '32' %RETI
                [PC,cycle,intmem_back]=RETI(ctcle,intmem_back,idatax_back);
                freq_count(25,1)=freq_count(25,1)+1;
                cycle_count(25,1)=cycle_count(25,1)+4;
                inst_matrix(25,1)=cellstr('RETI');
                
            case {'01','21','41','61','81', 'A1','C1','E1'}%AJMP addr11
                [PC,cycle]=AJMPaddr11(PC,promem,cycle);
                freq_count(26,1)=freq_count(26,1)+1;
                cycle_count(26,1)=cycle_count(26,1)+2;
                inst_matrix(26,1)=cellstr('AJMP addr11');
                
            case '00' %NOP
                PC=PC+1;
                %TODO:cycle
                cycle=cycle+0;
                freq_count(27,1)=freq_count(27,1)+1;
                cycle_count(27,1)=cycle_count(27,1)+1;
                inst_matrix(27,1)=cellstr('NOP');
            
            case '80' %SJMP rel 2 2
                [PC,cycle]=SJMPrel(PC,promem,cycle); 
                freq_count(28,1)=freq_count(28,1)+1;
                cycle_count(28,1)=cycle_count(28,1)+2;
                inst_matrix(28,1)=cellstr('SJMP rel 2 2');
            
            case '12' %LCALL addr16
                [PC,intmem_back,cycle,idatax_back]=LCALLaddr16(PC,intmem_back,promem,cycle,idatax_back);
                freq_count(29,1)=freq_count(29,1)+1;
                cycle_count(29,1)=cycle_count(29,1)+3;
                inst_matrix(29,1)=cellstr('LCALL addr16');
            
            case 'E4' %CLR A
                [PC,intmem_back,cycle]=ClearACC(PC,intmem_back,cycle);
                freq_count(30,1)=freq_count(30,1)+1;
                cycle_count(30,1)=cycle_count(30,1)+1;
                inst_matrix(30,1)=cellstr('CLR A');
            
            case '73' %JMP,@A+DPTR
                [PC,cycle]=JMPACCDPTR(PC,cycle,intmem_back);
                freq_count(31,1)=freq_count(31,1)+1;
                cycle_count(31,1)=cycle_count(31,1)+3;
                inst_matrix(31,1)=cellstr('JMP,@A+DPTR3');
                
            case '60' %JZ rel
                [PC,cycle]=JZrel(PC,cycle,intmem_back,promem);
                freq_count(32,1)=freq_count(32,1)+1;
                cycle_count(32,1)=cycle_count(32,1)+3;
                inst_matrix(32,1)=cellstr('JZ rel');
                
            case '70' %JNZ rel
                [PC,cycle]=JNZrel(PC,cycle,intmem_back,promem);
                freq_count(33,1)=freq_count(33,1)+1;
                cycle_count(33,1)=cycle_count(33,1)+3;
                inst_matrix(33,1)=cellstr('JNZ rel');
                
            case '40' %JC rel
                [PC,cycle]=JC(PC,cycle,intmem_back,promem);
                freq_count(34,1)=freq_count(34,1)+1;
                cycle_count(34,1)=cycle_count(34,1)+3;
                inst_matrix(34,1)=cellstr('JC rel');
                
            case '50' %JNC rel
                [PC,cycle]=JNC(PC,cycle,intmem_back,promem);
                freq_count(35,1)=freq_count(35,1)+1;
                cycle_count(35,1)=cycle_count(35,1)+3;
                inst_matrix(35,1)=cellstr('JNC rel');
                
            case '20' %JB bit,rel
                [PC,cycle]=JB(PC,cycle,intmem_back,promem);
                freq_count(36,1)=freq_count(36,1)+1;
                cycle_count(36,1)=cycle_count(36,1)+4;
                inst_matrix(36,1)=cellstr('JB bit,rel');
                
            case '30' %JNB bit rel
                [PC,cycle]=JNB(PC,cycle,intmem_back,promem);
                freq_count(37,1)=freq_count(37,1)+1;
                cycle_count(37,1)=cycle_count(37,1)+4;
                inst_matrix(37,1)=cellstr('JNB bit rel');
                
            case '10' %JBC bit,rel
                [PC,cycle,intmem_back]=JBC(PC,cycle,intmem_back,promem);
                freq_count(38,1)=freq_count(38,1)+1;
                cycle_count(38,1)=cycle_count(38,1)+4;
                inst_matrix(38,1)=cellstr('JBC bit,rel');
           
                
                
           
            case 'E8' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,1);
                freq_count(39,1)=freq_count(39,1)+1;
                cycle_count(39,1)=cycle_count(39,1)+1;
                inst_matrix(39,1)=cellstr('MOV A,R0');
            case 'E9' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,2);
                freq_count(40,1)=freq_count(40,1)+1;
                cycle_count(40,1)=cycle_count(40,1)+1;
                inst_matrix(40,1)=cellstr('MOV A,R1');
            case 'EA' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,3);
                freq_count(41,1)=freq_count(41,1)+1;
                cycle_count(41,1)=cycle_count(41,1)+1;
                inst_matrix(41,1)=cellstr('MOV A,R2');
            case 'EB' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,4);
                freq_count(42,1)=freq_count(42,1)+1;
                cycle_count(42,1)=cycle_count(42,1)+1;
                inst_matrix(42,1)=cellstr('MOV A,R3');
            case 'EC' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,5);
                freq_count(43,1)=freq_count(43,1)+1;
                cycle_count(43,1)=cycle_count(43,1)+1;
                inst_matrix(43,1)=cellstr('MOV A,R4');
            case 'ED' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,6);
                freq_count(44,1)=freq_count(44,1)+1;
                cycle_count(44,1)=cycle_count(44,1)+1;
                inst_matrix(44,1)=cellstr('MOV A,R5');
            case 'EE' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,7);
                freq_count(45,1)=freq_count(45,1)+1;
                cycle_count(45,1)=cycle_count(45,1)+1;
                inst_matrix(45,1)=cellstr('MOV A,R6');
            case 'EF' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,8);
                freq_count(46,1)=freq_count(46,1)+1;
                cycle_count(46,1)=cycle_count(46,1)+1;
                inst_matrix(46,1)=cellstr('MOV A,R7');
                
            case 'E5' %MOV A,direct
                [PC,intmem_back,cycle]=MovDirToACC(PC,intmem_back,promem,cycle);
                freq_count(47,1)=freq_count(47,1)+1;
                cycle_count(47,1)=cycle_count(47,1)+2;
                inst_matrix(47,1)=cellstr('MOV A,direct');
            
            case 'E6' %MOV A,@Ri
                [PC,cycle,intmem_back,idatax_back]=MovUndToACC(PC,cycle,intmem_back,idatax_back,1);
                freq_count(48,1)=freq_count(48,1)+1;
                cycle_count(48,1)=cycle_count(48,1)+2;
                inst_matrix(48,1)=cellstr('MOV A,@R0');
            case 'E7' %MOV A,@Ri
                [PC,cycle,intmem_back,idatax_back]=MovUndToACC(PC,cycle,intmem_back,idatax_back,2);
                freq_count(49,1)=freq_count(49,1)+1;
                cycle_count(49,1)=cycle_count(49,1)+2;
                inst_matrix(49,1)=cellstr('MOV A,@R1');
                
            case '74' %MOV A,#data
                [PC,cycle,intmem_back]=MovDataToACC(PC,cycle,intmem_back,promem);
                freq_count(50,1)=freq_count(50,1)+1;
                cycle_count(50,1)=cycle_count(50,1)+2;
                inst_matrix(50,1)=cellstr('MOV A,#data');
                
            case 'A8' %MOV R0,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,1);
                freq_count(51,1)=freq_count(51,1)+1;
                cycle_count(51,1)=cycle_count(51,1)+2;
                inst_matrix(51,1)=cellstr('MOV R0,direct');
            case 'A9' %MOV R1,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,2);
                freq_count(52,1)=freq_count(52,1)+1;
                cycle_count(52,1)=cycle_count(52,1)+2;
                inst_matrix(52,1)=cellstr('MOV R1,direct');
            case 'AA' %MOV R2,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,3);
                freq_count(240,1)=freq_count(240,1)+1;
                cycle_count(240,1)=cycle_count(240,1)+2;
                inst_matrix(240,1)=cellstr('MOV R2,direct');
            case 'AB' %MOV R3,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,4);
                freq_count(53,1)=freq_count(53,1)+1;
                cycle_count(53,1)=cycle_count(53,1)+2;
                inst_matrix(53,1)=cellstr('MOV R3,direct');
            case 'AC' %MOV R4,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,5);
                freq_count(54,1)=freq_count(54,1)+1;
                cycle_count(54,1)=cycle_count(54,1)+2;
                inst_matrix(54,1)=cellstr('MOV R4,direct');
            case 'AD' %MOV R5,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,6);
                freq_count(55,1)=freq_count(55,1)+1;
                cycle_count(55,1)=cycle_count(55,1)+2;
                inst_matrix(55,1)=cellstr('MOV R5,direct');
            case 'AE' %MOV R6,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,7);
                freq_count(56,1)=freq_count(56,1)+1;
                cycle_count(56,1)=cycle_count(56,1)+2;
                inst_matrix(56,1)=cellstr('MOV R6,direct');
            case 'AF' %MOV R7,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,8);
                freq_count(57,1)=freq_count(57,1)+1;
                cycle_count(57,1)=cycle_count(57,1)+2;
                inst_matrix(57,1)=cellstr('MOV R7,direct');
                
            case 'F6' %MOV @R0,A
                [PC,cycle,intmem_back,idatax_back]=MovACCToUnd(PC,cycle,intmem_back,idatax_back,1);
                freq_count(58,1)=freq_count(58,1)+1;
                cycle_count(58,1)=cycle_count(58,1)+1;
                inst_matrix(58,1)=cellstr('MOV @R0,A');
            case 'F7' %MOV @R1,A 
                [PC,cycle,intmem_back,idatax_back]=MovACCToUnd(PC,cycle,intmem_back,idatax_back,2);
                freq_count(59,1)=freq_count(59,1)+1;
                cycle_count(59,1)=cycle_count(59,1)+1;
                inst_matrix(59,1)=cellstr('MOV @R1,A');
                
            case 'F8' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,1);
                freq_count(60,1)=freq_count(60,1)+1;
                cycle_count(60,1)=cycle_count(60,1)+1;
                inst_matrix(60,1)=cellstr('MOV R0,A');
            case 'F9' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,2);
                freq_count(61,1)=freq_count(61,1)+1;
                cycle_count(61,1)=cycle_count(61,1)+1;
                inst_matrix(61,1)=cellstr('MOV R1,A');
            case 'FA' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,3);
                freq_count(62,1)=freq_count(62,1)+1;
                cycle_count(62,1)=cycle_count(62,1)+1;
                inst_matrix(62,1)=cellstr('MOV R2,A');
            case 'FB' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,4);
                freq_count(63,1)=freq_count(63,1)+1;
                cycle_count(63,1)=cycle_count(63,1)+1;
                inst_matrix(63,1)=cellstr('MOV R3,A');
            case 'FC' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,5);
                freq_count(64,1)=freq_count(64,1)+1;
                cycle_count(64,1)=cycle_count(64,1)+1;
                inst_matrix(64,1)=cellstr('MOV R4,A');
            case 'FD' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,6);
                freq_count(65,1)=freq_count(65,1)+1;
                cycle_count(65,1)=cycle_count(65,1)+1;
                inst_matrix(65,1)=cellstr('MOV R5,A');
            case 'FE' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,7);
                freq_count(66,1)=freq_count(66,1)+1;
                cycle_count(66,1)=cycle_count(66,1)+1;
                inst_matrix(66,1)=cellstr('MOV R6,A');
            case 'FF' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,8);
                freq_count(67,1)=freq_count(67,1)+1;
                cycle_count(67,1)=cycle_count(67,1)+1;
                inst_matrix(67,1)=cellstr('MOV R7,A');
                
            case '78' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,1);
                freq_count(68,1)=freq_count(68,1)+1;
                cycle_count(68,1)=cycle_count(68,1)+2;
                inst_matrix(68,1)=cellstr('MOV R0,#data');
            case '79' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,2);
                freq_count(69,1)=freq_count(69,1)+1;
                cycle_count(69,1)=cycle_count(69,1)+2;
                inst_matrix(69,1)=cellstr('MOV R1,#data');
            case '7A' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,3);
                freq_count(70,1)=freq_count(70,1)+1;
                cycle_count(70,1)=cycle_count(70,1)+2;
                inst_matrix(70,1)=cellstr('MOV R2,#data');
            case '7B' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,4);
                freq_count(71,1)=freq_count(71,1)+1;
                cycle_count(71,1)=cycle_count(71,1)+2;
                inst_matrix(71,1)=cellstr('MOV R3,#data');
            case '7C' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,5);
                freq_count(72,1)=freq_count(72,1)+1;
                cycle_count(72,1)=cycle_count(72,1)+2;
                inst_matrix(72,1)=cellstr('MOV R4,#data');
            case '7D' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,6);
                freq_count(73,1)=freq_count(73,1)+1;
                cycle_count(73,1)=cycle_count(73,1)+2;
                inst_matrix(73,1)=cellstr('MOV R5,#data');
            case '7E' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,7);
                freq_count(74,1)=freq_count(74,1)+1;
                cycle_count(74,1)=cycle_count(74,1)+2;
                inst_matrix(74,1)=cellstr('MOV R6,#data');
            case '7F' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,8);
                freq_count(75,1)=freq_count(75,1)+1;
                cycle_count(75,1)=cycle_count(75,1)+2;
                inst_matrix(75,1)=cellstr('MOV R7,#data');
                
            case 'F5' %MOV direct,A
                [PC,cycle,intmem_back]=MovACCToDir(PC,cycle,intmem_back,promem);
                freq_count(76,1)=freq_count(76,1)+1;
                cycle_count(76,1)=cycle_count(76,1)+2;
                inst_matrix(76,1)=cellstr('MOV direct,A');
                
            case '88' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,1);
                freq_count(77,1)=freq_count(77,1)+1;
                cycle_count(77,1)=cycle_count(77,1)+2;
                inst_matrix(77,1)=cellstr('MOV direct,R0');
            case '89' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,2);
                freq_count(78,1)=freq_count(78,1)+1;
                cycle_count(78,1)=cycle_count(78,1)+2;
                inst_matrix(78,1)=cellstr('MOV direct,R1');
            case '8A' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,3);
                freq_count(79,1)=freq_count(79,1)+1;
                cycle_count(79,1)=cycle_count(79,1)+2;
                inst_matrix(79,1)=cellstr('MOV direct,R2');
            case '8B' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,4);
                freq_count(80,1)=freq_count(80,1)+1;
                cycle_count(80,1)=cycle_count(80,1)+2;
                inst_matrix(80,1)=cellstr('MOV direct,R3');
            case '8C' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,5);
                freq_count(81,1)=freq_count(81,1)+1;
                cycle_count(81,1)=cycle_count(81,1)+2;
                inst_matrix(81,1)=cellstr('MOV direct,R4');
            case '8D' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,6);
                freq_count(82,1)=freq_count(82,1)+1;
                cycle_count(82,1)=cycle_count(82,1)+2;
                inst_matrix(82,1)=cellstr('MOV direct,R5');
            case '8E' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,7);
                freq_count(83,1)=freq_count(83,1)+1;
                cycle_count(83,1)=cycle_count(83,1)+2;
                inst_matrix(83,1)=cellstr('MOV direct,R6');
            case '8F' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,8);
                freq_count(84,1)=freq_count(84,1)+1;
                cycle_count(84,1)=cycle_count(84,1)+2;
                inst_matrix(84,1)=cellstr('MOV direct,R7');
                
            case '85' %MOV direct1,direct2
                [PC,cycle,intmem_back]=MovDirToDir(PC,cycle,intmem_back,promem);
                freq_count(85,1)=freq_count(85,1)+1;
                cycle_count(85,1)=cycle_count(85,1)+3;
                inst_matrix(85,1)=cellstr('MOV direct1,direct2');
            
            case '86' %MOV direct,@Ri
                [PC,cycle,intmem_back]=MovUndToDir(PC,cycle,intmem_back,promem,idatax_back,1);
                freq_count(86,1)=freq_count(86,1)+1;
                cycle_count(86,1)=cycle_count(86,1)+2;
                inst_matrix(86,1)=cellstr('MOV direct,@R0');
            case '87' %MOV direct,@Ri
                [PC,cycle,intmem_back]=MovUndToDir(PC,cycle,intmem_back,promem,idatax_back,2);
                freq_count(87,1)=freq_count(87,1)+1;
                cycle_count(87,1)=cycle_count(87,1)+2;
                inst_matrix(87,1)=cellstr('MOV direct,@R1');
                
            case '75' %MOV direct,#data
                [PC,cycle,intmem_back]=MovDataToDir(PC,cycle,intmem_back,promem);
                freq_count(88,1)=freq_count(88,1)+1;
                cycle_count(88,1)=cycle_count(88,1)+3;
                inst_matrix(88,1)=cellstr('MOV direct,#data');
                
            case 'A6' %MOV @Ri,direct
                [PC,cycle,intmem_back,idatax_back]=MovDirToUnd(PC,cycle,intmem_back,idatax_back,promem,1);
                freq_count(89,1)=freq_count(89,1)+1;
                cycle_count(89,1)=cycle_count(89,1)+2;
                inst_matrix(89,1)=cellstr('MOV @R0,direct');
            case 'A7' %MOV @Ri,direct
                [PC,cycle,intmem_back,idatax_back]=MovDirToUnd(PC,cycle,intmem_back,idatax_back,promem,2); 
                freq_count(90,1)=freq_count(90,1)+1;
                cycle_count(90,1)=cycle_count(90,1)+2;
                inst_matrix(90,1)=cellstr('MOV @R1,direct');
                
            case '76' %MOV @Ri,data
                [PC,cycle,intmem_back,idatax_back]=MovDataToUnd(PC,cycle,intmem_back,idatax_back,promem,1);
                freq_count(91,1)=freq_count(91,1)+1;
                cycle_count(91,1)=cycle_count(91,1)+2;
                inst_matrix(91,1)=cellstr('MOV @R0,data');
            case '77' %MOV @Ri,data
                [PC,cycle,intmem_back,idatax_back]=MovDataToUnd(PC,cycle,intmem_back,idatax_back,promem,2);
                freq_count(92,1)=freq_count(92,1)+1;
                cycle_count(92,1)=cycle_count(92,1)+2;
                inst_matrix(92,1)=cellstr('MOV @R1,data');
                
            case '90' %MOV DPTR #data16
                [PC,cycle,intmem_back]=MovDataToDPTR(PC,cycle,promem,intmem_back);
                freq_count(93,1)=freq_count(93,1)+1;
                cycle_count(93,1)=cycle_count(93,1)+3;
                inst_matrix(93,1)=cellstr('MOV DPTR #data16');
                
            case '93' %MOVC A,@A+DPTR
                [PC,cycle,intmem_back]=MovcDPTRToACC(PC,cycle,intmem_back,promem);
                freq_count(94,1)=freq_count(94,1)+1;
                cycle_count(94,1)=cycle_count(94,1)+3;
                inst_matrix(94,1)=cellstr('MOVC A,@A+DPTR');
                
            case '83' %MOVC A,@A+PC
                [PC,cycle,intmem_back]=MovcPCToACC(PC,cycle,intmem_back,promem);
                freq_count(95,1)=freq_count(95,1)+1;
                cycle_count(95,1)=cycle_count(95,1)+3;
                inst_matrix(95,1)=cellstr('MOVC A,@A+PC');
                
            case 'E2' %MOVX A,@Ri
                [PC,cycle,intmem_back]=MovxUndToACC(PC,cycle,intmem_back,extmem_back,1);
                freq_count(96,1)=freq_count(96,1)+1;
                cycle_count(96,1)=cycle_count(96,1)+cycle;
                inst_matrix(96,1)=cellstr('MOVX A,@R0');
            case 'E3' %MOVX A,@Ri
                [PC,cycle,intmem_back]=MovxUndToACC(PC,cycle,intmem_back,extmem_back,2);
                freq_count(97,1)=freq_count(97,1)+1;
                cycle_count(97,1)=cycle_count(97,1)+3;
                inst_matrix(97,1)=cellstr('MOVX A,@R1');
                
            case 'E0' %MOVX A,@DPTR
                [PC,cycle,intmem_back]=MovxDPTRToACC(PC,cycle,intmem_back,extmem_back);
                freq_count(98,1)=freq_count(98,1)+1;
                cycle_count(98,1)=cycle_count(98,1)+3;
                inst_matrix(98,1)=cellstr('MOVX A,@DPTR');
                
            case 'F2' %MOVX @Ri,A
                [PC,cycle,intmem_back,extmem_back]=MovxACCToUnd(PC,cycle,intmem_back,extmem_back,1);
                freq_count(99,1)=freq_count(99,1)+1;
                cycle_count(99,1)=cycle_count(99,1)+3;
                inst_matrix(99,1)=cellstr('MOVX @R0,A');
            case 'F3' %MOVX @Ri,A
                [PC,cycle,intmem_back,extmem_back]=MovxACCToUnd(PC,cycle,intmem_back,extmem_back,2);
                freq_count(100,1)=freq_count(100,1)+1;
                cycle_count(100,1)=cycle_count(100,1)+3;
                inst_matrix(100,1)=cellstr('MOVX @R1,A');
                
            case 'F0' %MOVX @DPTR,A
                [PC,cycle,extmem_back]=MovxACCToDPTR(PC,cycle,intmem_back,extmem_back);
                freq_count(101,1)=freq_count(101,1)+1;
                cycle_count(101,1)=cycle_count(101,1)+3;
                inst_matrix(101,1)=cellstr('MOVX @DPTR,A');
                
            case 'C0' %PUSH direct
                [PC,cycle,intmem_back,idatax_back]=PushDir(PC,cycle,intmem_back,promem,idatax_back);
                freq_count(102,1)=freq_count(102,1)+1;
                cycle_count(102,1)=cycle_count(102,1)+2;
                inst_matrix(102,1)=cellstr('PUSH direct');
                
            case 'D0' %POP direct
                [PC,cycle,intmem_back]=PopDir(PC,cycle,intmem_back,idatax_back,promem);
                freq_count(103,1)=freq_count(103,1)+1;
                cycle_count(103,1)=cycle_count(103,1)+2;
                inst_matrix(103,1)=cellstr('POP direct');
                
            case 'C8' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,1);
                freq_count(104,1)=freq_count(104,1)+1;
                cycle_count(104,1)=cycle_count(104,1)+1;
                inst_matrix(104,1)=cellstr('XCH A,R0');
            case 'C9' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,2);
                freq_count(105,1)=freq_count(105,1)+1;
                cycle_count(105,1)=cycle_count(105,1)+1;
                inst_matrix(105,1)=cellstr('XCH A,R1');
            case 'CA' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,3);
                freq_count(106,1)=freq_count(106,1)+1;
                cycle_count(106,1)=cycle_count(106,1)+1;
                inst_matrix(106,1)=cellstr('XCH A,R2');
            case 'CB' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,4);
                freq_count(107,1)=freq_count(107,1)+1;
                cycle_count(107,1)=cycle_count(107,1)+1;
                inst_matrix(107,1)=cellstr('XCH A,R3');
            case 'CC' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,5);
                freq_count(108,1)=freq_count(108,1)+1;
                cycle_count(108,1)=cycle_count(108,1)+1;
                inst_matrix(108,1)=cellstr('XCH A,R4');
            case 'CD' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,6);
                freq_count(109,1)=freq_count(109,1)+1;
                cycle_count(109,1)=cycle_count(109,1)+1;
                inst_matrix(109,1)=cellstr('XCH A,R5');
            case 'CE' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,7);
                freq_count(110,1)=freq_count(110,1)+1;
                cycle_count(110,1)=cycle_count(110,1)+1;
                inst_matrix(110,1)=cellstr('XCH A,R6');
            case 'CF' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,8);
                freq_count(111,1)=freq_count(111,1)+1;
                cycle_count(111,1)=cycle_count(111,1)+1;
                inst_matrix(111,1)=cellstr('XCH A,R7');
                
            case 'C5' %XCH A,direct
                [PC,cycle,intmem_back]=XchACCDir(PC,cycle,intmem_back,promem);
                freq_count(112,1)=freq_count(112,1)+1;
                cycle_count(112,1)=cycle_count(112,1)+2;
                inst_matrix(112,1)=cellstr('XCH A,direct');
                
            case 'C6' %XCH a,@Ri
                [PC,cycle,intmem_back,idatax_back]=XchACCUnd(PC,cycle,intmem_back,idatax_back,1);
                freq_count(113,1)=freq_count(113,1)+1;
                cycle_count(113,1)=cycle_count(113,1)+2;
                inst_matrix(113,1)=cellstr('XCH a,@R0');
            case 'C7' %XCH a,@Ri
                [PC,cycle,intmem_back,idatax_back]=XchACCUnd(PC,cycle,intmem_back,idatax_back,2);
                freq_count(114,1)=freq_count(114,1)+1;
                cycle_count(114,1)=cycle_count(114,1)+2;
                inst_matrix(114,1)=cellstr('XCH a,@R1');
                
            case 'D6' %XCHD A,@Ri
                [PC,cycle,intmem_back,idatax_back]=XchdACCUnd(PC,cycle,intmem_back,idatax_back,1);
                freq_count(115,1)=freq_count(115,1)+1;
                cycle_count(115,1)=cycle_count(115,1)+2;
                inst_matrix(115,1)=cellstr('XCHD A,@R0');
            case 'D7' %XCHD A,@Ri
                [PC,cycle,intmem_back,idatax_back]=XchdACCUnd(PC,cycle,intmem_back,idatax_back,2);
                freq_count(116,1)=freq_count(116,1)+1;
                cycle_count(116,1)=cycle_count(116,1)+2;
                inst_matrix(116,1)=cellstr('XCHD A,@R1');
                
                
                
                

            
                
               
                
                
            case '28' %ADD A,Rn
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,1);
                freq_count(117,1)=freq_count(117,1)+1;
                cycle_count(117,1)=cycle_count(117,1)+1;
                inst_matrix(117,1)=cellstr('ADD A,R0');
            case '29'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,2);
                freq_count(118,1)=freq_count(118,1)+1;
                cycle_count(118,1)=cycle_count(118,1)+1;
                inst_matrix(118,1)=cellstr('ADD A,R1');
            case '2A'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,3);
                freq_count(119,1)=freq_count(119,1)+1;
                cycle_count(119,1)=cycle_count(119,1)+1;
                inst_matrix(119,1)=cellstr('ADD A,R2');
            case '2B'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,4);
                freq_count(120,1)=freq_count(120,1)+1;
                cycle_count(120,1)=cycle_count(120,1)+1;
                inst_matrix(120,1)=cellstr('ADD A,R3');
            case '2C'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,5);
                freq_count(121,1)=freq_count(122,1)+1;
                cycle_count(121,1)=cycle_count(122,1)+1;
                inst_matrix(121,1)=cellstr('ADD A,R4');
            case '2D'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,6);
                freq_count(122,1)=freq_count(122,1)+1;
                cycle_count(122,1)=cycle_count(122,1)+1;
                inst_matrix(122,1)=cellstr('ADD A,R5');
            case '2E'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,7);
                freq_count(123,1)=freq_count(123,1)+1;
                cycle_count(123,1)=cycle_count(123,1)+1;
                inst_matrix(123,1)=cellstr('ADD A,R6');
            case '2F'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,8);
                freq_count(124,1)=freq_count(124,1)+1;
                cycle_count(124,1)=cycle_count(124,1)+1;
                inst_matrix(124,1)=cellstr('ADD A,R7');
                
            case '25' %ADD A,direct
                [PC,cycle,intmem_back]=AddDirToACC(PC,cycle,intmem_back,promem);
                freq_count(125,1)=freq_count(125,1)+1;
                cycle_count(125,1)=cycle_count(125,1)+2;
                inst_matrix(125,1)=cellstr('ADD A,direct');
                
            case '26' %ADD A,@Ri
                [PC,cycle,intmem_back]=AddUndToACC(PC,cycle,intmem_back,idatax_back,1);
                freq_count(126,1)=freq_count(126,1)+1;
                cycle_count(126,1)=cycle_count(126,1)+2;
                inst_matrix(126,1)=cellstr('ADD A,@R0');
            case '27'
                [PC,cycle,intmem_back]=AddUndToACC(PC,cycle,intmem_back,idatax_back,2);
                freq_count(127,1)=freq_count(127,1)+1;
                cycle_count(127,1)=cycle_count(127,1)+2;
                inst_matrix(127,1)=cellstr('ADD A,@R1');
                
            case '24' %ADD A,#data
                [PC,cycle,intmem_back]=AddDataToACC(PC,cycle,intmem_back,promem);
                freq_count(128,1)=freq_count(128,1)+1;
                cycle_count(128,1)=cycle_count(128,1)+2;
                inst_matrix(128,1)=cellstr('ADD A,#data');
                
            case '38' %ADDC A,Rn
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,1);
                freq_count(129,1)=freq_count(129,1)+1;
                cycle_count(129,1)=cycle_count(129,1)+1;
                inst_matrix(129,1)=cellstr('ADDC A,R0');
            case '39'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,2);
                freq_count(130,1)=freq_count(130,1)+1;
                cycle_count(130,1)=cycle_count(130,1)+1;
                inst_matrix(130,1)=cellstr('ADDC A,R1');
            case '3A'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,3);
                freq_count(131,1)=freq_count(131,1)+1;
                cycle_count(131,1)=cycle_count(131,1)+1;
                inst_matrix(131,1)=cellstr('ADDC A,R2');
            case '3B'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,4);
                freq_count(132,1)=freq_count(132,1)+1;
                cycle_count(132,1)=cycle_count(132,1)+1;
                inst_matrix(132,1)=cellstr('ADDC A,R3');
            case '3C'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,5);
                freq_count(133,1)=freq_count(133,1)+1;
                cycle_count(133,1)=cycle_count(133,1)+1;
                inst_matrix(133,1)=cellstr('ADDC A,R4');
            case '3D'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,6);
                freq_count(134,1)=freq_count(134,1)+1;
                cycle_count(134,1)=cycle_count(134,1)+1;
                inst_matrix(134,1)=cellstr('ADDC A,R5');
            case '3E'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,7);
                freq_count(135,1)=freq_count(135,1)+1;
                cycle_count(135,1)=cycle_count(135,1)+1;
                inst_matrix(135,1)=cellstr('ADDC A,R6');
            case '3F'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,8);
                freq_count(136,1)=freq_count(136,1)+1;
                cycle_count(136,1)=cycle_count(136,1)+1;
                inst_matrix(136,1)=cellstr('ADDC A,R7');
                
            case '35' %ADDC A,direct
                [PC,cycle,intmem_back]=AddcDirToACC(PC,cycle,intmem_back,promem);
                freq_count(137,1)=freq_count(137,1)+1;
                cycle_count(137,1)=cycle_count(137,1)+2;
                inst_matrix(137,1)=cellstr('ADDC A,direct');
                
            case '36' %ADDC A,@Ri
                [PC,cycle,intmem_back]=AddcUndToACC(PC,cycle,intmem_back,idatax_back,1);
                freq_count(138,1)=freq_count(138,1)+1;
                cycle_count(138,1)=cycle_count(138,1)+2;
                inst_matrix(138,1)=cellstr('ADDC A,@R0');
            case '37'
                [PC,cycle,intmem_back]=AddcUndToACC(PC,cycle,intmem_back,idatax_back,2);
                freq_count(138,1)=freq_count(138,1)+1;
                cycle_count(138,1)=cycle_count(138,1)+2;
                inst_matrix(138,1)=cellstr('ADDC A,@R1');
                
            case '34' %ADDC A,#data
                [PC,cycle,intmem_back]=AddcDataToACC(PC,cycle,intmem_back,promem);
                freq_count(139,1)=freq_count(139,1)+1;
                cycle_count(139,1)=cycle_count(139,1)+2;
                inst_matrix(139,1)=cellstr('ADDC A,#data');
                
            case '98' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,1);
                freq_count(140,1)=freq_count(140,1)+1;
                cycle_count(140,1)=cycle_count(140,1)+1;
                inst_matrix(140,1)=cellstr('SUBB A,R0');
            case '99' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,2);
                freq_count(141,1)=freq_count(141,1)+1;
                cycle_count(141,1)=cycle_count(141,1)+1;
                inst_matrix(141,1)=cellstr('SUBB A,R1');
            case '9A' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,3);
                freq_count(142,1)=freq_count(142,1)+1;
                cycle_count(142,1)=cycle_count(142,1)+1;
                inst_matrix(142,1)=cellstr('SUBB A,R2');
            case '9B' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,4);
                freq_count(143,1)=freq_count(143,1)+1;
                cycle_count(143,1)=cycle_count(143,1)+1;
                inst_matrix(143,1)=cellstr('SUBB A,R3');
            case '9C' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,5);
                freq_count(144,1)=freq_count(144,1)+1;
                cycle_count(144,1)=cycle_count(144,1)+1;
                inst_matrix(144,1)=cellstr('SUBB A,R4');
            case '9D' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,6);
                freq_count(145,1)=freq_count(145,1)+1;
                cycle_count(145,1)=cycle_count(145,1)+1;
                inst_matrix(145,1)=cellstr('SUBB A,R5');
            case '9E' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,7);
                freq_count(146,1)=freq_count(146,1)+1;
                cycle_count(146,1)=cycle_count(146,1)+1;
                inst_matrix(146,1)=cellstr('SUBB A,R6');
            case '9F' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,8);
                freq_count(147,1)=freq_count(147,1)+1;
                cycle_count(147,1)=cycle_count(147,1)+1;
                inst_matrix(147,1)=cellstr('SUBB A,R7');
                
            case '95' %SUBB A,direct
                [PC,cycle,intmem_back]=SubbDirToACC(PC,cycle,intmem_back,promem);
                freq_count(148,1)=freq_count(148,1)+1;
                cycle_count(148,1)=cycle_count(148,1)+2;
                inst_matrix(148,1)=cellstr('SUBB A,direct');
                
            case '96' %SUBB A,@Ri
                [PC,cycle,intmem_back]=SubbUndToACC(PC,cycle,intmem_back,idatax_back,1);
                freq_count(149,1)=freq_count(149,1)+1;
                cycle_count(149,1)=cycle_count(149,1)+2;
                inst_matrix(149,1)=cellstr('SUBB A,@R0');
            case '97' %SUBB A,@Ri
                [PC,cycle,intmem_back]=SubbUndToACC(PC,cycle,intmem_back,idatax_back,2);
                freq_count(150,1)=freq_count(150,1)+1;
                cycle_count(150,1)=cycle_count(150,1)+2;
                inst_matrix(150,1)=cellstr('SUBB A,@R1');
                
            case '94' %SUBB A,#data
                [PC,cycle,intmem_back]=SubbDataToACC(PC,cycle,intmem_back,promem);
                freq_count(151,1)=freq_count(151,1)+1;
                cycle_count(151,1)=cycle_count(151,1)+2;
                inst_matrix(151,1)=cellstr('SUBB A,#data');
                            
            case '04'%INC A
                [PC,intmem_back,cycle]=IncACC(PC,cycle,intmem_back);
                freq_count(152,1)=freq_count(152,1)+1;
                cycle_count(152,1)=cycle_count(152,1)+1;
                inst_matrix(152,1)=cellstr('INC A');
                
            case '08'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,1);
                freq_count(153,1)=freq_count(153,1)+1;
                cycle_count(153,1)=cycle_count(153,1)+1;
                inst_matrix(153,1)=cellstr('INC R0');
            case '09'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,2);
                freq_count(154,1)=freq_count(154,1)+1;
                cycle_count(154,1)=cycle_count(154,1)+1;
                inst_matrix(154,1)=cellstr('INC R1');
            case '0A'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,3);
                freq_count(155,1)=freq_count(155,1)+1;
                cycle_count(155,1)=cycle_count(155,1)+1;
                inst_matrix(155,1)=cellstr('INC R2');
            case '0B'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,4);
                freq_count(156,1)=freq_count(156,1)+1;
                cycle_count(156,1)=cycle_count(156,1)+1;
                inst_matrix(156,1)=cellstr('INC R3');
            case '0C'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,5);
                freq_count(157,1)=freq_count(157,1)+1;
                cycle_count(157,1)=cycle_count(157,1)+1;
                inst_matrix(157,1)=cellstr('INC R4');
            case '0D'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,6);
                freq_count(158,1)=freq_count(158,1)+1;
                cycle_count(158,1)=cycle_count(158,1)+1;
                inst_matrix(158,1)=cellstr('INC R5');
            case '0E'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,7);
                freq_count(159,1)=freq_count(159,1)+1;
                cycle_count(159,1)=cycle_count(159,1)+1;
                inst_matrix(159,1)=cellstr('INC R6');
            case '0F'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,8);
                freq_count(160,1)=freq_count(160,1)+1;
                cycle_count(160,1)=cycle_count(160,1)+1;
                inst_matrix(160,1)=cellstr('INC R7');
                
            case '05'%INC direct
                [PC,intmem_back,cycle]=IncDir(PC,cycle,promem,intmem_back);
                freq_count(161,1)=freq_count(161,1)+1;
                cycle_count(161,1)=cycle_count(161,1)+2;
                inst_matrix(161,1)=cellstr('INC direct');
                
            case '06'%INC @R0
                [PC,intmem_back,cycle,idatax_back]=IncUnd(PC,cycle,intmem_back,idatax_back,1);  
                freq_count(162,1)=freq_count(162,1)+1;
                cycle_count(162,1)=cycle_count(162,1)+2;
                inst_matrix(162,1)=cellstr('INC @R0');
            case '07'%INC @R1
                [PC,intmem_back,cycle,idatax_back]=IncUnd(PC,cycle,intmem_back,idatax_back,2);
                freq_count(163,1)=freq_count(163,1)+1;
                cycle_count(163,1)=cycle_count(163,1)+2;
                inst_matrix(163,1)=cellstr('INC @R1');
                
            case 'A3'%INC DPTR
                [PC,intmem_back,cycle]=IncDPTR(PC,cycle,intmem_back);
                freq_count(164,1)=freq_count(164,1)+1;
                cycle_count(164,1)=cycle_count(164,1)+1;
                inst_matrix(164,1)=cellstr('INC DPTR');
                
            case '14' %DEC A
                [PC,intmem_back,cycle]=DecACC(PC,cycle,intmem_back);
                freq_count(165,1)=freq_count(165,1)+1;
                cycle_count(165,1)=cycle_count(165,1)+1;
                inst_matrix(165,1)=cellstr('DEC A');
                
            case '18' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,1);
                freq_count(166,1)=freq_count(166,1)+1;
                cycle_count(166,1)=cycle_count(166,1)+1;
                inst_matrix(166,1)=cellstr('DEC R0');
            case '19' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,2);
                freq_count(167,1)=freq_count(167,1)+1;
                cycle_count(167,1)=cycle_count(167,1)+1;
                inst_matrix(167,1)=cellstr('DEC R1');
            case '1A' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,3);
                freq_count(168,1)=freq_count(168,1)+1;
                cycle_count(168,1)=cycle_count(168,1)+1;
                inst_matrix(168,1)=cellstr('DEC R2');
            case '1B' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,4);
                freq_count(169,1)=freq_count(169,1)+1;
                cycle_count(169,1)=cycle_count(169,1)+1;
                inst_matrix(169,1)=cellstr('DEC R3');
            case '1C' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,5);
                freq_count(170,1)=freq_count(170,1)+1;
                cycle_count(170,1)=cycle_count(170,1)+1;
                inst_matrix(170,1)=cellstr('DEC R4');
            case '1D' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,6);
                freq_count(171,1)=freq_count(171,1)+1;
                cycle_count(171,1)=cycle_count(171,1)+1;
                inst_matrix(171,1)=cellstr('DEC R5');
            case '1E' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,7);
                freq_count(172,1)=freq_count(172,1)+1;
                cycle_count(172,1)=cycle_count(172,1)+1;
                inst_matrix(172,1)=cellstr('DEC R6');
            case '1F' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,8);
                freq_count(173,1)=freq_count(173,1)+1;
                cycle_count(173,1)=cycle_count(173,1)+1;
                inst_matrix(173,1)=cellstr('DEC R7');
                
            case '15' %DEC direct
                [PC,intmem_back,cycle]=DecDir(PC,cycle,intmem_back,promem);
                freq_count(174,1)=freq_count(174,1)+1;
                cycle_count(174,1)=cycle_count(174,1)+2;
                inst_matrix(174,1)=cellstr('DEC direct');
                
            case '16' %DEC @Ri
                [PC,intmem_back,idatax_back,cycle]=DecUnd(PC,cycle,intmem_back,idatax_back,1);
                freq_count(175,1)=freq_count(175,1)+1;
                cycle_count(175,1)=cycle_count(175,1)+2;
                inst_matrix(175,1)=cellstr('DEC @R0');
            case '17' %DEC @Ri
                [PC,intmem_back,idatax_back,cycle]=DecUnd(PC,cycle,intmem_back,idatax_back,2); 
                freq_count(176,1)=freq_count(176,1)+1;
                cycle_count(176,1)=cycle_count(176,1)+2;
                inst_matrix(176,1)=cellstr('DEC @R1');
                
            case 'A4' %MUL A,B
                [PC,intmem_back,cycle]=MulAB(PC,cycle,intmem_back);
                freq_count(177,1)=freq_count(177,1)+1;
                cycle_count(177,1)=cycle_count(177,1)+4;
                inst_matrix(177,1)=cellstr('MUL A,B');
                
            case '84' %DIV A,B
                [PC,intmem_back,cycle]=DivAB(PC,cycle,intmem_back);
                freq_count(178,1)=freq_count(178,1)+1;
                cycle_count(178,1)=cycle_count(178,1)+4;
                inst_matrix(178,1)=cellstr('DIV A,B');
                
            case 'D4' %DA A
                %[PC,cycle]=DataAdj(PC,cycle);
                [PC,cycle,intmem_back,idatax_back]=permutation(PC,cycle,intmem_back,idatax_back);
                freq_count(179,1)=freq_count(179,1)+1;
                cycle_count(179,1)=cycle_count(179,1)+1;
                inst_matrix(179,1)=cellstr('DA A');
                
            
                
            case '58' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,1);
                freq_count(180,1)=freq_count(180,1)+1;
                cycle_count(180,1)=cycle_count(180,1)+1;
                inst_matrix(180,1)=cellstr('ANL A,R0');
            case '59' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,2);
                freq_count(181,1)=freq_count(181,1)+1;
                cycle_count(181,1)=cycle_count(181,1)+1;
                inst_matrix(181,1)=cellstr('ANL A,R1');
            case '5A' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,3); 
                freq_count(182,1)=freq_count(182,1)+1;
                cycle_count(182,1)=cycle_count(182,1)+1;
                inst_matrix(182,1)=cellstr('ANL A,R2');
            case '5B' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,4); 
                freq_count(183,1)=freq_count(183,1)+1;
                cycle_count(183,1)=cycle_count(183,1)+1;
                inst_matrix(183,1)=cellstr('ANL A,R3');
            case '5C' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,5);
                freq_count(184,1)=freq_count(184,1)+1;
                cycle_count(184,1)=cycle_count(184,1)+1;
                inst_matrix(184,1)=cellstr('ANL A,R4');
            case '5D' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,6);  
                freq_count(185,1)=freq_count(185,1)+1;
                cycle_count(185,1)=cycle_count(185,1)+1;
                inst_matrix(185,1)=cellstr('ANL A,R5');
            case '5E' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,7);
                freq_count(186,1)=freq_count(186,1)+1;
                cycle_count(186,1)=cycle_count(186,1)+1;
                inst_matrix(186,1)=cellstr('ANL A,R6');
            case '5F' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,8);
                freq_count(187,1)=freq_count(187,1)+1;
                cycle_count(187,1)=cycle_count(187,1)+1;
                inst_matrix(187,1)=cellstr('ANL A,R7');
                
            case '55' %ANL direct
                [PC,cycle,intmem_back]=AnlDirToACC(PC,cycle,intmem_back,promem);
                freq_count(188,1)=freq_count(188,1)+1;
                cycle_count(188,1)=cycle_count(188,1)+2;
                inst_matrix(188,1)=cellstr('ANL direct');
                
            case '56' %ANL A,@Ri
                [PC,cycle,intmem_back]=AnlUndToACC(PC,cycle,intmem_back,idatax_back,1);
                freq_count(189,1)=freq_count(189,1)+1;
                cycle_count(189,1)=cycle_count(189,1)+2;
                inst_matrix(189,1)=cellstr('ANL A,@R0');
            case '57' %ANL A,@Ri
                [PC,cycle,intmem_back]=AnlUndToACC(PC,cycle,intmem_back,idatax_back,2);
                freq_count(190,1)=freq_count(190,1)+1;
                cycle_count(190,1)=cycle_count(190,1)+2;
                inst_matrix(190,1)=cellstr('ANL A,@R1');
                
            case '54' %ANL A,#data
                [PC,cycle,intmem_back]=AnlDataToACC(PC,cycle,intmem_back,promem);
                freq_count(191,1)=freq_count(191,1)+1;
                cycle_count(191,1)=cycle_count(191,1)+2;
                inst_matrix(191,1)=cellstr('ANL A,#data');
                
            case '52' %ANL direct,A
                [PC,cycle,intmem_back]=AnlACCToDir(PC,cycle,intmem_back,promem);
                freq_count(192,1)=freq_count(192,1)+1;
                cycle_count(192,1)=cycle_count(192,1)+2;
                inst_matrix(192,1)=cellstr('ANL direct,A');
                
            case '53' %ANL direct,#data
                [PC,cycle,intmem_back]=AnlDataToDir(PC,cycle,intmem_back,promem);
                freq_count(193,1)=freq_count(193,1)+1;
                cycle_count(193,1)=cycle_count(193,1)+3;
                inst_matrix(193,1)=cellstr('ANL direct,#data');
                
            case '48' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,1);
                freq_count(194,1)=freq_count(194,1)+1;
                cycle_count(194,1)=cycle_count(194,1)+1;
                inst_matrix(194,1)=cellstr('ORL A,R0');
            case '49' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,2);
                freq_count(195,1)=freq_count(195,1)+1;
                cycle_count(195,1)=cycle_count(195,1)+1;
                inst_matrix(195,1)=cellstr('ORL A,R1');
            case '4A' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,3); 
                freq_count(196,1)=freq_count(196,1)+1;
                cycle_count(196,1)=cycle_count(196,1)+1;
                inst_matrix(196,1)=cellstr('ORL A,R2');
            case '4B' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,4);  
                freq_count(197,1)=freq_count(197,1)+1;
                cycle_count(197,1)=cycle_count(197,1)+1;
                inst_matrix(197,1)=cellstr('ORL A,R3');
            case '4C' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,5);
                freq_count(198,1)=freq_count(198,1)+1;
                cycle_count(198,1)=cycle_count(198,1)+1;
                inst_matrix(198,1)=cellstr('ORL A,R4');
            case '4D' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,6); 
                freq_count(199,1)=freq_count(199,1)+1;
                cycle_count(199,1)=cycle_count(199,1)+1;
                inst_matrix(199,1)=cellstr('ORL A,R5');
            case '4E' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,7); 
                freq_count(200,1)=freq_count(200,1)+1;
                cycle_count(200,1)=cycle_count(200,1)+1;
                inst_matrix(200,1)=cellstr('ORL A,R6');
            case '4F' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,8);
                freq_count(201,1)=freq_count(201,1)+1;
                cycle_count(201,1)=cycle_count(201,1)+1;
                inst_matrix(201,1)=cellstr('ORL A,R7');
            
            case '45' %ORL A,direct
                [PC,cycle,intmem_back]=OrlDirToACC(PC,cycle,intmem_back,promem);
                freq_count(202,1)=freq_count(202,1)+1;
                cycle_count(202,1)=cycle_count(202,1)+2;
                inst_matrix(202,1)=cellstr('ORL A,direct');
                
            case '46' %ORL A,@Ri
                [PC,cycle,intmem_back]=OrlUndToACC(PC,cycle,intmem_back,idatax_back,1);
                freq_count(203,1)=freq_count(203,1)+1;
                cycle_count(203,1)=cycle_count(203,1)+2;
                inst_matrix(203,1)=cellstr('ORL A,@R0');
            case '47' %ORL A,@Ri
                [PC,cycle,intmem_back]=OrlUndToACC(PC,cycle,intmem_back,idatax_back,2); 
                freq_count(204,1)=freq_count(204,1)+1;
                cycle_count(204,1)=cycle_count(204,1)+2;
                inst_matrix(204,1)=cellstr('ORL A,@R1');
                
            case '44' %ORL A,#data
                [PC,cycle,intmem_back]=OrlDataToACC(PC,cycle,intmem_back,promem);
                freq_count(205,1)=freq_count(205,1)+1;
                cycle_count(205,1)=cycle_count(205,1)+2;
                inst_matrix(205,1)=cellstr('ORL A,#data');
                
            case '42' %ORL direct,A
                [PC,cycle,intmem_back]=OrlACCToDir(PC,cycle,intmem_back,promem);  
                freq_count(206,1)=freq_count(206,1)+1;
                cycle_count(206,1)=cycle_count(206,1)+2;
                inst_matrix(206,1)=cellstr('ORL direct,A');
                
            case '43' %ORL direct,#data
                [PC,cycle,intmem_back]=OrlDataToDir(PC,cycle,intmem_back,promem);
                freq_count(207,1)=freq_count(207,1)+1;
                cycle_count(207,1)=cycle_count(207,1)+3;
                inst_matrix(207,1)=cellstr('ORL direct,#data');
                
            case '68' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,1);
                freq_count(208,1)=freq_count(208,1)+1;
                cycle_count(208,1)=cycle_count(208,1)+1;
                inst_matrix(208,1)=cellstr('XRL A,R0');
            case '69' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,2);
                freq_count(209,1)=freq_count(209,1)+1;
                cycle_count(209,1)=cycle_count(209,1)+1;
                inst_matrix(209,1)=cellstr('XRL A,R1');
            case '6A' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,3); 
                freq_count(210,1)=freq_count(210,1)+1;
                cycle_count(210,1)=cycle_count(210,1)+1;
                inst_matrix(210,1)=cellstr('XRL A,R2');
            case '6B' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,4);
                freq_count(211,1)=freq_count(211,1)+1;
                cycle_count(211,1)=cycle_count(211,1)+1;
                inst_matrix(211,1)=cellstr('XRL A,R3');
            case '6C' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,5);
                freq_count(212,1)=freq_count(212,1)+1;
                cycle_count(212,1)=cycle_count(212,1)+1;
                inst_matrix(212,1)=cellstr('XRL A,R4');
            case '6D' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,6); 
                freq_count(213,1)=freq_count(213,1)+1;
                cycle_count(213,1)=cycle_count(213,1)+1;
                inst_matrix(213,1)=cellstr('XRL A,R5');
            case '6E' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,7); 
                freq_count(214,1)=freq_count(214,1)+1;
                cycle_count(214,1)=cycle_count(214,1)+1;
                inst_matrix(214,1)=cellstr('XRL A,R6');
            case '6F' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,8);
                freq_count(215,1)=freq_count(215,1)+1;
                cycle_count(215,1)=cycle_count(215,1)+1;
                inst_matrix(215,1)=cellstr('XRL A,R7');
            
            case '65' %XRL A,direct
                [PC,cycle,intmem_back]=XrlDirToACC(PC,cycle,intmem_back,promem);
                freq_count(216,1)=freq_count(216,1)+1;
                cycle_count(216,1)=cycle_count(216,1)+2;
                inst_matrix(216,1)=cellstr('XRL A,direct');
                
            case '66' %XRL A,@Ri
                [PC,cycle,intmem_back]=XorACCUnd(PC,cycle,intmem_back,idatax_back,1);
                freq_count(217,1)=freq_count(217,1)+1;
                cycle_count(217,1)=cycle_count(217,1)+2;
                inst_matrix(217,1)=cellstr('XRL A,@R0');
            case '67' %XRL A,@Ri
                [PC,cycle,intmem_back]=XorACCUnd(PC,cycle,intmem_back,idatax_back,2);
                freq_count(218,1)=freq_count(218,1)+1;
                cycle_count(218,1)=cycle_count(218,1)+2;
                inst_matrix(218,1)=cellstr('XRL A,@R1');
                
            case '64' %XRL A,#data
                [PC,cycle,intmem_back]=XrlDataToACC(PC,cycle,intmem_back,promem);
                freq_count(219,1)=freq_count(219,1)+1;
                cycle_count(219,1)=cycle_count(219,1)+2;
                inst_matrix(219,1)=cellstr('XRL A,#data');
                
            case '62' %XRL direct,A
                [PC,cycle,intmem_back]=XrlACCToDir(PC,cycle,intmem_back,promem);   
                freq_count(220,1)=freq_count(220,1)+1;
                cycle_count(220,1)=cycle_count(220,1)+2;
                inst_matrix(220,1)=cellstr('XRL direct,A');
                
            case '63' %XRL direct,#data
                [PC,cycle,intmem_back]=XrlDataToDir(PC,cycle,intmem_back,promem);
                freq_count(221,1)=freq_count(221,1)+1;
                cycle_count(221,1)=cycle_count(221,1)+3;
                inst_matrix(221,1)=cellstr('XRL direct,#data');
                
            case 'F4' %CPL A
                [PC,cycle,intmem_back]=CplACC(PC,cycle,intmem_back);
                freq_count(222,1)=freq_count(222,1)+1;
                cycle_count(222,1)=cycle_count(222,1)+1;
                inst_matrix(222,1)=cellstr('CPL A');
                
            case '23' %RL A
                [PC,cycle,intmem_back]=RotLeftACC(PC,cycle,intmem_back);
                freq_count(223,1)=freq_count(223,1)+1;
                cycle_count(223,1)=cycle_count(223,1)+1;
                inst_matrix(223,1)=cellstr('RL A');
                
            case '33' %RLC A
                [PC,cycle,intmem_back]=RotcLeftACC(PC,cycle,intmem_back);
                freq_count(224,1)=freq_count(224,1)+1;
                cycle_count(224,1)=cycle_count(224,1)+1;
                inst_matrix(224,1)=cellstr('RLC A');
                %[PC,cycle,intmem_back]=RotLeftACC(PC,cycle,intmem_back);
                
            case '03' %RR A
                [PC,cycle,intmem_back]=RotRightACC(PC,cycle,intmem_back);
                freq_count(225,1)=freq_count(225,1)+1;
                cycle_count(225,1)=cycle_count(225,1)+1;
                inst_matrix(225,1)=cellstr('RR A');
                
            case '13' %RRC A
                [PC,cycle,intmem_back]=RotcRightACC(PC,cycle,intmem_back);
                freq_count(226,1)=freq_count(226,1)+1;
                cycle_count(226,1)=cycle_count(226,1)+1;
                inst_matrix(226,1)=cellstr('RRC A');
                %[PC,cycle,intmem_back]=RotRightACC(PC,cycle,intmem_back);
            case 'C4' %SWAP A
                [PC,cycle,intmem_back]=SwapACC(PC,cycle,intmem_back);
                freq_count(227,1)=freq_count(227,1)+1;
                cycle_count(227,1)=cycle_count(227,1)+1;
                inst_matrix(227,1)=cellstr('SWAP A');
                
                
                
                
                
                
                
                
                
                
                
            case 'C3' %CLR C
                [PC,cycle,intmem_back]=ClearC(PC,cycle,intmem_back);
                freq_count(228,1)=freq_count(228,1)+1;
                cycle_count(228,1)=cycle_count(228,1)+1;
                inst_matrix(228,1)=cellstr('CLR C');
                
            case 'C2' %CLR bit
                [PC,cycle,intmem_back]=ClearBit(PC,cycle,intmem_back,promem);
                freq_count(229,1)=freq_count(229,1)+1;
                cycle_count(229,1)=cycle_count(229,1)+2;
                inst_matrix(229,1)=cellstr('CLR bit');
                
            case 'D3' %SETB C
                [PC,cycle,intmem_back]=SETBC(PC,cycle,intmem_back);
                freq_count(230,1)=freq_count(230,1)+1;
                cycle_count(230,1)=cycle_count(230,1)+1;
                inst_matrix(230,1)=cellstr('SETB C');
            
            case 'D2' %SETB bit
                [PC,cycle,intmem_back]=SetBit(PC,cycle,intmem_back,promem);
                freq_count(231,1)=freq_count(231,1)+1;
                cycle_count(231,1)=cycle_count(231,1)+2;
                inst_matrix(231,1)=cellstr('SETB bit');
                
            case 'B3' %CPL C
                [PC,cycle,intmem_back]=CPLC(PC,cycle,intmem_back);
                freq_count(232,1)=freq_count(232,1)+1;
                cycle_count(232,1)=cycle_count(232,1)+2;
                inst_matrix(232,1)=cellstr('CPL C');
                
            case 'B2' %CPL bit
                [PC,cycle,intmem_back]=CPLBit(PC,cycle,intmem_back,promem);
                freq_count(233,1)=freq_count(233,1)+1;
                cycle_count(233,1)=cycle_count(233,1)+2;
                inst_matrix(233,1)=cellstr('CPL bit');
                
            case '82' %ANL C,bit
                [PC,cycle,intmem_back]=ANLCBit(PC,cycle,intmem_back,promem);
                freq_count(234,1)=freq_count(234,1)+1;
                cycle_count(234,1)=cycle_count(234,1)+2;
                inst_matrix(234,1)=cellstr('ANL C,bit');
                
            case 'B0' %ANL C,/bit
                [PC,cycle,intmem_back]=ANLCUBit(PC,cycle,intmem_back,promem);
                freq_count(235,1)=freq_count(235,1)+1;
                cycle_count(235,1)=cycle_count(235,1)+2;
                inst_matrix(235,1)=cellstr('ANL C,/bit');
                
            case '72' %ORL C,bit
                [PC,cycle,intmem_back]=ORLCBit(PC,cycle,intmem_back,promem);
                freq_count(236,1)=freq_count(236,1)+1;
                cycle_count(236,1)=cycle_count(236,1)+2;
                inst_matrix(236,1)=cellstr('ORL C,bit');
                
            case 'A0' %ORL C,/bit
                [PC,cycle,intmem_back]=ORLCUBit(PC,cycle,intmem_back,promem);
                freq_count(237,1)=freq_count(237,1)+1;
                cycle_count(237,1)=cycle_count(237,1)+2;
                inst_matrix(237,1)=cellstr('ORL C,/bit');
                
            case 'A2' %MOV C,bit
                [PC,cycle,intmem_back]=MOVCBit(PC,cycle,intmem_back,promem);
                freq_count(238,1)=freq_count(238,1)+1;
                cycle_count(238,1)=cycle_count(238,1)+2;
                inst_matrix(238,1)=cellstr('MOV C,bit');
                
            case '92' %MOV bit,C
                [PC,cycle,intmem_back]=MOVBitC(PC,cycle,intmem_back,promem);
                freq_count(239,1)=freq_count(239,1)+1;
                cycle_count(239,1)=cycle_count(239,1)+2;
                inst_matrix(239,1)=cellstr('MOV bit,C');
                
                
                
                
                
                
            otherwise
                flag=1;
            
            
                
                
                
                
        cycle        
               
        end
 %   end
 
    
 
 
    
    %return value
    B=intmem_back(241,1);%F0+1
    ACC=intmem_back(225,1);%E0+1
    PSW=loadPSW(intmem_back(209,1));%D0+1
    SP=intmem_back(130,1);%81+1
    DPL=intmem_back(131,1);%DPTR low
    DPH=intmem_back(132,1);%DPTR high
    DPTR=DPH*(2^8)+DPL;%DPTR
%     SP=dec2hex(SP);
    %Rn,C
    tmp=loadPSW(intmem_back(209,1));
    if (tmp(4,1)==0 && tmp(5,1)==0)
        Rn=intmem_back(1:8);
    elseif (tmp(4,1)==0 && tmp(5,1)==1)
        Rn=intmem_back(9:16);
    elseif (tmp(4,1)==1 && tmp(5,1)==0)
        Rn=intmem_back(17:24);
    elseif (tmp(4,1)==1 && tmp(5,1)==1)
        Rn=intmem_back(25:32);
    end
    C=PSW(1,1);
    flag=branchNumber;
    assignin('base','promem',promem);
    assignin('base','extmem',extmem);
    assignin('base','intmem',intmem);
    assignin('base','idatax',idatax);
    assignin('base','PC',PC);
    assignin('base','cycle',cycle);
    assignin('base','ACC',ACC);
    assignin('base','B',B);
    assignin('base','PSW',PSW);
    assignin('base','SP',SP);
    assignin('base','DPTR',DPTR);
    assignin('base','Rn',Rn);
    assignin('base','C',C);
    assignin('base','flag',flag);
    assignin('base','branchNumber',branchNumber);
end