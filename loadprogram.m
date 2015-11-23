function [promem_back]=loadprogram(promem)

    fid=fopen('final_1.txt' ,'r');
    num_instruction=0;
    PC=1;
    promem_back=promem;
while(feof(fid)==0&&PC<=2^16)
    Instruction = dec2hex(bin2dec(fgetl(fid)),2);
    size_Instruction = size(Instruction,2);
    if(size_Instruction==2)
        promem_back(PC,1)=hex2dec(Instruction);
        num_instruction=num_instruction+1;
        PC=PC+1;
    elseif(size_Instruction==3)
        promem_back(PC,1)=hex2dec(Instruction(1));
        promem_back(PC+1,1)=hex2dec(Instruction(2:3));
        num_instruction=num_instruction+1;
        PC=PC+2;
    elseif(size_Instruction==4)
        promem_back(PC,1)=hex2dec(Instruction(1:2));
        promem_back(PC+1,1)=hex2dec(Instruction(3:4));
        num_instruction=num_instruction+1;
        PC=PC+2;
    elseif(size_Instruction==5)
        promem_back(PC,1)=hex2dec(Instruction(1));
        promem_back(PC+1,1)=hex2dec(Instruction(2:3));
        promem_back(PC+2,1)=hex2dec(Instruction(4:5));
        num_instruction=num_instruction+1;
        PC=PC+3;
    elseif(size_Instruction==6)
        promem_back(PC,1)=hex2dec(Instruction(1:2));
        promem_back(PC+1,1)=hex2dec(Instruction(3:4));
        promem_back(PC+2,1)=hex2dec(Instruction(5:6));
        num_instruction=num_instruction+1;
        PC=PC+3;
    %else disp('file input wrong');
    end
    assignin('base','promem',promem);
    
end