function [intmem_back,extmem_back,idatax_back,PC,cycle,ACC,B,PSW,SP,DPTR,Rn,C,flag]=startsim(promem,intmem,extmem,idatax,PC,cycle,ACC,B,PSW,SP,DPTR,Rn,C,flag,branchNumber) 
   
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
%    while (flag==0)
        cur_instruction=cur_instruction+1;
        Instruction=promem(PC,1);
        opcode=dec2hex(Instruction,2);
        switch(opcode)
            case '02' %LJMP addr16
               [PC,cycle]=LJMPaddr16(PC,promem,cycle);
             
               
               
            case {'11','31','51','71','91','B1','D1','F1'}%ACALL addr11
                [PC,cycle,intmem_back,idatax_back]=AcallAddr11(PC,cycle,intmem_back,idatax_back,promem);
                
                       
            case 'B5' %CJNE A,direct,rel
                [PC,cycle,intmem_back]=CompACCDirect(PC,intmem_back,cycle,promem);
            
            case 'B4' %CJNE A,#data,rel
                [PC,cycle,intmem_back]=CompACCData(PC,cycle,intmem_back,promem);
            
            case 'B8' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,1);
            case 'B9' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,2);
            case 'BA' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,3);
            case 'BB' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,4);
            case 'BC' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,5);
            case 'BD' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,6);
            case 'BE' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,7);
            case 'BF' %CJNE Rn,#data,rel
                [PC,cycle,intmem_back]=CompRegData(PC,cycle,intmem_back,promem,8);
                
            case 'B6' %CJNE @Ri,#data,rel
                [PC,cycle,intmem_back]=CompUndData(PC,cycle,intmem_back,idatax_back,promem,1);
            case 'B7' %CJNE @Ri,#data,rel
                [PC,cycle,intmem_back]=CompUndData(PC,cycle,intmem_back,idatax_back,promem,2);
                
            case 'D8' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,1);
            case 'D9' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,2);
            case 'DA' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,3);    
            case 'DB' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,4);    
            case 'DC' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,5);    
            case 'DD' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,6);    
            case 'DE' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,7);    
            case 'DF' %DJNZ Rn,rel
                [PC,cycle,intmem_back]=DecRegJumUnz(PC,cycle,intmem_back,promem,8); 
                
            case 'D5' %DJNZ direct,rel
                [PC,cycle,intmem_back]=DecDirJumUnz(PC,cycle,intmem_back,promem);
                
            case '22' %RET
                [PC,cycle,intmem_back]=RET(cycle,intmem_back,idatax_back);
                
            case '32' %RETI
                [PC,cycle,intmem_back]=RETI(ctcle,intmem_back,idatax_back);
                
            case {'01','21','41','61','81', 'A1','C1','E1'}%AJMP addr11
                [PC,cycle]=AJMPaddr11(PC,promem,cycle);
                
            case '00' %NOP
                PC=PC+1;
                cycle=cycle+1;
            
            case '80' %SJMP rel 2 2
                [PC,cycle]=SJMPrel(PC,promem,cycle); 
            
            case '12' %LCALL addr16
                [PC,intmem_back,cycle,idatax_back]=LCALLaddr16(PC,intmem_back,promem,cycle,idatax_back);
            
            case 'E4' %CLR A
                [PC,intmem_back,cycle]=ClearACC(PC,intmem_back,cycle);
            
            case '73' %JMP,@A+DPTR
                [PC,cycle]=JMPACCDPTR(PC,cycle,intmem_back);
                
            case '60' %JZ rel
                [PC,cycle]=JZrel(PC,cycle,intmem_back,promem);
                
            case '70' %JNZ rel
                [PC,cycle]=JNZrel(PC,cycle,intmem_back,promem);
                
            case '40' %JC rel
                [PC,cycle]=JC(PC,cycle,intmem_back,promem);
                
            case '50' %JNC rel
                [PC,cycle]=JNC(PC,cycle,intmem_back,promem);
                
            case '20' %JB bit,rel
                [PC,cycle]=JB(PC,cycle,intmem_back,promem);
                
            case '30' %JNB bit rel
                [PC,cycle]=JNB(PC,cycle,intmem_back,promem);
                
            case '10' %JBC bit,rel
                [PC,cycle,intmem_back]=JBC(PC,cycle,intmem_back,promem);
                
           
                
                
           
            
            
            
            
            
            case 'E8' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,1);
            case 'E9' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,2);
            case 'EA' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,3);
            case 'EB' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,4);
            case 'EC' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,5);
            case 'ED' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,6);
            case 'EE' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,7);
            case 'EF' %MOV A,Rn
                [PC,intmem_back,cycle]=MovRegToACC(PC,intmem_back,cycle,8);
                
            case 'E5' %MOV A,direct
                [PC,intmem_back,cycle]=MovDirToACC(PC,intmem_back,promem,cycle);
            
            case 'E6' %MOV A,@Ri
                [PC,cycle,intmem_back,idatax_back]=MovUndToACC(PC,cycle,intmem_back,idatax_back,1);
            case 'E7' %MOV A,@Ri
                [PC,cycle,intmem_back,idatax_back]=MovUndToACC(PC,cycle,intmem_back,idatax_back,2);
                
            case '74' %MOV A,#data
                [PC,cycle,intmem_back]=MovDataToACC(PC,cycle,intmem_back,promem);
                
            case 'A8' %MOV R0,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,1);
            case 'A9' %MOV R1,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,2);
            case 'AA' %MOV R2,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,3);
            case 'AB' %MOV R3,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,4);
            case 'AC' %MOV R4,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,5);
            case 'AD' %MOV R5,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,6);
            case 'AE' %MOV R6,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,7);
            case 'AF' %MOV R7,direct
                [PC,intmem_back,cycle]=MovDirectToReg(PC,intmem_back,cycle,promem,8);
                
            case 'F6' %MOV @R0,A
                [PC,cycle,intmem_back,idatax_back]=MovACCToUnd(PC,cycle,intmem_back,idatax_back,1);
            case 'F7' %MOV @R1,A 
                [PC,cycle,intmem_back,idatax_back]=MovACCToUnd(PC,cycle,intmem_back,idatax_back,2);
                
            case 'F8' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,1);
            case 'F9' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,2);
            case 'FA' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,3);
            case 'FB' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,4);
            case 'FC' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,5);
            case 'FD' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,6);
            case 'FE' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,7);
            case 'FF' %MOV R0,A
                [PC,cycle,intmem_back]=MovACCToReg(PC,cycle,intmem_back,8);
                
            case '78' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,1);
            case '79' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,2);
            case '7A' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,3);
            case '7B' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,4);
            case '7C' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,5);
            case '7D' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,6);
            case '7E' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,7);
            case '7F' %MOV Rn,#data
                [PC,cycle,intmem_back]=MovDataToReg(PC,cycle,intmem_back,promem,8);
                
            case 'F5' %MOV direct,A
                [PC,cycle,intmem_back]=MovACCToDir(PC,cycle,intmem_back,promem);
                
            case '88' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,1);
            case '89' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,2);
            case '8A' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,3);
            case '8B' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,4);
            case '8C' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,5);
            case '8D' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,6);
            case '8E' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,7);
            case '8F' %MOV direct,Rn
                [PC,cycle,intmem_back]=MovRegToDir(PC,cycle,intmem_back,promem,8);
                
            case '85' %MOV direct1,direct2
                [PC,cycle,intmem_back]=MovDirToDir(PC,cycle,intmem_back,promem);
            
            case '86' %MOV direct,@Ri
                [PC,cycle,intmem_back]=MovUndToDir(PC,cycle,intmem_back,promem,idatax_back,1);
            case '87' %MOV direct,@Ri
                [PC,cycle,intmem_back]=MovUndToDir(PC,cycle,intmem_back,promem,idatax_back,2);
                
            case '75' %MOV direct,#data
                [PC,cycle,intmem_back]=MovDataToDir(PC,cycle,intmem_back,promem);
                
            case 'A6' %MOV @Ri,direct
                [PC,cycle,intmem_back,idatax_back]=MovDirToUnd(PC,cycle,intmem_back,idatax_back,promem,1);
            case 'A7' %MOV @Ri,direct
                [PC,cycle,intmem_back,idatax_back]=MovDirToUnd(PC,cycle,intmem_back,idatax_back,promem,2);   
                
            case '76' %MOV @Ri,data
                [PC,cycle,intmem_back,idatax_back]=MovDataToUnd(PC,cycle,intmem_back,idatax_back,promem,1);
            case '77' %MOV @Ri,data
                [PC,cycle,intmem_back,idatax_back]=MovDataToUnd(PC,cycle,intmem_back,idatax_back,promem,2);
                
            case '90' %MOV DPTR #data16
                [PC,cycle,intmem_back]=MovDataToDPTR(PC,cycle,promem,intmem_back);
                
            case '93' %MOVC A,@A+DPTR
                [PC,cycle,intmem_back]=MovcDPTRToACC(PC,cycle,intmem_back,promem);
                
            case '83' %MOVC A,@A+PC
                [PC,cycle,intmem_back]=MovcPCToACC(PC,cycle,intmem_back,promem);
                
            case 'E2' %MOVX A,@Ri
                [PC,cycle,intmem_back]=MovxUndToACC(PC,cycle,intmem_back,extmem_back,1);
            case 'E3' %MOVX A,@Ri
                [PC,cycle,intmem_back]=MovxUndToACC(PC,cycle,intmem_back,extmem_back,2);
                
            case 'E0' %MOVX A,@DPTR
                [PC,cycle,intmem_back]=MovxDPTRToACC(PC,cycle,intmem_back,extmem_back);
                
            case 'F2' %MOVX @Ri,A
                [PC,cycle,intmem_back,extmem_back]=MovxACCToUnd(PC,cycle,intmem_back,extmem_back,1);
            case 'F3' %MOVX @Ri,A
                [PC,cycle,intmem_back,extmem_back]=MovxACCToUnd(PC,cycle,intmem_back,extmem_back,2);
                
            case 'F0' %MOVX @DPTR,A
                [PC,cycle,extmem_back]=MovxACCToDPTR(PC,cycle,intmem_back,extmem_back);
                
            case 'C0' %PUSH direct
                [PC,cycle,intmem_back,idatax_back]=PushDir(PC,cycle,intmem_back,promem,idatax_back);
                
            case 'D0' %POP direct
                [PC,cycle,intmem_back]=PopDir(PC,cycle,intmem_back,idatax_back,promem);
                
            case 'C8' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,1);
            case 'C9' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,2);
            case 'CA' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,3);
            case 'CB' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,4);
            case 'CC' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,5);
            case 'CD' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,6);
            case 'CE' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,7);
            case 'CF' %XCH A,Rn
                [PC,cycle,intmem_back]=XchACCReg(PC,cycle,intmem_back,8);
                
            case 'C5' %XCH A,direct
                [PC,cycle,intmem_back]=XchACCDir(PC,cycle,intmem_back,promem);
                
            case 'C6' %XCH a,@Ri
                [PC,cycle,intmem_back,idatax_back]=XchACCUnd(PC,cycle,intmem_back,idatax_back,1);
            case 'C7' %XCH a,@Ri
                [PC,cycle,intmem_back,idatax_back]=XchACCUnd(PC,cycle,intmem_back,idatax_back,2);
                
            case 'D6' %XCHD A,@Ri
                [PC,cycle,intmem_back,idatax_back]=XchdACCUnd(PC,cycle,intmem_back,idatax_back,1);
            case 'D7' %XCHD A,@Ri
                [PC,cycle,intmem_back,idatax_back]=XchdACCUnd(PC,cycle,intmem_back,idatax_back,2);
                
                
                
                

            
                
               
                
                
            case '28' %ADD A,Rn
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,1);
            case '29'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,2);
            case '2A'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,3);
            case '2B'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,4);
            case '2C'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,5);
            case '2D'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,6);
            case '2E'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,7);
            case '2F'
                [PC,cycle,intmem_back]=AddRegToACC(PC,cycle,intmem_back,8);
                
            case '25' %ADD A,direct
                [PC,cycle,intmem_back]=AddDirToACC(PC,cycle,intmem_back,promem);
                
            case '26' %ADD A,@Ri
                [PC,cycle,intmem_back]=AddUndToACC(PC,cycle,intmem_back,idatax_back,1);
            case '27'
                [PC,cycle,intmem_back]=AddUndToACC(PC,cycle,intmem_back,idatax_back,2);
                
            case '24' %ADD A,#data
                [PC,cycle,intmem_back]=AddDataToACC(PC,cycle,intmem_back,promem);
                
            case '38' %ADDC A,Rn
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,1);
            case '39'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,2);
            case '3A'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,3);
            case '3B'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,4);
            case '3C'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,5);
            case '3D'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,6);
            case '3E'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,7);
            case '3F'
                [PC,cycle,intmem_back]=AddcRegToACC(PC,cycle,intmem_back,8);
                
            case '35' %ADDC A,direct
                [PC,cycle,intmem_back]=AddcDirToACC(PC,cycle,intmem_back,promem);
                
            case '36' %ADDC A,@Ri
                [PC,cycle,intmem_back]=AddcUndToACC(PC,cycle,intmem_back,idatax_back,1);
            case '37'
                [PC,cycle,intmem_back]=AddcUndToACC(PC,cycle,intmem_back,idatax_back,2);
                
            case '34' %ADDC A,#data
                [PC,cycle,intmem_back]=AddcDataToACC(PC,cycle,intmem_back,promem);
                
            case '98' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,1);
            case '99' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,2);
            case '9A' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,3);
            case '9B' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,4);
            case '9C' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,5);
            case '9D' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,6);
            case '9E' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,7);
            case '9F' %SUBB A,Rn
                [PC,cycle,intmem_back]=SubbRegToACC(PC,cycle,intmem_back,8);
                
            case '95' %SUBB A,direct
                [PC,cycle,intmem_back]=SubbDirToACC(PC,cycle,intmem_back,promem);
                
            case '96' %SUBB A,@Ri
                [PC,cycle,intmem_back]=SubbUndToACC(PC,cycle,intmem_back,idatax_back,1);
            case '97' %SUBB A,@Ri
                [PC,cycle,intmem_back]=SubbUndToACC(PC,cycle,intmem_back,idatax_back,2);
                
            case '94' %SUBB A,#data
                [PC,cycle,intmem_back]=SubbDataToACC(PC,cycle,intmem_back,promem);
                            
            case '04'%INC A
                [PC,intmem_back,cycle]=IncACC(PC,cycle,intmem_back);
                
            case '08'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,1);
            case '09'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,2);
            case '0A'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,3);
            case '0B'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,4);
            case '0C'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,5);
            case '0D'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,6);
            case '0E'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,7);
            case '0F'%INC Rn
                [PC,intmem_back,cycle]=IncReg(PC,cycle,intmem_back,8);
                
            case '05'%INC direct
                [PC,intmem_back,cycle]=IncDir(PC,cycle,promem,intmem_back);
                
            case '06'%INC indirect
                [PC,intmem_back,cycle,idatax_back]=IncUnd(PC,cycle,intmem_back,idatax_back,1);    
            case '07'%INC indirect
                [PC,intmem_back,cycle,idatax_back]=IncUnd(PC,cycle,intmem_back,idatax_back,2);
                
            case 'A3'%INC DPTR
                [PC,intmem_back,cycle]=IncDPTR(PC,cycle,intmem_back);
                
            case '14' %DEC A
                [PC,intmem_back,cycle]=DecACC(PC,cycle,intmem_back);
                
            case '18' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,1);
            case '19' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,2);
            case '1A' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,3);
            case '1B' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,4);
            case '1C' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,5);
            case '1D' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,6);
            case '1E' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,7);
            case '1F' %DEC Rn
                [PC,intmem_back,cycle]=DecRn(PC,cycle,intmem_back,8);
                
            case '15' %DEC direct
                [PC,intmem_back,cycle]=DecDir(PC,cycle,intmem_back,promem);
                
            case '16' %DEC @Ri
                [PC,intmem_back,idatax_back,cycle]=DecUnd(PC,cycle,intmem_back,idatax_back,1);
            case '17' %DEC @Ri
                [PC,intmem_back,idatax_back,cycle]=DecUnd(PC,cycle,intmem_back,idatax_back,2);   
                
            case 'A4' %MUL A,B
                [PC,intmem_back,cycle]=MulAB(PC,cycle,intmem_back);
                
            case '84' %DIV A,B
                [PC,intmem_back,cycle]=DivAB(PC,cycle,intmem_back);
                
            case 'D4' %DA A
                [PC,cycle]=DataAdj(PC,cycle);
                
            
                
            case '58' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,1);
            case '59' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,2);
            case '5A' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,3);  
            case '5B' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,4);  
            case '5C' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,5);  
            case '5D' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,6);  
            case '5E' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,7);  
            case '5F' %ANL A,Rn
                [PC,cycle,intmem_back]=AnlACCReg(PC,cycle,intmem_back,8);
                
            case '55' %ANL direct
                [PC,cycle,intmem_back]=AnlDirToACC(PC,cycle,intmem_back,promem);
                
            case '56' %ANL A,@Ri
                [PC,cycle,intmem_back]=AnlUndToACC(PC,cycle,intmem_back,idatax_back,1);
            case '57' %ANL A,@Ri
                [PC,cycle,intmem_back]=AnlUndToACC(PC,cycle,intmem_back,idatax_back,2);
                
            case '54' %ANL A,#data
                [PC,cycle,intmem_back]=AnlDataToACC(PC,cycle,intmem_back,promem);
                
            case '52' %ANL direct,A
                [PC,cycle,intmem_back]=AnlACCToDir(PC,cycle,intmem_back,promem);
                
            case '53' %ANL direct,#data
                [PC,cycle,intmem_back]=AnlDataToDir(PC,cycle,intmem_back,promem);
                
            case '48' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,1);
            case '49' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,2);
            case '4A' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,3);  
            case '4B' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,4);  
            case '4C' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,5);  
            case '4D' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,6);  
            case '4E' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,7);  
            case '4F' %ORL A,Rn
                [PC,cycle,intmem_back]=OrlACCReg(PC,cycle,intmem_back,8);
            
            case '45' %ORL direct
                [PC,cycle,intmem_back]=OrlDirToACC(PC,cycle,intmem_back,promem);
                
            case '46' %ORL A,@Ri
                [PC,cycle,intmem_back]=OrlUndToACC(PC,cycle,intmem_back,idatax_back,1);
            case '47' %ORL A,@Ri
                [PC,cycle,intmem_back]=OrlUndToACC(PC,cycle,intmem_back,idatax_back,2);    
                
            case '44' %ORL A,#data
                [PC,cycle,intmem_back]=OrlDataToACC(PC,cycle,intmem_back,promem);
                
            case '42' %ORL direct,A
                [PC,cycle,intmem_back]=OrlACCToDir(PC,cycle,intmem_back,promem);   
                
            case '43' %ORL direct,#data
                [PC,cycle,intmem_back]=OrlDataToDir(PC,cycle,intmem_back,promem);
                
            case '68' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,1);
            case '69' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,2);
            case '6A' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,3);  
            case '6B' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,4);  
            case '6C' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,5);  
            case '6D' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,6);  
            case '6E' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,7);  
            case '6F' %XRL A,Rn
                [PC,cycle,intmem_back]=XrlACCReg(PC,cycle,intmem_back,8);
            
            case '65' %XRL direct
                [PC,cycle,intmem_back]=XrlDirToACC(PC,cycle,intmem_back,promem);
                
            case '66' %XRL A,@Ri
                [PC,cycle,intmem_back]=XorACCUnd(PC,cycle,intmem_back,idatax_back,1);
            case '67' %XRL A,@Ri
                [PC,cycle,intmem_back]=XorACCUnd(PC,cycle,intmem_back,idatax_back,2);
                
            case '64' %XRL A,#data
                [PC,cycle,intmem_back]=XrlDataToACC(PC,cycle,intmem_back,promem);
                
            case '62' %XRL direct,A
                [PC,cycle,intmem_back]=XrlACCToDir(PC,cycle,intmem_back,promem);   
                
            case '63' %XRL direct,#data
                [PC,cycle,intmem_back]=XrlDataToDir(PC,cycle,intmem_back,promem);
                
            case 'F4' %CPL A
                [PC,cycle,intmem_back]=CplACC(PC,cycle,intmem_back);
                
            case '23' %RL A
                [PC,cycle,intmem_back]=RotLeftACC(PC,cycle,intmem_back);
                
            case '33' %RLC A
                [PC,cycle,intmem_back]=RotcLeftACC(PC,cycle,intmem_back);
                
            case '03' %RR A
                [PC,cycle,intmem_back]=RotRightACC(PC,cycle,intmem_back);
                
            case '13' %RRC A
                [PC,cycle,intmem_back]=RotcRightACC(PC,cycle,intmem_back);
                
            case 'C4' %SWAP A
                [PC,cycle,intmem_back]=SwapACC(PC,cycle,intmem_back);
                
                
                
                
                
                
                
                
                
                
                
            case 'C3' %CLR C
                [PC,cycle,intmem_back]=ClearC(PC,cycle,intmem_back);
                
            case 'C2' %CLR bit
                [PC,cycle,intmem_back]=ClearBit(PC,cycle,intmem_back,promem);
                
            case 'D3' %SETB C
                [PC,cycle,intmem_back]=SETBC(PC,cycle,intmem_back);
            
            case 'D2' %SETB bit
                [PC,cycle,intmem_back]=SetBit(PC,cycle,intmem_back,promem);
                
            case 'B3' %CPL C
                [PC,cycle,intmem_back]=CPLC(PC,cycle,intmem_back);
                
            case 'B2' %CPL bit
                [PC,cycle,intmem_back]=CPLBit(PC,cycle,intmem_back,promem);
                
            case '82' %ANL C,bit
                [PC,cycle,intmem_back]=ANLCBit(PC,cycle,intmem_back,promem);
                
            case 'B0' %ANL C,/bit
                [PC,cycle,intmem_back]=ANLCUBit(PC,cycle,intmem_back,promem);
                
            case '72' %ORL C,bit
                [PC,cycle,intmem_back]=ORLCBit(PC,cycle,intmem_back,promem);
                
            case 'A0' %ORL C,/bit
                [PC,cycle,intmem_back]=ORLCUBit(PC,cycle,intmem_back,promem);
                
            case 'A2' %MOV C,bit
                [PC,cycle,intmem_back]=MOVCBit(PC,cycle,intmem_back,promem);
                
            case '92' %MOV bit,C
                [PC,cycle,intmem_back]=MOVBitC(PC,cycle,intmem_back,promem);
                
                
                
                
                
                
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