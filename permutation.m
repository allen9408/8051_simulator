function [PC_back,cycle_back,intmem_back,idatax_back]=permutation(PC,cycle,intmem,idatax)
	intmem_back=intmem;
	idatax_back=idatax;
    %intmem_back(8,1)=intmem(8,1)+1;
%     intmem_back(1,1)=225;
%     intmem_back(2,1)=192;
    %intmem_back(6,1)=7;

	tmp=zeros(8,1);
	tmp1=zeros(64,1);
    state=zeros(8,1);
	
    state=idatax(91:98);
    for i=0:63
        position=mod((16*i),63);
        if(i==63)
            position=63;
        end
        element_source=fix(i/8);
        bit_source=mod(i,8);
        element_destination=fix(position/8);
        bit_destination=mod(position,8);
        a=tmp(element_destination+1,1);
        b=bitand(fix(state(element_source+1,1)/(2^bit_source)),1);
        tmp(element_destination+1,1)=bitor(a,b*(2^bit_destination));
    end
    
    %i=91;j=7;
    
    
%     while (i<=98)
%         while(j>=0)
%             tmp(n,1)=mod(fix(idatax(i,1)/(2^j)),2);
%             j=j-1;
%             n=n+1;
%         end
%         i=i+1;
%         j=7;
%     end





% 	%permute
% 	tmp1(1,1)=tmp(1,1);
% 	tmp1(17,1)=tmp(2,1);
% 	tmp1(33,1)=tmp(3,1);
% 	tmp1(49,1)=tmp(4,1);
% 	tmp1(2,1)=tmp(5,1);
% 	tmp1(18,1)=tmp(6,1);
% 	tmp1(34,1)=tmp(7,1);
% 	tmp1(50,1)=tmp(8,1);
% 
% 	tmp1(3,1)=tmp(9,1);
% 	tmp1(19,1)=tmp(10,1);
% 	tmp1(35,1)=tmp(11,1);
% 	tmp1(51,1)=tmp(12,1);
% 	tmp1(4,1)=tmp(13,1);
% 	tmp1(20,1)=tmp(14,1);
% 	tmp1(36,1)=tmp(15,1);
% 	tmp1(52,1)=tmp(16,1);
% 
% 	tmp1(5,1)=tmp(17,1);
% 	tmp1(21,1)=tmp(18,1);
% 	tmp1(37,1)=tmp(19,1);
% 	tmp1(53,1)=tmp(20,1);
% 	tmp1(6,1)=tmp(21,1);
% 	tmp1(22,1)=tmp(22,1);
% 	tmp1(38,1)=tmp(23,1);
% 	tmp1(54,1)=tmp(24,1);
% 
% 	tmp1(7,1)=tmp(25,1);
% 	tmp1(23,1)=tmp(26,1);
% 	tmp1(39,1)=tmp(27,1);
% 	tmp1(55,1)=tmp(28,1);
% 	tmp1(8,1)=tmp(29,1);
% 	tmp1(24,1)=tmp(30,1);
% 	tmp1(40,1)=tmp(31,1);
% 	tmp1(56,1)=tmp(32,1);
% 
% 	tmp1(9,1)=tmp(33,1);
% 	tmp1(25,1)=tmp(34,1);
% 	tmp1(41,1)=tmp(35,1);
% 	tmp1(57,1)=tmp(36,1);
% 	tmp1(10,1)=tmp(37,1);
% 	tmp1(26,1)=tmp(38,1);
% 	tmp1(42,1)=tmp(39,1);
% 	tmp1(58,1)=tmp(40,1);
% 
% 	tmp1(11,1)=tmp(41,1);
% 	tmp1(27,1)=tmp(42,1);
% 	tmp1(43,1)=tmp(43,1);
% 	tmp1(59,1)=tmp(44,1);
% 	tmp1(12,1)=tmp(45,1);
% 	tmp1(28,1)=tmp(46,1);
% 	tmp1(44,1)=tmp(47,1);
% 	tmp1(60,1)=tmp(48,1);
% 
% 	tmp1(13,1)=tmp(49,1);
% 	tmp1(29,1)=tmp(50,1);
% 	tmp1(45,1)=tmp(51,1);
% 	tmp1(61,1)=tmp(52,1);
% 	tmp1(14,1)=tmp(53,1);
% 	tmp1(30,1)=tmp(54,1);
% 	tmp1(46,1)=tmp(55,1);
% 	tmp1(62,1)=tmp(56,1);
% 
% 	tmp1(15,1)=tmp(57,1);
% 	tmp1(31,1)=tmp(58,1);
% 	tmp1(47,1)=tmp(59,1);
% 	tmp1(63,1)=tmp(60,1);
% 	tmp1(16,1)=tmp(61,1);
% 	tmp1(32,1)=tmp(62,1);
% 	tmp1(48,1)=tmp(63,1);
% 	tmp1(64,1)=tmp(64,1);

% 	j=1;
% 	for i=1:8
% 		x(i,1)=tmp1(j,1)*128+tmp1(j+1,1)*64+tmp1(j+2,1)*32+tmp1(j+3,1)*16+tmp1(j+4,1)*8+tmp1(j+5,1)*4+tmp1(j+6,1)*2+tmp1(j+7,1);
% 		%idatax_back(i,1)=255;
%         j=j+8;
%     end
    for i=91:98
        idatax_back(i,1)=tmp(i-90,1);
    end

	%cycle count
	cycle_back=cycle+1;
	PC_back=PC+1;
end






